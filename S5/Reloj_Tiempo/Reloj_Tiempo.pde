int h;
int s;
int m;

String timeString;

void setup() {
  size(500, 500);
}

void draw() {
  background(111, 135, 125);
  noStroke();
  textAlign(CENTER);
  fill(100, 130, 160);
  ellipse( 250, 250, 250, 250);

  h= hour();
  m = minute ();
  s = second ();

  timeString = nf(h, 2) + ':' + nf(m, 2) + ':' + nf(s, 2);
  println(timeString);


  textSize(20);
  fill(255);
  text(timeString, width/2, height/2);
}
