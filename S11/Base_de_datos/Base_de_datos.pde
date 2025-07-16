Table table;
int nSamples;

float [] appUsageTime;
float [] screenOnTime;


void setup () {
  size (800, 800);

  table = loadTable ("user_behavior_dataset.csv", "header");
  nSamples = table.getRowCount();
  println(nSamples);

  appUsageTime =  new float [nSamples];
  screenOnTime =  new float [nSamples];

  for (int i = 0; i < nSamples; i++) {
    appUsageTime[i] = table.getFloat(i, "App Usage Time (min/day)");
    screenOnTime[i] = table.getFloat(i, "Screen On Time (hours/day)");
  }
}
void draw() {
  background(0);

  for (int i = 0; i < nSamples; i++) {
    float x = map(appUsageTime[i], 0, max(appUsageTime), 0, width);
    float y = map(screenOnTime[i], 0, max(screenOnTime), height, 0);

    //noStroke();
    ellipse(x, y, 10, 10);
  }
}
