
var gameWidth = window.innerWidth - 30;
var gameHeight = window.innerHeight - 100;
var cratesDelivered = 0;
var maxCrateX = gameWidth - 240;
var x = 100;
var y = 100;
var xx = 400;
var yy = 200;
var xPos = 0;
var yPos = 0;
var crateX = 0;
var crateY = 0;
var crateIsDropping = false;
var randomNum = getRandomInt(30, maxCrateX);
var showFlash = false;
var calledFlashHider = false;
//
function setup() {
	createCanvas(gameWidth, gameHeight);//Setsup gmae
}

function draw() {
	background(94, 185, 255);
	background(94, 185, 255);

	drawBackGround();

	drawAAGun();
	drawPlane();
	drawCrate();
	drawContainer();

	handleKeys();

	collisionDetectionCrate();
	collisionDetectionPlane();
	text('Score : '+cratesDelivered,100, 100)
}

function collisionDetectionPlane() {
//this function detects when the bullet passes over the plane
	var hit = collidePointRect(xPos, yPos, xx, yy, 200, 30);
	if (hit) {//this hit detects when a certain set of cordinates passes over a rectangle of space.
		window.location.href = "gameoverscreen.html"
	}//If the bullet hits the plane, then the game resets ^
}

function drawBackGround() {
	fill('gray')
strokeWeight(0);
//ground
rect(0,gameHeight-20,1900,40)
//This function draws the Clouds and buildings within my game.
//clouds
fill(255,255,255);
ellipse(90,170,30,30);
ellipse(80,160,30,30);
ellipse(90,140,30,30);
ellipse(130,160,30,30);
ellipse(110,160,30,30)
ellipse(110,175,30,30);
ellipse(110,140,30,30)
ellipse(90,160,30,30)
ellipse(130,140,30,30)
ellipse(150,150,30,30)
//cloud 2
ellipse(450,220,30,30)
ellipse(420,200,30,30)
ellipse(410,215,30,30)
ellipse(470,230,30,30)
ellipse(450,230,30,30)
ellipse(430,230,30,30)
ellipse(450,190,30,30)
ellipse(430,195,30,30)
ellipse(430,220,30,30)
ellipse(450,210,30,30)
ellipse(460,210,30,30)

//building1
fill(216, 73, 73);
rect(700,gameHeight - 180,140,160)//game height is the height of the canvas.
fill('gray');
//windows
strokeWeight(1);
rect(720,gameHeight - 170,20,30)
rect(760,gameHeight - 170,20,30)
rect(800,gameHeight - 170,20,30)
rect(720,gameHeight - 120,20,30)
rect(760,gameHeight - 120,20,30)
rect(800,gameHeight - 120,20,30)
rect(700,gameHeight - 180,139,5)

//building2
strokeWeight(1)
rect(850,gameHeight - 220,323,200)
//windows
fill('white')
rect(880,gameHeight - 170,20,30)
rect(940,gameHeight - 170,20,30)
rect(1000,gameHeight - 170,20,30)
rect(1060,gameHeight - 170,20,30)
rect(1120,gameHeight - 170,20,30)
rect(880,gameHeight - 110,20,30)
rect(940,gameHeight - 110,20,30)
rect(1000,gameHeight - 110,20,30)
rect(1060,gameHeight - 110,20,30)
rect(1120,gameHeight - 110,20,30)
//buidling3
fill('lightblue')
rect(1200,gameHeight - 200,150,180)
//cloud
strokeWeight(0)
fill('white')
ellipse(800,300,50,50)
ellipse(830,310,50,50)
ellipse(820,290,50,50)
ellipse(850,300,50,50)

ellipse(1200,200,50,50)
ellipse(1230,210,50,50)
ellipse(1220,190,50,50)
ellipse(1250,200,50,50)

}
function handleKeys(){//function handle keys is used to detect if a certain key is down.
	if (keyIsDown(83)) {//83 is W. If W is pressed the plane moves up.
		yy += 5;
	}
	if (keyIsDown(87)) {//87 is S. If S is pressed the plane moves down.
		yy -= 5;
	}
	if (keyIsDown(65)) {//65 is A. If A is pressed the plane moves left.
		xx -=5;
		
			
	}
	if (keyIsDown(68)) {//68 is D. If D is pressed the plane moves right.
		xx += 5;
	}
	//crate
	if (keyIsDown(32)) {//This IF statement is for dropping the crate. 
		if (!crateIsDropping) {
			dropCrate();//If you press 32(space) the it detects if the the crate is not dropping, then it run the drop crate. If it is running/dropping, this command does nothing ( To prevent spam )
		}
	}

	//limit flight
	if (yy > gameHeight - 260) {//These different if statements detect if the plane moves out of the play area.
		yy = gameHeight - 260;
		//alert('Warning, you are flying too low!');
	}
	if (yy < 30) {
		yy = 30;
		//alert('Warning, you are leaving the area!');
	}

	if (xx < 50) {
		xx = 50;
		//alert('Warning, you are leaving the area!');
	}
	if (xx > gameWidth - 242) {
		xx = gameWidth - 242;
		//alert('Warning, you are leaving the area!');
	}
}

