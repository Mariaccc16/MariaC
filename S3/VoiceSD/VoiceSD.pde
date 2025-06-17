// Declarar la variable para la posición

int posX; // posición en X
int posY; // posición en Y
boolean FueraDelCanvas = false;

void setup(){
  size(700, 700);
}

void draw(){
  background(255);
  println(FueraDelCanvas);
  
  // Declaramos el valor de la variable x
  posX = posX + 3;
  
  //Declaramos el valor de la varaible Y
  //posY = posY + 3;
  
  if (posX > width){
    //FueraDelCanvas = true;
    //println(FueraDelCanvas);
    posX = posX - 3;
  }
  else {
  }
  
  // Color
  fill(125, 167, 203);
  // Contorno
  noStroke();
  
  ellipse(posX, 250, 50, 50); // Se mueve tanto en X como en Y
  
 
}
