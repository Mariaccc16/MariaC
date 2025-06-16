size(200,200);

color mainColor;
mainColor = color(112, 139, 117);
background(mainColor);

color Color;
Color = color(120, 155, 100);

color Color2;
Color2 = color(154, 184, 122);

//    x1 , y1
//point(10, 15);

//    x2 , y2
//point(20, 20);

//Línea
//line(10, 15, 20, 20);

// Elipse
//       x    y  ancho, alto
ellipse(145, 115, 100, 50);

// Rectángulo
rect(15, 15, 70, 100); 

// Triángulo
//    primer punto (x,y), segundo (x2,y2), tercero (x3,y3)
noFill(); triangle(100, 150, 50, 190, 150, 190);

//Arco
arc(59, 130, 50, 50, 0, HALF_PI);

// Cuadrado
fill(Color); square(15,130,35);

// Círculo
fill(Color2); circle(130,45,60);
