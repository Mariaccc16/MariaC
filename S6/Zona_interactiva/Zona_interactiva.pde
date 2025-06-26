// RANGO DE FRAMES POR SEGUNDO
//frameRate(19)

int diametro = 200;
float radio = diametro / 2 ;
float circunferencia = radio * TWO_PI;

int centroH;
int centroV;

void setup() {
  size(1000, 1000);
  centroH = width/2;
  centroV= height/2;
}

void draw() {
  //background(100, 100, 87);
  noStroke();

  float d = dist(mouseX, mouseY, centroH, centroV);

  if (d < radio) {
    fill( 200, 255, 120);
    println("Inicio zona interactiva");
  } else {
    fill(255);
  }

  translate(centroH, centroV);
  noFill();

  // Dibujar  diametro
  stroke(0);
  line(-radio, 0, radio, 0);

  //Radio
  stroke(255);
  line(0, 0, 0, radio);

  //Círculo
  stroke(0);
  ellipse(0, 0, diametro, diametro);
}
