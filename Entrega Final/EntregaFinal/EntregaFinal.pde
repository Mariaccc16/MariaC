// Importa la libreria de sonido
import processing.sound.*;

// Variable que maneja el estado actual
String estado = "inicio";

// Imágenes
PImage imagen1, imagen2, imagen3, imagen4, imagen5, imagen6, imagen7, imagen8, imagen9, imagen10;

// Tipogría
PFont miFuente;

// Colores por emoción
color colorSilencio = color(148, 123, 198);
color colorAlegria = color(233, 225, 90);
color colorIrritante = color(204, 76, 76);
color colorCalma = color(230, 240, 240);
color colorTristeza = color(70, 90, 165);

// Variables para saber si ya se visitó esa emoción
boolean visitSilencio = false;
boolean visitAlegria = false;
boolean visitIrritante = false;
boolean visitCalma = false;
boolean visitTristeza = false;

ArrayList<Gota> gotas = new ArrayList<Gota>();
ArrayList<BotonEmocion> botonesEmocion = new ArrayList<BotonEmocion>();

// Flechas de navegación
Flecha flechaActual;
Flecha flechaIzquierda;

// Archivos de sonido
SoundFile sonidoAlegria, sonidoIrritante, sonidoCalma, sonidoTristeza, voiceEnOff2;
boolean voice2Reproducido = false;

void setup() {
  size(800, 800);
  frameRate(5); // controla la velocidad de animación

  miFuente = createFont("BaksoSapi.otf", 32); // Fuente importada
  textFont(miFuente);

  // Carga las imágenes al programa
  imagen1 = loadImage("imagen1.png");
  imagen2 = loadImage("imagen2.png");
  imagen3 = loadImage("imagen3.png");
  imagen4 = loadImage("imagen4.png");
  imagen5 = loadImage("imagen5.png");
  imagen6 = loadImage("imagen6.png");
  imagen7 = loadImage("imagen7.png");
  imagen8 = loadImage("imagen8.png");
  imagen9 = loadImage("imagen9.png");
  imagen10 = loadImage("imagen10.png");

  // Este for se pone aquí para crear 100 gotas y que se almacenen en su array
  for (int i = 0; i < 100; i++) {
    gotas.add(new Gota());
  }

  // Añade los botones en la pantalla de selector
  botonesEmocion.add(new BotonEmocion(128, 440, 120, colorIrritante, "irritante"));
  botonesEmocion.add(new BotonEmocion(255, 530, 120, colorTristeza, "tristeza"));
  botonesEmocion.add(new BotonEmocion(385, 440, 120, colorAlegria, "alegria"));
  botonesEmocion.add(new BotonEmocion(525, 530, 120, colorCalma, "calma"));
  botonesEmocion.add(new BotonEmocion(670, 440, 120, colorSilencio, "silencio"));

  // Carga los sonidos correspondientes
  sonidoAlegria = new SoundFile(this, "alegria.mp3");
  sonidoIrritante = new SoundFile(this, "irritante.mp3");
  sonidoCalma = new SoundFile(this, "calma.mp3");
  sonidoTristeza = new SoundFile(this, "tristeza.mp3");
  voiceEnOff2 = new SoundFile(this, "voice-en-off-2.mp3");
}

