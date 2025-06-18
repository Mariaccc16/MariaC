// Nombre: María Camila Serrato Restrepo
// Código: 202410329
// Título: E02 – Repetición/Teselado

void setup() {
  size(640, 640);
  background(245, 247, 220);
}

int tam = 107;

void draw() {
  
  for (int x = 0; x <= width; x += tam) {
  for (int y = 0; y <= height; y += tam) {

      noStroke();

      // Triángulo en esquina inferior derecha
      
      fill(233, 235, 158);
      triangle(x + tam, y + tam, x + tam, y, x, y + tam);

      stroke(0);
 
      // Arco horizontal
     
      fill(233, 217, 133);
      arc(x + tam / 2, y + tam / 2, tam, tam / 2, PI, TWO_PI);
     
     // Arco vertical
      
      fill(240, 226, 163);
      arc(x + tam / 2, y + tam, tam/2, tam, PI, TWO_PI);
      
      // Círculo 
      
      fill(226, 237, 139);
      ellipse(x + 2, y + tam / 2, tam/2, tam/2);
      
    }
  }
}
