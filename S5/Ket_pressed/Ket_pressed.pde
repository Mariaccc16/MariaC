int size =200;
 int centroH;
 int centroV;
 
 void setup() {
   size (1000, 1000);
   centroH = width/2;
   centroV = height/2;
 }
 
 void draw(){
   background (150, 150, 200);
   noStroke();
   
   if((keyPressed == true) && ((key == 'd') || (key == 'A'))){
     fill (45, 80, 50);
     println("inicio zona interactiva");
   }
     else {
    fill(255);
  }
   


  // interpreta X, Y como putno centro de la figura
  rectMode(CENTER);
  rect(centroH, centroV, size, size);
}
   
