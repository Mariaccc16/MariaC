// Nombre: María Camila Serrato Restrepo
// Código: 202410329
// Título: E02 – Repetición/Teselado

void setup() {
  size(640, 640);
  background(245);
}

int tam = 80;

void draw() {
  
  for (int x = 0; x <= width; x += tam) {
  for (int y = 0; y <= height; y += tam) {

      noStroke();

      // Rectángulo de fondox
      fill(245, 247, 220);
      rect(x, y, tam, tam);

      // Triángulo en esquina inferior derecha

      fill(233, 235, 158);
      triangle(x + tam, y + tam, x + tam, y, x, y + tam);

      fill(172, 193, 150);
      ellipse(x + tam, y + tam / 2, tam/2, tam);
      
      fill(240, 226, 163);
      arc(x + tam / 2, y + tam, tam/2, tam, PI, TWO_PI);

      noStroke();

noStroke();

      // Círculo (más arriba)

      fill(210, 222, 183);
      ellipse(x + tam / 2, y + tam / 2 - 15, tam / 2, tam / 2);  // subido en Y

      fill(240, 226, 163);
      arc(x + tam / 2, y + tam, tam/2, tam, PI, TWO_PI);
    }
  }
}
