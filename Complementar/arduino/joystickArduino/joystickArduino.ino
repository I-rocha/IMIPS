const int inX = A0;
const int inY = A1;
const int inPressed = 2;
const int HIGHSPEED = 600;
const int LOWSPEED = 200;

int cursorSpeed = 0;
int alt = 0;
int timer = millis();
int xValue = 0;
int yValue = 0;
int notPressed = 0;

void setup() {
  pinMode(inX, INPUT);
  pinMode(inY, INPUT);
  pinMode(inPressed, INPUT_PULLUP);

  Serial.begin(9600);
  Serial.println("Started");
}

void loop() {
  xValue = analogRead(inX);
  yValue = analogRead(inY);
  notPressed = digitalRead(inPressed);

  if(millis() - timer >= 3000) {
    cursorSpeed = (cursorSpeed == HIGHSPEED)? LOWSPEED : HIGHSPEED;
    timer = millis();
  }
  
  Serial.write(0xAA);
  Serial.write(0xAA);

  Serial.write(yValue & 0xFF);
  Serial.write((yValue >> 8) & 0x03);
  
  Serial.write(xValue & 0xFF);        // LSB
  Serial.write((xValue >> 8) & 0x03);  // MSB

  Serial.write(notPressed & 0x01);
  delay(100);
  
  /*
  Serial.print("X: ");
  Serial.print(xValue);
  Serial.print("\tY: ");
  
  Serial.print(yValue);
  Serial.print("\n");
  delay(1000);
  */
  
}
