// RANGO DE FRAMES POR SEGUNDO
//frameRate(19)


int size = 200;

int centroH;
int centroV;

int posBordeSuperior;
int posBordeInferior;
int posBordeDerecho;
int posBordeIzquierdo;


void setup() {
  size(1000, 1000);
  centroH = width/2;
  centroV= height/2;
}

void draw() {
  background(100, 100, 87);
  noStroke();

  posBordeSuperior =  centroV - (size/2);
  posBordeInferior =  centroV + (size/2);
  posBordeIzquierdo =  centroH - (size/2);
  posBordeDerecho = centroH + (size/2);

  //println(posBordeSuperior);

  if (mouseX > posBordeIzquierdo
    && mouseX < posBordeDerecho
    && mouseY > posBordeSuperior
    && mouseY < posBordeInferior) {
    fill( 200, 255, 120);
    println("Inicio zona interactiva");
  } else {
    fill(255);
  }


  // interpreta X, Y como putno centro de la figura
  rectMode(CENTER);
  rect(centroH, centroV, size, size);
}
