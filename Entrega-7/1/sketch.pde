// Nombre: María Camila Serrato Restrepo
// Código: 202410329
// Título: E07 - Visualizador Interactivo de Razas de Perros
// Este sketch permite explorar distintas razas de perros mediante
// una interfaz visual y sonora.

import processing.sound.*;
SoundFile ladrido;

Table tabla;
ArrayList<Raza> razasFiltradas = new ArrayList<Raza>();

String[] razasDeseadas = {
  "Labrador Retriever", "German Shepherd", "Bulldog", "Beagle", "Poodle",
  "Rottweiler", "Yorkshire Terrier", "Boxer", "Dachshund", "Siberian Husky",
  "Golden Retriever", "Chihuahua", "Great Dane", "Shih Tzu", "French Bulldog"
};

int indexActual = 0;
boolean mostrarInicio = true;
boolean mostrarFinal = false;


PFont tituloFont, textoFont;

void setup() {
  size(800, 600);

  // Tipografías
  tituloFont = createFont("Beautiful Freak Bold", 48);
  textoFont = createFont("Comic Sans MS", 16);

  textFont(textoFont);

  // Carga sonido
  ladrido = new SoundFile(this, "ladrido.mp3");
  ladrido.play();  // Suena apenas inicia

  // Carga tabla
  tabla = loadTable("dog_breeds.csv", "header");

  // Filtra solo las razas deseadas
  for (TableRow row : tabla.rows()) {
    String raza = row.getString("Breed");
    for (String r : razasDeseadas) {
      if (raza.equals(r)) {
        razasFiltradas.add(new Raza(row));
        break;
      }
    }
  }
}

void draw() {
  background(255, 245, 235);
  if (mostrarInicio) {
    mostrarPantallaInicio();
  } else if (mostrarFinal) {
    mostrarPantallaFinal();
  } else {

    // Muestra la tarjeta de la raza actual
    if (razasFiltradas.size() > 0) {
      razasFiltradas.get(indexActual).mostrarTarjeta(width / 2 - 150, height / 2 - 180);
    }

    // Instrucción al usuario
    fill(100);
    textAlign(CENTER);
    textFont(textoFont);
    text("Usa ← y → para cambiar de raza", width / 2, height - 20);
  }
}

void mostrarPantallaInicio() {
  fill(40);
  textAlign(CENTER);
  textFont(tituloFont);
  textSize(48);
  text("Dog Breeds", width / 2, height / 2);
  textFont(textoFont);
  textSize(20);
  text("Click to Start", width / 2, height / 2 + 30);
}

void mostrarPantallaFinal() {
  background(255, 245, 235);
  fill(40);
  textAlign(CENTER);
  textFont(tituloFont);
  textSize(44);
  text("Want to see them again?", width / 2, height / 2);

  textFont(textoFont);
  textSize(18);
  text("Click to start over", width / 2, height / 2 + 40);
}

void mousePressed() {
  if (mostrarInicio) {
    mostrarInicio = false;
    if (ladrido.isPlaying()) {
      ladrido.stop();  // ✅ Detiene el ladrido al comenzar
    }
  } else if (mostrarFinal) {
    // Reinicia todo al hacer clic desde la pantalla final
    mostrarFinal = false;
    mostrarInicio = true;
    indexActual = 0;
    ladrido.play();  // ✅ Suena otra vez al volver al inicio
  }
}

void keyPressed() {
  if (!mostrarInicio && !mostrarFinal) {
    if (keyCode == RIGHT) {
      indexActual++;
      if (indexActual >= razasFiltradas.size()) {
        mostrarFinal = true;
      }
    } else if (keyCode == LEFT) {
      if (indexActual > 0) {
        indexActual--;
      }
    }
  }
}

class Raza {
  String nombre, origen, longevidad;
  PImage imagen;

  Raza(TableRow row) {
    nombre = row.getString("Breed");
    origen = row.getString("Country of Origin");
    longevidad = row.getString("Longevity (yrs)");

    // Carga imagen según el nombre de la raza
    String rutaImagen = nombre.toLowerCase().replace(" ", "").replace("-", "") + ".jpg";
    imagen = loadImage(rutaImagen);
  }

  void mostrarTarjeta(float x, float y) {
    // Sombra
    fill(0, 30);
    noStroke();
    rect(x + 5, y + 5, 300, 320, 20);

    // Tarjeta
    fill(255, 250, 245);
    stroke(180);
    strokeWeight(1);
    rect(x, y, 300, 320, 20);

    // Imagen
    if (imagen != null) {
      image(imagen, x + 25, y + 20, 250, 180); // Muestra la imagen ajustada

      // Texto
      fill(0);
      textFont(textoFont);
      textAlign(LEFT);
      textSize(18);
      text("Breed: " + nombre, x + 20, y + 230);
      textSize(15);
      text("Country: " + origen, x + 20, y + 260);
      text("Longevity: " + longevidad + " years", x + 20, y + 290);
    }
  }
}
