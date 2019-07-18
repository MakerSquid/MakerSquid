// set pin numbers:
const int pin1 =  8;      
const int pin2 =  9;      
const int pin3 =  10;
const int pin4 = 11;

const int minDelay = 1;
const int maxDelay = 1000;

int interval = 50;
int currentPin = 1;

long time = 0;
long wait = 10000;
    
void setup() {
  time = millis();
  Serial.begin(9600);
  randomSeed(analogRead(0));
  interval = random(minDelay, maxDelay);
}

void loop() {
  
  currentPin = cyclePins(currentPin); 
  delay(interval);
  
  if (millis() - time > wait) {
    interval = random(minDelay, maxDelay);
    time = millis();
  }
}

int cyclePins(int currentPin) {
  
  if (currentPin == 1) {
    turnOn(pin1, pin2); 
  }
  else if (currentPin == 2) {
    turnOn(pin2, pin3); 
  }
  else if (currentPin == 3) {
    turnOn(pin1, pin3); 
  }
  else if (currentPin == 4) {
    turnOn(pin3, pin4);
  } 
  else if (currentPin == 5) {
    turnOn(pin2, pin4);
  } 
  else if (currentPin == 6) {
    turnOn(pin1, pin4);
  } 
  else if (currentPin == 7) {
    turnOn(pin4, pin1);
  } 
  else if (currentPin == 8) {
    turnOn(pin4, pin2);
  } 
  else if (currentPin == 9) {
    turnOn(pin4, pin3);
  } 
  else if (currentPin == 10) {
    turnOn(pin3, pin1);
  } 
  else if (currentPin == 11) {
    turnOn(pin3, pin2);
  } 
  else if (currentPin == 12) {
    turnOn(pin2, pin1);
     currentPin = 0;
  } 
 
  return ++currentPin;
}

void turnOn(int pinHigh, int pinLow) {
  
  //turn off all pins
  pinMode(pin1, INPUT);
  pinMode(pin2, INPUT);
  pinMode(pin3, INPUT);
  pinMode(pin4, INPUT);
  //turn on output pins
  pinMode(pinHigh, OUTPUT);
  pinMode(pinLow, OUTPUT);
  
  digitalWrite(pinHigh, HIGH);
  digitalWrite(pinLow,LOW);  
}
  