void draw() {
  background(0);

  // Cambia los que se muestra en la pnatalla dependiendo del estado actual
  switch(estado) {

    // Cada case representa una emoción o pantalla distinta dentro del recorrido interactivo.

  case "inicio":
    // Pantalla inicial
    image(imagen1, 0, 0, width, height);
    fill(255);
    noStroke();
    rect(170, 600, 470, 77);
    fill(0);
    textAlign(CENTER, CENTER);
    textFont(miFuente);
    text("EMPECEMOS", 400, 640);
    break;

  case "selectorEmociones":
    // Pantalla para elegir la emoción
    image(imagen2, 0, 0, width, height);
    for (BotonEmocion b : botonesEmocion) {
      b.display();
    }
    break;

  case "silencio":
    // Visual interactiva: cambia el brillo segun la posición del mouse
    float brillo = map(mouseY, 0, height, 30, 255);
    tint(brillo);
    image(imagen3, 0, 0, width, height);
    noTint();
    new Flecha(colorSilencio).mostrar();
    break;

  case "alegria":
    // Visual "asteriscos coloridos"
    image(imagen4, 0, 0, width, height);
    for (int i = 0; i < 10; i++) {
      float centerX = random(width);
      float centerY = random(height);
      for (int j = 0; j < 20; j++) {
        float angle = radians(j * 18 + frameCount);
        float r = random(30, 100);
        strokeWeight(2);
        stroke(random(255), random(255), random(255), 200);
        line(centerX, centerY, centerX + cos(angle) * r, centerY + sin(angle) * r);
      }
    }
    new Flecha(colorAlegria).mostrar();
    break;

  case "irritante":
    // Visual de triángulos en "desorden"
    image(imagen5, 0, 0, width, height);
    for (int i = 0; i < 10; i++) {
      fill(random(200, 255), random(50, 100), 0, 120);
      triangle(random(width), random(height), random(width), random(height), random(width), random(height));
    }
    new Flecha(colorIrritante).mostrar();
    break;

  case "calma":
    // Visual de burbujas(ondas)
    image(imagen6, 0, 0, width, height);
    noFill();
    for (int i = 0; i < 15; i++) {                          // Dibuja las 15 ondas
      float x = noise(i, frameCount * 0.01) * width;        // PosX + ruido
      float y = noise(i + 100, frameCount * 0.01) * height; // PosY + ruido
      float d = 50 + sin(frameCount * 0.05 + i) * 30;       // varía el diámetro
      stroke(255, 100 + 100 * sin(frameCount * 0.02 + i));
      ellipse(x, y, d, d);
    }
    new Flecha(colorCalma).mostrar();
    break;

  case "tristeza":
    // Visual de gotas
    image(imagen7, 0, 0, width, height);
    for (Gota g : gotas) {
      g.mover();
      g.dibujar();
    }
    new Flecha(colorTristeza).mostrar();
    break;

  case "orbita":
    image(imagen8, 0, 0, width, height);
    new Flecha2().mostrar();
    break;

  case "reinicio":
    if (!voice2Reproducido) {
      detenerTodosLosSonidos();    // Detiene todos los sonidos anteriores
      voiceEnOff2.play();          // Reproduce la grabación de voice en off
      voice2Reproducido = true;    // marca si ya se reprujo para no repetir
    }
    image(imagen9, 0, 0, width, height);
    new Flecha2().mostrar();
    break;

  case "final":
    image(imagen10, 0, 0, width, height);
    fill(255);
    rect(165, 598, 470, 77);
    fill(0);
    textAlign(CENTER, CENTER);
    text("VOLVER AL INICIO", 400, 643);
    break;
  }
}

