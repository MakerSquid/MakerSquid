const express = require('express');
const bodyParser = require('body-parser');
var Connection = require('tedious').Connection;
var Request = require('tedious').Request;  
var TYPES = require('tedious').TYPES;  

//const cors = require('cors');

const app = express();

var dbconfig = {
    userName: 'catsadmin',
    password: 'QLb1C14qwcBb',
    server: 'cats-data-test.database.windows.net',
    options: {encrypt: true, database: 'cats-data-test'}
}

var waitingForSql = true;

/*var corsOptions = {
    origin: '*',
    optionsSuccessStatus: 200 //204 has issues
};*/

var connection = new Connection(dbconfig);

connection.on('connect', function(err) {  
    // If no error, then good to proceed.  
    waitingForSql = false;
    console.log("Connected");  
});  
//prod: process.env.PORT, dev: 3200

app.listen(process.env.PORT, () => {
});

app.use(bodyParser.json());
//app.use(cors(corsOptions));

app.route('/api/cats').get((req, res) => {
    catsDataPending(res);
 });

function catsDataPending(res){
    if (waitingForSql) {
        setTimeout(catsDataPending, 1000, res);
    }

    fetchCats(res);
}

function catsDataComplete(res, result){
    //console.log(result);
    res.send(result);
}

app.route('/api/cats').post((req, res) => {
    res.send(201, req.body);
});

app.route('/api/cats/:name').get((req, res) => {
    const requestedCatName = req.params['name'];
    res.send({ name: requestedCatName});
});

app.route('/api/cats/:name').put((req, res) => {
    res.send(200, req.body);
})

app.route('/api/cats/:name').delete((req, res) => {
    res.sendStatus(204);
});


//data access
function fetchCats(res) {  
    var promise = new Promise(function(resolve, reject){

        var result = [];

        request = new Request("SELECT name FROM cats ORDER BY name;", function(err) {  
        if (err) {  
            console.log(err);}  
        });  

        request.on('row', function(columns) {  
            columns.forEach(function(column) {  
            if (column.value === null) {  
                console.log('NULL');  
            } else {  
                result.push({ name: column.value });  
            }  
            });  
        });  

        request.on('doneProc', function(rowCount, more) {  
            resolve(result);
        }); 

        connection.execSql(request);  
    });
    
    promise.then(function(result) {
        catsDataComplete(res, result);
    }, function(err) {
        console.log("fail");
        catsDataComplete(res, []);
    });
}  