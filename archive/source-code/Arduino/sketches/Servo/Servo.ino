#include <Servo.h>

Servo myservo1;  // create servo object to control a servo
Servo myservo2;  // create servo object to control a servo
int pos = 0;    // variable to store the servo position
int del = 100; // delay in micoseconds
int xpos = 80;
int ypos = 0;
int laserPin = 4;

void setup()
{
  Serial.begin(9600);
  myservo1.attach(2);  // attaches the servo on pin 9 to the servo object
  myservo2.attach(3);  // attaches the servo on pin 9 to the servo object
  pinMode(laserPin, OUTPUT);
}

void loop()
{
    digitalWrite(laserPin, HIGH);
    //myservo1.write(90);
    //myservo2.write(90);
    myservo1.write(90);
    myservo2.write(ypos);
      
      xpos += 1;
      ypos += 1;
      
      if (ypos == 100)
      {
        //xpos = 80;
        ypos = 80;
        digitalWrite(laserPin, LOW);
      }
        
      //if (ypos == 100)
      //{
      //  ypos = 80;
      //}
        
      delay(100);
}

