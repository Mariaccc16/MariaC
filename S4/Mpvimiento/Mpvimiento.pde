void setup(){
  size(1000,1000);
  
}

void draw(){
  background(255);
  fill(255, 200, 40);
  noStroke();
  //ellipse(mouseX, mouseY, 100, 100); //se mueve a donde vaya el mouse
  //triangle(mouseX, mouseY, 100, 100, 500, 500); //se mueve solo la esquina con (mouseX/Y)
  rect(mouseX, 100, 120, 50); //solo se mueve horizontalmente
  rect(100, mouseY, 120, 50); //solo se mueve verticalmente
}
