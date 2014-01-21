// Credits to Prof. Golan Levin for Starter Code & Export Frame Option


 
//===================================================
// Global variables. 
 
int     nFramesInLoop = 30; // for lenticular export, change this to 10!
int     nElapsedFrames;
boolean bRecording; 
 
String  myName = "harisusmani";
 
//===================================================
void setup() {
  size (500, 500); 
  bRecording = false;
  nElapsedFrames = 0;
  frameRate (nFramesInLoop); 
}
//===================================================
void keyPressed() { 
  // Press a key to export frames to the output folder
  bRecording = true;
  nElapsedFrames = 0;
}
 
//===================================================
void draw() {
 
  // Compute a percentage (0...1) representing where we are in the loop.
  float percentCompleteFraction = 0; 
  if (bRecording) {
    percentCompleteFraction = (float) nElapsedFrames / (float)nFramesInLoop;
  } 
  else {
    float modFrame = (float) (frameCount % nFramesInLoop);
    percentCompleteFraction = modFrame / (float)nFramesInLoop;
  }
 
  // Render the design, based on that percentage. 
  renderMyDesign (percentCompleteFraction);
 
  // If we're recording the output, save the frame to a file. 
  if (bRecording) {
    saveFrame("output/"+ myName + "-loop-" + nf(nElapsedFrames, 4) + ".png");
    nElapsedFrames++; 
    if (nElapsedFrames == nFramesInLoop) {
      bRecording = false;
    }
  }
}

//polygon() from http://processing.org/tutorials/anatomy/
void polygon(int n, float cx, float cy, float r)
{
  float angle = 360.0 / n;

  beginShape();
  for (int i = 0; i < n; i++)
  {
    vertex(cx + r * cos(radians(angle * i)),
      cy + r * sin(radians(angle * i)));
  }
  endShape(CLOSE);
}
 
//===================================================
void renderMyDesign (float percent) {
 
  // This is an example of a function that renders a temporally looping design. 
  // It takes a "percent", between 0 and 1, indicating where we are in the loop. 
  // This example uses two different graphical techniques. 
  // Use or delete whatever you prefer from this example. 
  // Remember to SKETCH FIRST!
 
  //----------------------
  // here, I set the background and some other graphical properties
  background (0);
  smooth(); 
  stroke (0, 0, 0); 
  strokeWeight (2); 
 
  //----------------------
  // Here, I assign some handy variables. 
  float cx = width/2;
  float cy = height/2;
 
  //----------------------
  // Here, I use graphical transformations 
  // to render a rotated square. 
  pushMatrix(); 
  translate (cx, cy);
  float rotatingShapeAngle =  percent * TWO_PI; //* 2/5;//-0.25;
  rotate (rotatingShapeAngle); 
  fill (255, 128, 90);
  polygon(1+(int)(sin(PI*percent)*10), 0, 0, 80);
  //ellipse (0, 0, 80, 80);
  //rect (-40, -40, 80, 80);
  popMatrix(); 
 
  //----------------------
  // Here's a pulsating ellipse
  /*
  float ellipsePulse = cos ( percent * TWO_PI); 
  float ellipseW = map(ellipsePulse, -1, 1, 20.0, 80.0); 
  float ellipseH = map(ellipsePulse, -1, 1, 80.0, 20.0); 
  float ellipseColor = map(ellipsePulse, -1, 1, 0, 255); 
  fill (ellipseColor, ellipseColor, ellipseColor); 
  ellipse (340, cy, ellipseW, ellipseH); 
  */
}
