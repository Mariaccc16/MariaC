import processing.sound.*;

String estado = "inicio";
PImage imagen1, imagen2, imagen3, imagen4, imagen5, imagen6, imagen7, imagen8, imagen9, imagen10;
PFont miFuente;

// Colores por emoción
color colorSilencio = color(148, 123, 198);
color colorAlegria = color(233, 225, 90);
color colorIrritante = color(204, 76, 76);
color colorCalma = color(230, 240, 240);
color colorTristeza = color(70, 90, 165);

boolean visitSilencio = false;
boolean visitAlegria = false;
boolean visitIrritante = false;
boolean visitCalma = false;
boolean visitTristeza = false;

ArrayList<Gota> gotas = new ArrayList<Gota>();
ArrayList<BotonEmocion> botonesEmocion = new ArrayList<BotonEmocion>();
Flecha flechaActual;
Flecha flechaIzquierda;

SoundFile sonidoAlegria, sonidoIrritante, sonidoCalma, sonidoTristeza, voiceEnOff2;
boolean voice2Reproducido = false;

void setup() {
  size(800, 800);
  frameRate(5);
  miFuente = createFont("BaksoSapi.otf", 32);
  textFont(miFuente);

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

  for (int i = 0; i < 100; i++) {
    gotas.add(new Gota());
  }

  botonesEmocion.add(new BotonEmocion(128, 440, 120, colorIrritante, "irritante"));
  botonesEmocion.add(new BotonEmocion(255, 530, 120, colorTristeza, "tristeza"));
  botonesEmocion.add(new BotonEmocion(385, 440, 120, colorAlegria, "alegria"));
  botonesEmocion.add(new BotonEmocion(525, 530, 120, colorCalma, "calma"));
  botonesEmocion.add(new BotonEmocion(670, 440, 120, colorSilencio, "silencio"));

  sonidoAlegria = new SoundFile(this, "alegria.mp3");
  sonidoIrritante = new SoundFile(this, "irritante.mp3");
  sonidoCalma = new SoundFile(this, "calma.mp3");
  sonidoTristeza = new SoundFile(this, "tristeza.mp3");
  voiceEnOff2 = new SoundFile(this, "voice-en-off-2.mp3");
}

void draw() {
  background(0);
  switch(estado) {
  case "inicio":

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
    image(imagen2, 0, 0, width, height);
    for (BotonEmocion b : botonesEmocion) {
      b.display();
    }
    break;

  case "silencio":
    float brillo = map(mouseY, 0, height, 30, 255);
    tint(brillo);
    image(imagen3, 0, 0, width, height);
    noTint();
    new Flecha(colorSilencio).mostrar();
    break;

  case "alegria":
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
    image(imagen5, 0, 0, width, height);
    for (int i = 0; i < 10; i++) {
      fill(random(200, 255), random(50, 100), 0, 120);
      triangle(random(width), random(height), random(width), random(height), random(width), random(height));
    }
    new Flecha(colorIrritante).mostrar();
    break;

  case "calma":
    image(imagen6, 0, 0, width, height);
    noFill();
    for (int i = 0; i < 15; i++) {
      float x = noise(i, frameCount * 0.01) * width;
      float y = noise(i + 100, frameCount * 0.01) * height;
      float d = 50 + sin(frameCount * 0.05 + i) * 30;
      stroke(255, 100 + 100 * sin(frameCount * 0.02 + i));
      ellipse(x, y, d, d);
    }
    new Flecha(colorCalma).mostrar();
    break;

  case "tristeza":
    image(imagen7, 0, 0, width, height);
    for (Gota g : gotas) {
      g.mover();
      g.dibujar();
    }
    new Flecha(colorTristeza).mostrar();
    break;

  case "orbita":

    image(imagen8, 0, 0, width, height);
    new FlechaBlanca().mostrar();
    break;

  case "reinicio":
    if (!voice2Reproducido) {
      detenerTodosLosSonidos();
      voiceEnOff2.play();
      voice2Reproducido = true;
    }
    image(imagen9, 0, 0, width, height);
    new FlechaBlanca().mostrar();
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
      detenerTodosLosSonidos();
      estado = "selectorEmociones";
    }
  } else if (estado.equals("selectorEmociones")) {
    for (BotonEmocion b : botonesEmocion) {
      if (b.fueClickeado(mouseX, mouseY)) {
        detenerTodosLosSonidos();
        estado = b.estadoDestino;
        reproducirSonido(estado);
      }
    }
  } else if (estado.equals("silencio")) {
    visitSilencio = true;
    detenerTodosLosSonidos();
    avanzarOOrbita();
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
    if (mouseX > 680 && mouseX < 800 && mouseY > 680 && mouseY < 780) {
      estado = "reinicio";
    }
  } else if (estado.equals("reinicio")) {
    voiceEnOff2.stop();
    if (mouseX > 680 && mouseX < 800 && mouseY > 680 && mouseY < 780) {
      estado = "final";
    }
  } else if (estado.equals("final")) {
    if (mouseX > 165 && mouseX < 635 && mouseY > 598 && mouseY < 675) {
      estado = "inicio";
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

void detenerTodosLosSonidos() {
  sonidoAlegria.stop();
  sonidoIrritante.stop();
  sonidoCalma.stop();
  sonidoTristeza.stop();
}

void reproducirSonido(String emocion) {
  if (emocion.equals("alegria")) sonidoAlegria.play();
  else if (emocion.equals("irritante")) sonidoIrritante.play();
  else if (emocion.equals("calma")) sonidoCalma.play();
  else if (emocion.equals("tristeza")) sonidoTristeza.play();
}

class Gota {
  float x, y, speed;
  Gota() {
    x = random(width);
    y = random(-500, 0);
    speed = random(2, 5);
  }
  void mover() {
    y += speed;
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

class Flecha {
  color c;
  Flecha(color c) {
    this.c = c;
  }
  void mostrar() {
    fill(c);
    noStroke();
    triangle(105, 688, 105, 774, 17, 733);
  }
}

class FlechaBlanca {
  void mostrar() {
    fill(12, 5, 48);
    noStroke();
    triangle(695, 688, 695, 774, 783, 733);
  }
}

class BotonEmocion {
  float x, y, tam;
  color c;
  String estadoDestino;

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
    return dist(mx, my, x, y) < tam / 2;
  }
}
