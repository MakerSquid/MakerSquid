// set pin numbers:
const int led1 =  10;      
const int led2 =  12;      
const int led3 =  11;      
const int led4 =  9;      
const int led5 =  8;      
const int led6 =  7;      
const int buttonPin = 13;       

long previousMillis = 0;        // will store last time LED was updated
int currentState = 0;
bool increasing = true;
bool increasingInterval = true;

long interval = 50;           // interval at which to blink (milliseconds)

void setup() {
  // set the digital pin as output:
  pinMode(led1, OUTPUT);      
  pinMode(led2, OUTPUT);      
  pinMode(led3, OUTPUT);      
  pinMode(led4, OUTPUT);      
  pinMode(led5, OUTPUT);      
  pinMode(led6, OUTPUT);      
  pinMode(buttonPin, INPUT);
}

void loop()
{
  unsigned long currentMillis = millis();
 
  if(currentMillis - previousMillis > interval) {
    // save the last time you blinked the LED 
    previousMillis = currentMillis;   
  if (digitalRead(buttonPin))
  {
    if (increasingInterval)
    {
     if (interval <= 500)
     {
      interval += 50; 
     }
     else
     {
      interval -= 50;
     increasingInterval = false; 
     }
    }
    else
    {
      if (interval >= 100)
      {
      interval -= 100; 
      }
      else
      {
       interval += 100;
      increasingInterval = true; 
      }
    }
  }

    // if the LED is off turn it on and vice-versa:
    if (currentState == 0)
    {
      setState(HIGH, LOW, LOW, LOW, LOW, LOW);
      setCurrentState();
    }    
    else if (currentState == 1)
    {
      setState(LOW, HIGH, LOW, LOW, LOW, LOW);
      setCurrentState();
    }
    else if (currentState == 2)
    {
      setState(LOW, LOW, HIGH, LOW, LOW, LOW);
      setCurrentState();
    }
    else if (currentState == 3)
    {
      setState(LOW, LOW, LOW, HIGH, LOW, LOW);
      setCurrentState();
    }
    else if (currentState == 4)
    {
      setState(LOW, LOW, LOW, LOW, HIGH, LOW);
      setCurrentState();
    }
    else if (currentState == 5)
    {
      setState(LOW, LOW, LOW, LOW, LOW, HIGH);
      setCurrentState();
    }
  }
}
  
  void setState(int led1State, int led2State, int led3State, int led4State, int led5State, int led6State)
  {
   digitalWrite(led1, led1State);
   digitalWrite(led2, led2State);
   digitalWrite(led3, led3State);
   digitalWrite(led4, led4State);
   digitalWrite(led5, led5State);
   digitalWrite(led6, led6State);
  }
  
  void setCurrentState()
  {
    if (increasing)
    {
      if (currentState <= 4)
      {
        currentState++;
      }
      else
      {
        increasing = false;
        currentState--;
      } 
    }
    else
    {
      if (currentState >= 1)
      {
         currentState--; 
      }
      else
      {
       increasing = true;
        currentState++; 
      }
    }
  }

