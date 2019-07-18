// set pin numbers:
const int ledPinRed =  10;      // the number of the LED pin
const int ledPinGreen =  11;      // the number of the LED pin
const int ledPinYellow =  12;      // the number of the LED pin
const int buttonPin = 13;       
const int RED = 1;
const int GREEN = 2;
const int YELLOW = 3;

int ledStateRed = LOW;             // ledState used to set the LED
int ledStateGreen = LOW;             // ledState used to set the LED
int ledStateYellow = LOW;             // ledState used to set the LED
long previousMillis = 0;        // will store last time LED was updated
int currentState = RED;
bool slowingDown = true;
int state = 0;      

long interval = 100;           // interval at which to blink (milliseconds)

void setup() {
  // set the digital pin as output:
  pinMode(ledPinRed, OUTPUT);      
  pinMode(ledPinGreen, OUTPUT);      
  pinMode(ledPinYellow, OUTPUT);      
  pinMode(buttonPin, INPUT);
}

void loop()
{
  unsigned long currentMillis = millis();
 
  if(currentMillis - previousMillis > interval) {
    // save the last time you blinked the LED 
    previousMillis = currentMillis;   

    // if the LED is off turn it on and vice-versa:
    if (currentState == RED)
    {
      currentState = GREEN;
      ledStateRed = LOW;
      ledStateGreen = HIGH;
      ledStateYellow = LOW;
    }    
    else if (currentState == GREEN)
    {
      currentState = YELLOW;
      ledStateRed = LOW;
      ledStateGreen = LOW;
      ledStateYellow = HIGH;
    }
    else if (currentState == YELLOW)
    {
      currentState = RED;
      ledStateRed = HIGH;
      ledStateGreen = LOW;
      ledStateYellow = LOW;
    }

  if (digitalRead(buttonPin)){
   if (state == 0)
  {
    state = 1;
  } 
  else
  {
   state = 0; 
  }
    
    
  }
    // set the LED with the ledState of the variable:
    if (state == 0)
    {
    digitalWrite(ledPinGreen, ledStateGreen);
    digitalWrite(ledPinYellow, ledStateYellow);
    digitalWrite(ledPinRed, ledStateRed);
    }
    else if (state == 1)
    {
    digitalWrite(ledPinRed, ledStateRed);
    digitalWrite(ledPinYellow, ledStateYellow);
    digitalWrite(ledPinGreen, ledStateGreen);
    }
     
    if ((slowingDown == false) || (interval >= 410))
    {
      interval = interval - 10;
      slowingDown = false;//continue speeding up or start speeding up
    }
    
    if ((slowingDown == true) || (interval <= 90))
    {
      interval = interval + 10;
      slowingDown = true; //continue slowing down, or start slowing down
    }
  }
}

