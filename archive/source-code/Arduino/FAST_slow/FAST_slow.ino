// Arduino 7 segment display example software
// http://www.hacktronics.com/Tutorials/arduino-and-7-segment-led.html
// License: http://www.opensource.org/licenses/mit-license.php (Go crazy)
 
 
 int segmentA = 2;
 int segmentB = 3;
 int segmentC = 4;
 int segmentD = 5;
 int segmentE = 6;
 int segmentF = 7;
 int segmentG = 8;
 int dp = 9;
 
// Define the LED digit patters, from 0 - 9
// Note that these patterns are for common cathode displays
// For common anode displays, change the 1's to 0's and 0's to 1's
// 1 = LED on, 0 = LED off, in this order:
// Arduino pin: 2,3,4,5,6,7,8
byte seven_seg_digits[2][7] = { { 1,0,1,1,0,1,1 },  // = S
                                { 1,0,0,0,1,1,1 }   // = F
                                };

void setup() {                
  pinMode(segmentA, OUTPUT);   
  pinMode(segmentB, OUTPUT);
  pinMode(segmentC, OUTPUT);
  pinMode(segmentD, OUTPUT);
  pinMode(segmentE, OUTPUT);
  pinMode(segmentF, OUTPUT);
  pinMode(segmentG, OUTPUT);
  pinMode(dp, OUTPUT);
  writeDot(0);  // start with the "dot" off
}

void writeDot(byte dot) {
  digitalWrite(dp, dot);
}
    
void sevenSegWrite(byte digit) {
  byte pin = 2;
  for (byte segCount = 0; segCount < 7; ++segCount) 
  {
    digitalWrite(pin, seven_seg_digits[digit][segCount]);
    ++pin;
  }
}

void loop() {
  for (byte count = 0; count < 2; count++) 
  {
   sevenSegWrite(count); 
   delay(30000);
  }
}
 
