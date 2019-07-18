
int redPin = 10;         
int yellowPin = 12;         
int greenPin = 11;         
int buttonPin = 13;       

int state = 0;      

void setup()
{
  pinMode(redPin, OUTPUT);
  pinMode(yellowPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(buttonPin, INPUT);
      setLights(HIGH, LOW, LOW);
}

void loop()
{
  if (digitalRead(buttonPin)){
    if (state == 0)
    {
      setLights(HIGH, LOW, LOW);
      state = 1;
    }
    else if (state == 1)
    {
      setLights(LOW, LOW, HIGH);
      state = 2;
    }
    else if (state == 2)
    {
      setLights(LOW, HIGH, LOW);
      state = 0;
    }
    
    delay(200);
  }
}

void setLights(int red, int yellow, int green)
{
  digitalWrite(redPin, red);
  digitalWrite(yellowPin, yellow);
  digitalWrite(greenPin, green);
}
