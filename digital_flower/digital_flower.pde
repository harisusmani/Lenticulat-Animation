// Muhammad Haris Usmani - 1/21/2014
// http://harisusmani.com

// Credits to Prof. Golan Levin for Starter Code & Export Frame Option
// http://golancourses.net/2014/assignments/project-1/lenticular-animation/
 
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
 
  //----------------------
  // here, I set the background and some other graphical properties
  background (0,10,30);
  smooth(); 
  stroke (0, 0, 0); 
  strokeWeight (3); 
 
  //----------------------
  // Here, I assign some handy variables. 
  float cx = width/2;
  float cy = height/2;
  
  // Diving Time between Stages:
  float stage1=0.3;
  float stage2=0.5;
  float stage3=0.7;
  
  //----------------------
  // Outer Circles: Static Art
  fill (100); 
  float Big_R=350/2; //Outer Circle Radius
  ellipse (cx, cy, Big_R*2, Big_R*2); //Outer Circle
  //fill (ellipseColor, ellipseColor, ellipseColor);
  fill (80);  
  float R=150; //Inner Circle Radius
  ellipse (cx, cy, 2*R, 2*R); //Inner Circle
  
  float armAngle=0;
  for (int i=0; i < 6; i++) { //Lens Screws in Light Grey
    armAngle=armAngle+60;
    float px = (R-(R-Big_R)/2)*cos(armAngle/180*PI); 
    float py = (R-(R-Big_R)/2)*sin(armAngle/180*PI); 
    fill(180); 
    ellipse (cx+px, cy+py, (R-Big_R)/2, (R-Big_R)/2);
  }
  
  //Dynamic Graphics:
  
  pushMatrix(); 
  translate (cx, cy);
  float radius = 0;
  int nSpokes = 6;
  
  if(percent<stage1) //Stage 1, Say Smile! -- Click
  { 
    radius = 50;
    fill (256, map(percent,stage1/2,stage1,256,0), map(percent,stage1/2,stage1,256,0));
    polygon(nSpokes, 0, 0, radius);
  }
  else if(percent<stage2) //Stage2, Burst Open Shutter
  { 
    radius = (float)map(percent,stage1,stage2,50,130);
    fill (0, 0, 0);
    polygon(nSpokes, 0, 0, radius);
  }
  else if (percent<stage3) //Stage3, Adjust/Focus
  {
    radius = (float)map(percent,stage2,stage3,130,25);
    fill (0, 0, 0);
    polygon(nSpokes, 0, 0, radius);
  }
  else
  {
    radius = (float)map(percent,stage3,1,25,50); //Stage 4, Fine Focus & Loop GIF
    fill (0, 0, 0);
    polygon(nSpokes, 0, 0, radius);
  }

  popMatrix();
  
  //-- SHUTTER LEAVES of Exact Length, give Illusion of Rotation 
  float outRadius=sqrt(pow(R,2)-pow((radius*cos(radians(180/nSpokes))),2))-(radius*sin(radians(180/nSpokes))); 
  //Chord Length Formula: http://www.mathopenref.com/chord.html
  armAngle = 0;
  for (int i=0; i < nSpokes; i++) {
    armAngle = armAngle + 360/nSpokes;
    float px = cx + radius*cos(armAngle/180*PI); 
    float py = cy + radius*sin(armAngle/180*PI); 
    fill(255); 
    float disp_x= outRadius*cos((armAngle-360/nSpokes)/180*PI); //Displacement in X
    float disp_y= outRadius*sin((armAngle-360/nSpokes)/180*PI);  //Displacement in Y
    line(px, py, px+disp_x, py+disp_y);
  }
}
