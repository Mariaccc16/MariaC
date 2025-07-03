// Nombre: María Camila Serrato
// Código: 202410329
// Hice una ciudad de noche que vibra con la canción La Ciudad de Alleh y Yorghaki. 
// Las estrellas en el cielo crecen según las frecuencias de la canción, 
// los edificios tienen ventanas encendidas o apagadas de forma aleatoria, y 
// en momentos clave de la canción aparecen luces diagonales que representan luces como en la canción


// Librerías para sonido y análisis de frecuencias
import processing.sound.*;
import processing.sound.FFT;

// Variables de sonido
SoundFile cancion;
FFT analizadorFrecuencia;
float[] espectro = new float[512]; // Espectro de frecuencias

// Estrellas
float[] estrellasX, estrellasY;
int cantidadEstrellas = 100;

// Edificios y ventanas
int cantidadEdificios = 5;
int[] alturaDeEdificios = new int[cantidadEdificios];
int filasVentanas = 7;
int columnasVentanas = 3;
int anchoVentana = 6;
int altoVentana = 6;
int espacioVentanas = 8;
ArrayList<ArrayList<Boolean>> estadoVentanasPorEdificio = new ArrayList<ArrayList<Boolean>>(); // edificio tiene su propio patrón de ventanas encendidas/apagadas,

// Tiempo actual de la canción
float tiempo;

void setup() {
  size(900, 600);

  // Cargar y reproducir la canción
  cancion = new SoundFile(this, "la-ciudad.mp3");
  cancion.play();

  // Preparar análisis de frecuencia
  analizadorFrecuencia = new FFT(this, 512);
  analizadorFrecuencia.input(cancion);

  // Posiciones aleatorias para las estrellas
  estrellasX = new float[cantidadEstrellas];
  estrellasY = new float[cantidadEstrellas];
  for (int i = 0; i < cantidadEstrellas; i++) {
    estrellasX[i] = random(width);
    estrellasY[i] = random(height / 2); // Solo en lo que sería el cielo, la mitad del canvas.
  }

  // Crear altura de edificios y ventanas encendidas/apagadas
  for (int i = 0; i < cantidadEdificios; i++) {
    alturaDeEdificios[i] = int(random(100, 180));
    ArrayList<Boolean> estadoVentanas = new ArrayList<Boolean>();
    for (int j = 0; j < filasVentanas * columnasVentanas; j++) {
      estadoVentanas.add(random(1) > 0.3); // 70% encendidas
    }
    estadoVentanasPorEdificio.add(estadoVentanas); // guarda la lista de ventanas de cada edificio en la lista general de edificios.
  }
}

void draw() {
  background(10, 10, 40);
  analizadorFrecuencia.analyze(espectro);

  // --- Estrellas que vibran con la frecuencia ---
  for (int i = 0; i < cantidadEstrellas; i++) {
    float tam = map(espectro[i % espectro.length], 0, 0.05, 1, 5);
    fill(255, 230, 150);
    noStroke();
    ellipse(estrellasX[i], estrellasY[i], tam, tam);
  }

  // --- Dibujo de la calle ---
  fill(30);
  rect(0, height - 80, width, 80);

  // --- Dibujo de edificios y sus ventanas ---
  for (int i = 0; i < cantidadEdificios; i++) {
    int posXEdificio = 100 + i * 150;
    int altura = alturaDeEdificios[i];
    fill(20);
    rect(posXEdificio, height - 80 - altura, 50, altura);

    ArrayList<Boolean> ventanas = estadoVentanasPorEdificio.get(i);

    // Calcular posición inicial para centrar las ventanas
    int anchoTotalVentanas = columnasVentanas * anchoVentana + (columnasVentanas - 1) * espacioVentanas;
    int margenX = (50 - anchoTotalVentanas) / 2;
    int margenY = 10;

    for (int fila = 0; fila < filasVentanas; fila++) {
      for (int col = 0; col < columnasVentanas; col++) {
        int index = fila * columnasVentanas + col;

        // Color de ventana según su estado
        if (ventanas.get(index)) {
          fill(255, 240, 160); // Encendida
        } else {
          fill(40); // Apagada
        }

        int ventanaX = posXEdificio + margenX + col * (anchoVentana + espacioVentanas);
        int ventanaY = height - 80 - altura + margenY + fila * (altoVentana + espacioVentanas);
        rect(ventanaX, ventanaY, anchoVentana, altoVentana);
      }
    }
  }

  // --- Efecto de luces diagonales en momentos clave de la canción ---
  tiempo = cancion.position();

  if ((tiempo > 28 && tiempo < 30) ||
      (tiempo > 66 && tiempo < 68) ||
      (tiempo > 113 && tiempo < 115) ||
      (tiempo > 133 && tiempo < 135)) {

    noStroke();
    fill(255, 255, 200, 40); // Luz cálida y suave

    // Luz diagonal desde esquina superior izquierda
    pushMatrix();
    translate(0, 200);
    rotate(radians(60));
    rect(0, 0, 350, 50);
    popMatrix();

    // Luz diagonal desde esquina superior derecha
    pushMatrix();
    translate(width, 150);
    rotate(radians(-45));
    rect(-500, 0, 500, 50);
    popMatrix();

    // Suave iluminación sobre la calle
    fill(255, 255, 200, 10);
    rect(0, height - 80, width, 80);
  }
}
