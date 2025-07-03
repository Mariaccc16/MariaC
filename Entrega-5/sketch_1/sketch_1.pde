/**
 * Nombre: María Camila Serrato
 * Título: Visual – Track 11 (Alee & Yorghani)
 * Descripción: Sketch generativo que visualiza la atmósfera introspectiva de la canción usando partículas que se expanden en espiral a partir del análisis de frecuencia. 
 */

import processing.sound.*;
import processing.sound.FFT;

SoundFile cancion;
FFT fft;

int bands = 512;
float[] spectrum = new float[bands];

float t = 0;

void setup() {
  size(1000, 1000);
  background(10);
  noFill();
  smooth(8);

  cancion = new SoundFile(this, "track11.mp3");
  fft = new FFT(this, bands);
  fft.input(cancion);
  cancion.play();
}

void draw() {
  background(10, 10, 20, 30); // Fondo oscuro con transparencia para dejar estelas

  translate(width/2, height/2);
  fft.analyze(spectrum);

  for (int i = 0; i < bands; i += 8) {
    float angle = map(i, 0, bands, 0, TWO_PI) + t;
    float radius = map(spectrum[i], 0, 0.5, 50, 400);

    float x = cos(angle) * radius;
    float y = sin(angle) * radius;

    stroke(190 + i % 50, 130, 255, 90);
    strokeWeight(1.2);
    ellipse(x, y, 4, 4);
  }

  t += 0.0025; // rotación lenta y continua
}

void stop() {
  cancion.stop();
  super.stop();
}