void mousePressed() {
  if (estado.equals("inicio")) {
    if (mouseX > 170 && mouseX < 640 && mouseY > 600 && mouseY < 677) {
      detenerTodosLosSonidos();      // Silencia todo antes de empezar
      estado = "selectorEmociones";  // Cambia al menú de emociones
    }
  } else if (estado.equals("selectorEmociones")) {
    for (BotonEmocion b : botonesEmocion) {
      if (b.fueClickeado(mouseX, mouseY)) {
        detenerTodosLosSonidos();   // se detienen lo sonidos que puedan estar activos
        estado = b.estadoDestino;   // Cambia el estado de la emoción
        reproducirSonido(estado);   // Reproduce el sonido correspondiente
      }
    }

    // Todos los else if hacen el mismo proceso con su respectiva emoción
  } else if (estado.equals("silencio")) {
    visitSilencio = true;          // Marca que esa emoción se visitó
    detenerTodosLosSonidos();      // Detiene el sonido
    avanzarOOrbita();              // Revisa si ya puede pasar a orbita
  } else if (estado.equals("alegria")) {
    visitAlegria = true;
    detenerTodosLosSonidos();
    avanzarOOrbita();
  } else if (estado.equals("irritante")) {
    visitIrritante = true;
    detenerTodosLosSonidos();
    avanzarOOrbita();
  } else if (estado.equals("calma")) {
    visitCalma = true;
    detenerTodosLosSonidos();
    avanzarOOrbita();
  } else if (estado.equals("tristeza")) {
    visitTristeza = true;
    detenerTodosLosSonidos();
    avanzarOOrbita();
  } else if (estado.equals("orbita")) {

    // si click en la flecha pasa a pantalla reinicio
    if (mouseX > 680 && mouseX < 800 && mouseY > 680 && mouseY < 780) {
      estado = "reinicio";
    }
  } else if (estado.equals("reinicio")) {
    voiceEnOff2.stop(); // Detiene el voiceover si se pasa de pantalla, es decir si se hace click en la flecha
    if (mouseX > 680 && mouseX < 800 && mouseY > 680 && mouseY < 780) {
      estado = "final";
    }
  } else if (estado.equals("final")) {
    // Si se hace click en VOLVER A INICIAR, pasa a pantalla de inicio
    if (mouseX > 165 && mouseX < 635 && mouseY > 598 && mouseY < 675) {
      estado = "inicio";

      // Reinicia los estados de visita para empezar de nuevo a recorrer el programa
      visitSilencio = visitAlegria = visitIrritante = visitCalma = visitTristeza = false;
    }
  }
}

void avanzarOOrbita() {
  if (visitSilencio && visitAlegria && visitIrritante && visitCalma && visitTristeza) {
    estado = "orbita";
  } else {
    estado = "selectorEmociones";
  }
}

// Se usa antes de reproducir un nuevo sonido o al cambiar de estado
void detenerTodosLosSonidos() {
  sonidoAlegria.stop();
  sonidoIrritante.stop();
  sonidoCalma.stop();
  sonidoTristeza.stop();
}

// Recibe como parámetro un String que activa el sonido correcto
void reproducirSonido(String emocion) {
  if (emocion.equals("alegria")) sonidoAlegria.play();
  else if (emocion.equals("irritante")) sonidoIrritante.play();
  else if (emocion.equals("calma")) sonidoCalma.play();
  else if (emocion.equals("tristeza")) sonidoTristeza.play();
}

// Clase 1
class Gota {
  float x, y, speed;
  Gota() {
    x = random(width);
    y = random(-500, 0);   // Fuera de la pantalla
    speed = random(2, 5);  // velocidad de caída
  }
  void mover() {
    y += speed;

    // si la gota sale de la pantalla abajo, vuelve a salir por arriba
    if (y > height) {
      y = random(-200, 0);
      x = random(width);
    }
  }
  void dibujar() {
    noStroke();
    fill(30, 30, 120, 240);
    ellipse(x, y, 6, 10);
  }
}

// Clase 2
class Flecha {
  color c;
  Flecha(color c) {
    this.c = c;
  }
  void mostrar() {
    fill(c);          // usa el color correspondiente a la emoción
    noStroke();
    triangle(105, 688, 105, 774, 17, 733);
  }
}

// Clase 3
class Flecha2 {
  void mostrar() {
    fill(12, 5, 48);
    noStroke();
    triangle(695, 688, 695, 774, 783, 733);
  }
}

// Clase 4
class BotonEmocion {
  float x, y, tam;
  color c;              // color emoción
  String estadoDestino; // A que estado se dirige al hacer clic

  BotonEmocion(float x, float y, float tam, color c, String estadoDestino) {
    this.x = x;
    this.y = y;
    this.tam = tam;
    this.c = c;
    this.estadoDestino = estadoDestino;
  }

  void display() {
    fill(c);
    ellipse(x, y, tam, tam);
  }

  boolean fueClickeado(float mx, float my) {
    // revisa si el clic ocurre dentro del área del botón
    return dist(mx, my, x, y) < tam / 2;
  }
}
