  int delay_time = 1;
  
  int PIN_1 = 11;
  int PIN_2 = 10;
  int PIN_3 = 9;
  int PIN_4 = 8;
  int PIN_5 = 0;
  int PIN_6 = 7;
  int PIN_7 = 6;
  int PIN_8 = 5;
  int PIN_9 = 4;
  
  int BOTTOM_GROUND = 3;
  int MIDDLE_GROUND = 2;
  int TOP_GROUND = 1;
  int ground_plane = BOTTOM_GROUND;

void setup() {                
  // initialize the digital pin as an output.
  // Pin 13 has an LED connected on most Arduino boards:
  pinMode(PIN_1, OUTPUT);     
  pinMode(PIN_2, OUTPUT);     
  pinMode(PIN_3, OUTPUT);     
  pinMode(PIN_4, OUTPUT);     
  pinMode(PIN_5, OUTPUT);     
  pinMode(PIN_6, OUTPUT);     
  pinMode(PIN_7, OUTPUT);     
  pinMode(PIN_8, OUTPUT);     
  pinMode(PIN_9, OUTPUT);     
}

void loop() {
  
  if (ground_plane == BOTTOM_GROUND)
  {
    pinMode(MIDDLE_GROUND, INPUT);
    pinMode(TOP_GROUND, INPUT);
    
    pinMode(BOTTOM_GROUND, OUTPUT);  
    digitalWrite(BOTTOM_GROUND, LOW);
    
    ground_plane = MIDDLE_GROUND;
  }
   else if (ground_plane == MIDDLE_GROUND)
  {
    pinMode(BOTTOM_GROUND, INPUT);  
    pinMode(TOP_GROUND, INPUT);
    
    pinMode(MIDDLE_GROUND, OUTPUT);
    digitalWrite(MIDDLE_GROUND, LOW);
    
    ground_plane = TOP_GROUND;
  }
  else if (ground_plane == TOP_GROUND)
  {
    pinMode(BOTTOM_GROUND, INPUT);
    pinMode(MIDDLE_GROUND, INPUT);
    
    pinMode(TOP_GROUND, OUTPUT);
    digitalWrite(TOP_GROUND, LOW);
    
    ground_plane = BOTTOM_GROUND;
  }
  
  digitalWrite(PIN_9, LOW);    
  digitalWrite(PIN_1, HIGH);   
  delay(delay_time);              
  digitalWrite(PIN_1, LOW);    
  digitalWrite(PIN_2, HIGH);    
  delay(delay_time);              
  digitalWrite(PIN_2, LOW);    
  digitalWrite(PIN_3, HIGH);    
  delay(delay_time);              
  digitalWrite(PIN_3, LOW);    
  digitalWrite(PIN_4, HIGH);    
  delay(delay_time);              
  digitalWrite(PIN_4, LOW);    
  digitalWrite(PIN_5, HIGH);    
  delay(delay_time);              
  digitalWrite(PIN_5, LOW);    
  digitalWrite(PIN_6, HIGH);    
  delay(delay_time);              
  digitalWrite(PIN_6, LOW);    
  digitalWrite(PIN_7, HIGH);    
  delay(delay_time);              
  digitalWrite(PIN_7, LOW);    
  digitalWrite(PIN_8, HIGH);    
  delay(delay_time);              
  digitalWrite(PIN_8, LOW);    
  digitalWrite(PIN_9, HIGH);    
  delay(delay_time);       
}
