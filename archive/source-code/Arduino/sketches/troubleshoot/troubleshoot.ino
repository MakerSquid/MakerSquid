  int delay_time = 500;
  
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
  int ground_plane = TOP_GROUND;

void setup() {                
  pinMode(PIN_1, OUTPUT);     
  pinMode(PIN_2, OUTPUT);     
  pinMode(PIN_3, OUTPUT);     
  pinMode(PIN_4, OUTPUT);     
  pinMode(PIN_5, OUTPUT);     
  pinMode(PIN_6, OUTPUT);     
  pinMode(PIN_7, OUTPUT);     
  pinMode(PIN_8, OUTPUT);     
  pinMode(PIN_9, OUTPUT);     
  pinMode(BOTTOM_GROUND, OUTPUT);     
  pinMode(MIDDLE_GROUND, OUTPUT);     
  pinMode(TOP_GROUND, OUTPUT);     
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
  
  digitalWrite(PIN_8, HIGH);  
  delay(delay_time); 
}