function drawPlane() {
//Function drawPlane is used to create the plane when the game starts up.
	stroke('lightgray')
	fill('lightgray');
	rect(xx - 30, yy, 230, 30);
	rect(xx + 150, yy - 10, 30, 30);
	triangle(xx + 150, yy - 10, xx + 150, yy, xx + 120, yy); // var xx and yy are the cordinates of the plane controlled by WASD.
	triangle(xx + 180, yy - 10, xx + 180, yy, xx + 200, yy);
	ellipse(xx + 190, yy + 16, 100, 29);
	triangle(xx - 50, yy - 30, xx - 50, yy, xx, yy);
	triangle(xx - 30, yy + 30, xx - 50, yy, xx - 30, yy);

	fill('#5EB9FF');
	rect(xx + 150, yy - 10, 30, 10);
stroke('black')
	fill('lightgray');
	triangle(xx + 20, yy + 55, xx + 150, yy + 13, xx + 23, yy + 13);


}

function drawAAGun() {//this function draws the AA gun onto the game.
	fill('gray');

	strokeWeight(1);
	quad(150, gameHeight - 60, 155, gameHeight - 60, 130, gameHeight - 20, 125, gameHeight - 20); //leg
	quad(180, gameHeight - 60, 185, gameHeight - 60, 210, gameHeight - 20, 205, gameHeight - 20); //leg
	rect(145, gameHeight - 62, 45, 10); //body
	rect(152.5, gameHeight - 80, 30, 20); //body

	triangle(162.5, gameHeight - 95, 162.5, gameHeight - 80, 182.5, gameHeight - 80);
	strokeWeight(1);

	quad(137.5, gameHeight - 83, 137.5, gameHeight - 78, 310.5, gameHeight - 165, 310.5, gameHeight - 168); //barrel
	quad(137.5, gameHeight - 85, 137.5, gameHeight - 75, 200.5, gameHeight - 105, 200.5, gameHeight - 115); //barrel
	ellipse(xPos, yPos, 2, 2); //bullet

	if (showFlash) {//This draws the small circle that acts as a muzzle flash.
		fill('orange');
		ellipse(xPos, yPos, 10, 10); //flash

		if (!calledFlashHider) {
			setTimeout(hideMuzzleFlash, 100);//This is how long the muzzle flash lasts, 100 milliseconds.
		}
		calledFlashHider = true;//Stops flash
		fill('gray');
	}

	if (yPos > 0) {//resets the bullet when it runs out of the area.
		xPos += 10;
		yPos -= 4;
	} else {
		initBulletCoords();
	}
}

function initBulletCoords() {// This function is the track that the bullet will take. It starts at  x 313, and 800 - 167. It sets the muzzle flash to false.
	xPos = 313;
	yPos = gameHeight - 167;
	showFlash = true;
	calledFlashHider = false;
}

function hideMuzzleFlash() {
	showFlash = false;//When the AA gun shoots, it will also run hideMuzzleFlash which turns off the flash.
}

function getRandomInt(min, max) {
	return Math.floor(Math.random() * (max - min + 1)) + min;//This fuction generates a random number that is used as a varable for the container.

}

function dropCrate() {//function drop crate resets the crate everytime it scores.
	console.log("dropping crate");
	crateX = xx;
	crateY = yy;
	crateIsDropping = true;
}

function drawCrate() {
	if (crateIsDropping) {//When you press space it detects if !crateIsDropping(not running) If it isn't running it runs this function.
		fill('#C9891B')//If the crate is dropping, it draws the crate and it constantly moves downwards.
        strokeWeight(1)
			rect(crateX, crateY+10, 40, 40)
			//parachute
		line(crateX,crateY+10,crateX-30,crateY-30)
		line(crateX+40,crateY+10,crateX+70,crateY-30)
		fill('green')
		ellipse(crateX+20,crateY-30,100,20)
		//crate design
      line(crateX,crateY+10,crateX+40,crateY+45)
      line(crateX+40,crateY+10,crateX,crateY+45)
      fill('white')
		crateY += 5;

		if (crateY >= gameHeight - 30) {//this detects if the crate is below the map, and if so it resets.
			stopCrate();
		}
	}
}

function drawContainer() {//Function drawContainer creates the container. 
	fill('white');
	strokeWeight(0);
	rect(randomNum, gameHeight - 25, 100, 10);
	rect(randomNum, gameHeight - 50, 10, 30);
	rect(randomNum + 90, gameHeight - 50, 10, 30);//Random num makes the crate teleport everytime you score.
}

function collisionDetectionCrate() {//this function detects if the crate lands in the container
	var hit = collidePointRect(crateX, crateY, randomNum, gameHeight - 50, 200, 200);//This variable is the position of the crate.

	if (hit) {//this if statement detects if the crate coords are in the container, then you score a point.
		cratesDelivered++;
		stopCrate();
		randomNum = getRandomInt(30, maxCrateX); //move containerd elsewhere
	}
}


function stopCrate() {//When you press space, the fuction detects if it is running. If not it runs. Once the command finishes this function runs stopping the crate from moving.
		crateX = xx;
		crateY = yy;
		crateIsDropping = false;
}

