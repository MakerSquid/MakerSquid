
int VDD=53; 
int VL=51;
int Enable = 45;
int BLA=27;
int BLK=25;

int DI = 49;
int RW = 47;
int DB[] = {43, 41, 39, 37, 35, 33, 31, 29};


void LcdCommandWrite(int value) {

int i = 0;
for (i=DB[0]; i >= DB[7]; i=i-2) 
{
   digitalWrite(i,value & 01);
   value >>= 1;
}
digitalWrite(RW,value & 01);
value>>=1;
digitalWrite(DI,value & 01);
value>>=1;

digitalWrite(Enable,LOW);
delayMicroseconds(1);
digitalWrite(Enable,HIGH);
delayMicroseconds(1);  
digitalWrite(Enable,LOW);
delayMicroseconds(1);  
}

void LcdDataWrite(int value) {

int i = 0;
digitalWrite(DI, HIGH);
digitalWrite(RW, LOW);
for (i=DB[0]; i >= DB[7]; i=i-2) {
   digitalWrite(i,value & 01);
   value >>= 1;
}
digitalWrite(Enable,LOW);
delayMicroseconds(1);
digitalWrite(Enable,HIGH);
delayMicroseconds(1);
digitalWrite(Enable,LOW);
delayMicroseconds(1);  
}

void LcdDataWriteString(char *pData)
{
  while(*pData)
  {
    LcdDataWrite(*pData++);
  }
}


void setup (void) {
int i = 0;
for (i=BLK; i <= VDD; i=i+2) {
   pinMode(i,OUTPUT);
}
  digitalWrite(VDD,HIGH);
  digitalWrite(BLA,HIGH);
  digitalWrite(BLK,LOW);
  digitalWrite(VL,LOW);
delay(100);

LcdCommandWrite(0x38);                   
delay(64);                      
LcdCommandWrite(0x38);                     
delay(50);                      
LcdCommandWrite(0x38);                       
delay(20);                      
LcdCommandWrite(0x06); 
                         
delay(20);                      
LcdCommandWrite(0x0E);  
                         
delay(20);                      
LcdCommandWrite(0x01);  
delay(100);                      
LcdCommandWrite(0x80);  
                         
delay(20);                      
}

void loop (void) {
  LcdCommandWrite(0x01);  
  delay(10); 
  LcdCommandWrite(0x80+3); 
  delay(10);                     
 
LcdDataWriteString("welcome to ");
  delay(3000);
  LcdCommandWrite(0x01); 
  delay(5);
  LcdDataWriteString("sainsmart store");
  delay(5000);
}
