float gravity = -9.8;
float textOffset = 10;
float unitSize = 10;

void setup(){
  size(400, 400);
}

void draw(){
  PVector velocity = velocity(height - mouseY);
  background(30);
  stroke(200, 40, 120);
  strokeWeight(5);
  line(velocity.x, height - 1 - velocity.y, 0, height - 1);
  drawShot(velocity);
  noFill();
  strokeWeight(3);
  stroke(255);
  line(mouseX, height - 1, 0, height - 1);
  line(mouseX, mouseY, mouseX, height);
  textAlign(CENTER);
  textSize(30);
  text(oneDecimal(mouseX / unitSize) + "m", 
    mouseX / 2, height - 1 - textOffset);
  text(oneDecimal((height - 1 - mouseY) / unitSize) + "m", 
    mouseX - textOffset - 40, height + (mouseY - height) / 2);
    
  text("v: " + oneDecimal(velocity.mag() / unitSize) + "m/s", 
    width / 2, textOffset + 15);
  text("θ: " + oneDecimal(acos(velocity.copy().normalize().x) * 180 / PI) + "°", 
    width / 2, textOffset + 45);
}

String oneDecimal(float f){
  return floor(f) + "." + floor((f - floor(f)) * 10);
}

void drawShot(PVector vel)
{
  float downSize = 5;
  float x = 0, y = 0;
  float velX = vel.x, velY = vel.y;
  for(int i = 0; i < 100; i++){
    x += velX / downSize;
    y += velY / downSize;
    velY += gravity / downSize;
    
    noStroke();
    fill(255);
    circle(x, height - 1 - y, max(5 - i * 0.05, 0));
  }
}


PVector velocity(float h){
  float yOffset = height - 1 - mouseY;
  float xOffset = mouseX;
  
  float velY = sqrt(-2 * gravity * h);
  float velX = xOffset / (sqrt(-2 * h/gravity) + sqrt(2 * (yOffset - h) / gravity));
  
  return new PVector(velX, velY);
}
