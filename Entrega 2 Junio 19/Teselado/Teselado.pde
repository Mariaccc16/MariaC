// Nombre: María Camila Serrato Restrepo
// Código: 202410329
// Título: E02 – Repetición/Teselado

void setup() {
  size(640, 640);
  background(245, 247, 220);
}

int tamaño = 107;

void draw() {
  
  for (int x = 0; x <= width; x += tamaño) {
  for (int y = 0; y <= height; y += tamaño) {

      noStroke();

      // Triángulo en esquina inferior derecha
      
      fill(233, 235, 158);
      triangle(x + tamaño, y + tamaño, x + tamaño, y, x, y + tamaño);

      stroke(0);
 
      // Arco horizontal
     
      fill(233, 217, 133);
      arc(x + tamaño / 2, y + tamaño / 2, tamaño, tamaño / 2, PI, TWO_PI);
     
     // Arco vertical
      
      fill(240, 226, 163);
      arc(x + tamaño / 2, y + tamaño, tamaño / 2, tamaño, PI, TWO_PI);
      
      // Círculo 
      
      fill(226, 237, 139);
      ellipse(x + 2, y + tamaño / 2, tamaño / 2, tamaño / 2);
     
     
    }
  }
}
