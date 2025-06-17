void setup(){
  background(255);
size(500, 500);
}

int incrementos = 50;
void draw(){
 noLoop();
 //noStroke();
  for(int x = 0;   x <= width;     x += incrementos) {
  for(int y = 0;   y <= height;    y += incrementos) {
   fill(random(200), random(100,150), random(50));
   rect(x, y, incrementos, incrementos);
   ellipse(x, y, incrementos, incrementos);
   fill(random(120), random(150, 200), random(150));
   rect(x, y, incrementos, incrementos);
  
  
      
  }
  }
  }
  
  // For loop - líneas verticales
  //      variable     condición      incremento
  // for(int x = 0;   x < width;     x += 10) {
    
  // // For loop - líneas horizontales
  //     variable      condición      incremento
  // for(int y = 0;   y < height;     y += 10) {
