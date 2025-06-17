//Inicializamos la variable para la posición x
int posX;
int posY;
int speedX = 1;
int speedY = 1;

void setup(){
  size(700, 700);
}

void draw(){
  background(255);
  
  posX = posX + speedX;
  //posX+= speedX; //más conciso, es lo mismo que el de arriba
  
  // condición 1   OR  condición 2
  if(posX >= width || posX <= 0) {
  speedX = speedX *-1;
  }
  posY = posY + speedY;
  //posX+= speedX; //más conciso, es lo mismo que el de arriba
  
  if(posY >= height || posY <= 0) {
  speedY = speedY *-1;
  }

  println(posX);
  
  fill(125, 167, 203);
  noStroke();
  ellipse(posX, 350, 50, 50); 
  
  fill(105, 137, 203);
  ellipse(350, posY, 50, 50);
  
  fill(95, 137, 167);
  ellipse(posX, posY, 50, 50);

}
