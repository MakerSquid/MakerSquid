int state = HIGH;

void setup() {
  pinMode(3, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(13, INPUT);

}

void loop() {
  // put your main code here, to run repeatedly: 
   if (digitalRead(13)){
     if (state == HIGH)
     {
      state = LOW; 
     }
     else
     {
       state = HIGH;
     }   
   delay(200);
  }
   
  digitalWrite(3, state);
  digitalWrite(5, state);
  digitalWrite(6, state);
  digitalWrite(9, state);
  digitalWrite(10, state);
  digitalWrite(11, state);

}
