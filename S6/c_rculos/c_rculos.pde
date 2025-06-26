int x; //<>// //<>// //<>//
int y = 70;

float radio;

void setup() {
  size(1000, 1000);
  background(255);
  noStroke();
  frameRate(10);
  //stroke(222);
}

void draw() {

  float numAleatorio = random (0, 1);
  radio = (numAleatorio * width /2 );

  fill(random(115), random(120), random(210), 20);
  ellipse(x, y, radio, radio);

  fill(random(75), random(100), random(210), 30);
  //fill(10,120, 145, 30);
  triangle(0, y, radio *2, y + radio, radio/2, y);

  x += 70;
  println(x);

  // Controlar dibujo en eje vertical

  if (x > width) {
    x = 0;
    y = y + 70;
  }

  // Controal dibujo en eje horizontal
  if (y > height) {
    background(255);
    y = 70;
  }
}
