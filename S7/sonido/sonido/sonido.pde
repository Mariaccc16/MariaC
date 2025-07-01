 //<>//
// Importar la librería Sound
import processing.sound.*;
import processing.sound.FFT;

// número de bandas
int bands= 256;

// Array para guardar el espectro de nuestras frecuencias
float[] spectrum = new float[bands];

int x = 0;
int y = 70;

SoundFile soundfile;
FFT fft;

float radio;

void setup() {
  size(1000, 1000);
  background(255);
  noStroke();
  //frameRate(10);
  //stroke(222);

  // Importar canción
  soundfile = new SoundFile(this, "Demasiado Loco .mp3");

  // Crear analizador de frecuencias
  fft = new FFT(this, bands);

  // Analizar la canción
  fft.input(soundfile);

  // Reproducir canción
  soundfile.play();
}

void draw() {

  fft.analyze(spectrum);

  float level = spectrum[2];

  //float numAleatorio = random (0, 1);
  radio = (level * width);
  
radio = constrain (radio, 10, 500);

  stroke(random(115), random(120), random(210), 100);
  ellipse(x, y, radio, radio);


  //fill(random(75), random(100), random(210), 30);
  //fill(10,120, 145, 30);
  //triangle(0, y, radio *2, y + radio, radio/2, y);

  x += 10;
  println(x);

  // Controlar dibujo en eje vertical

  if (x > width) {
    x = 0;
    y = y + 10;
  }

  // Controal dibujo en eje horizontal
  if (y > height) {
    background(255);
    y = 10;
  }
}
