// Inicializamos las variables

int numBubbles = 20;

float[] xPositions; // esos corchetes son para crear un array -> "armario" de variables
float[] yPositions;

float[] speedX;
float[] speedY;

int[] directionX;
int[] directionY;

void setup() {
  size (700, 700);
  background(0);
  noStroke();

  // Definimos el tamaño del array
  xPositions = new float[numBubbles];
  yPositions = new float[numBubbles];

  speedX = new float[numBubbles];
  speedY = new float[numBubbles];

  directionX = new int [numBubbles];
  directionY = new int [numBubbles];

  // Creamos los valores
  for (int i= 0; i < xPositions.length; i++) {
    xPositions[i] = random(width);
    yPositions[i] = random(height);
    speedX[i] = random(5);
    speedY[i] = random(5);
    directionX[i] = (random(1)> 0.5) ? 1 : -1;
    directionY[i] = (random(1)> 0.5) ? 1 : -1;

    //println(directionX[i]);
  }
}

void draw() {
  background(255);

  for (int i= 0; i < numBubbles; i++) {

    fill(random(5, 255), random(100, 230), random(125, 70));
    ellipse(xPositions[i], yPositions[i], 50, 50);

    xPositions[i] = xPositions[i] + speedX[i] * directionX[i];
    yPositions[i] = yPositions[i] + speedY[i] * directionY[i];

    // Rebote cuando llega al extremo derecho O al extremo izquierdo
    if (xPositions[i] >= width               || xPositions[i] <= 0) {
      directionX[i] = directionX[i] * -1;
    }

    // Rebote cuando llega arriba O abajo
    if (yPositions[i] >= height  || yPositions[i] <= 0) {
      directionY[i] = directionY[i] * -1;
    }
  }
}
