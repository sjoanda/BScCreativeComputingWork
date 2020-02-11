/*************************************************************************
Author         :    Jennifer Lawson
Scope          :    CO3355 Coursework 1 Part B
Based on       :    CO3355 Coursework 1 Part A
Date Created   :    15 February 2018
Last Modified  :    15 February 2018

**************************************************************************
Change Log
15 Feb 2018    :    Began development


**************************************************************************/

import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;

import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

import g4p_controls.*;

PeasyCam MyPeasycam;
boolean active = false;

int frameRate = 10;

//These do not set screen size.  They are here for ease of calculations
int Screen_size_x = 1000;
int Screen_size_y = 600;

// Control panel variables
int controls_width   = Screen_size_x;
int controls_depth   = 180;
int controls_x       = Screen_size_x;
int controls_y       = Screen_size_y - controls_depth;
// Does not work setting as "width" as appears before size() in program order

//Shape variables
char Shape     = 'b'; //set shape using char value, b= box
int boxx       = (Screen_size_x/2);
int boxy       = (Screen_size_y/2);
int boxz       = (Screen_size_x/2);
int box_size   = 50;

color box_colour1  = color(200,20,50);
color box_colour2  = color(150,20,150);
color controls_bg  = color(100,40,230);

Boolean shapeSurpriseMe = true;

//Initialise Toroid
private Toroid MyToroid;
private Rot rot1;
private float[] ang1;

// Button parameters
int button_size        = 50;
int number_of_buttons  = 12;
int button_spacing     = (controls_width/(number_of_buttons*4));

int button1x      = controls_x + button_spacing;
int buttonLine1   = controls_depth/4; /*y variable (allows extra rows to be
                                      added later if needed */ 
//set button starting values
int Translate_X_BTN = 0;
int Translate_Y_BTN = 0;
int Translate_Z_BTN = 0;

float Rotate_X_BTN = (PI/2); //(PI/2) = 180 degrees, this draws the plant the right way up.
float Rotate_Y_BTN = (PI/2);
float Rotate_Z_BTN = (PI/2);

int Translate_scale_BTN = 5; // Set amount to translate by each time
float Rotate_scale_BTN = (radians(15));    // Set amount to rotate by each time
int Scale_BTN = 5;           //Set amount to change size by each time

int[][] buttonArray;
// Ensure you have the same entries in here as in buttonArray
String[] button_text_array = {"Translate X",
"Translate Y",
"Translate Z",
"Rotate X",
"Rotate Y",
"Rotate Z",
"Draw Cube",
"Draw Torus",
"Surprise Me!",
"Scale Inc",
"Scale Dec",
"Toggle Move Camera"};

PImage Button_default;
PImage Button_pressed;
PImage CurrentImage;
PImage BackgroundImage;

PImage leaf;
PImage Flower;
PImage wood;

PShape Petunias;
PShape Bromeliad;
PShape SurpriseMe;

GCustomSlider shapeslider;

/**************************************************************************/

void setup()
{
  size(1000,600,P3D);
  background(0);
  MyPeasycam = new PeasyCam(this, 400);
  Button_default = loadImage("button01_100.png");
  Button_pressed = loadImage("button02_100.png");
  leaf  = loadImage("leaf.jpg");
  Flower = loadImage("Flower.jpg");
  wood = loadImage("data/wood.JPG");

  MyPeasycam.setActive(active);  // default false, stops camera responding to mouse
  Petunias = loadShape("houseplant2.obj");
  Bromeliad = loadShape("houseplant.obj");
 
  // Simple default slider,
  // constructor is `Parent applet', the x, y position and length
  //shapeslider= new GCustomSlider(this, 20, 20, 260, 50, "blue18px");
  //draw_slider();
  // Simple default slider,
  // constructor is `Parent applet', the x, y position and length
  //shapeslider= new GCustomSlider(this, 20, (controls_y), 260, 50, "blue18px");

 // shapeslider.fill();
  // show               opaque  ticks value limits  
  //shapeslider.setShowDecor(true, true, true, true);
  //shapeslider.setNbrTicks(5);
  //shapeslider.setLimits(40, -100, 100);
}

/**************************************************************************/

void draw()
{
  background(0);
  MyPeasycam.lookAt(boxx, boxy, boxz);
  drawShape(Shape);
  MyPeasycam.beginHUD();
  controls();
  pointLight(200, 200, 200, width/2, height/2, -200);
  MyPeasycam.endHUD();

}
/**************************************************************************/


/**************************************************************************/


/**************************************************************************/
void drawShape(char thisShape)
{
   switch(thisShape) //ensure correct number of switch cases for buttons
        {
        case 'a':
        draw_Torus(boxx, boxy, boxz, box_size, box_colour2);
          break;
          
        case 'b':
        draw_box(boxx, boxy, boxz, box_size, box_colour1);
          break;
        
        case 'c':
        drawSurpriseShape(SurpriseMe, boxx, boxy, boxz, box_size, box_colour1);
          break;
          
        default:
          draw_box(boxx, boxy, boxz, box_size, box_colour1);        
          break;
          
        }// switch statement closer
}

/**************************************************************************/
/* Method to draw box shape on demand */
void draw_box(int box_x, int box_y, int box_z, int boxSize, color thisBoxColour)
{
  pushMatrix();
  beginShape();
 // normal(0, 0, 0);
  stroke(box_colour2);
  //fill(box_colour1);
  vertex(box_x, box_y, box_z);
  vertex((box_x+boxSize), box_y, box_z);
  vertex(box_x, (box_y+boxSize), box_z);
  vertex(box_x, box_y,box_z);
  

  //fill(thisBoxColour);
  //Starting at (box_x, (box_y+boxSize),box_z)
  vertex(box_x, box_y, (box_z+boxSize));
  vertex((box_x+boxSize), (box_y), (box_z+boxSize)); 
  vertex((box_x+boxSize), (box_y+boxSize),box_z);
  //Starting at ((box_x+boxSize), (box_y+boxSize), box_z);
  vertex((box_x+boxSize), (box_y+boxSize), box_z+boxSize);
  vertex(box_x, box_y, (box_z+boxSize));
  vertex(box_x, (box_y+boxSize),box_z);
  
  fill(box_colour2);
  vertex(box_x, box_y, box_z);
  vertex(box_x, box_y, (box_z+boxSize));

  fill(box_colour1);
  vertex((box_x+boxSize), (box_y+boxSize), box_z);
  vertex(box_x, (box_y+boxSize), (box_z+boxSize));
  
  fill(box_colour2);
  vertex((box_x+boxSize), box_y, box_z);
  vertex((box_x+boxSize), box_y, box_z);  
  
  fill(thisBoxColour);
  vertex(box_x, box_y,box_z);
  vertex(box_x, (box_y+boxSize),box_z);

  
  fill(box_colour1);
  vertex(box_x, (box_y+boxSize),(box_z+boxSize));
 vertex((box_x+boxSize), (box_y+boxSize),(box_z+boxSize));
  
  endShape();
  //fill(thisBoxColour);
  translate(box_x, box_y, box_z);
  rotateX(Rotate_X_BTN);
  rotateY(Rotate_Y_BTN);
  rotateZ(Rotate_Z_BTN);
  //box(boxSize);
  popMatrix();
}
/**************************************************************************/
/* Method to draw toroid shape on demand : uses Peter Lager's Shapes3D library */
void draw_Torus(int torus_x, int torus_y, int torus_z, int torusSize, color thistorusColour)
{
  pushMatrix();
  int torusRingWidth = (torusSize/4);
  int torusRingDepth = (torusSize/4);
  int torusRingDiameter = (torusSize);
  
  int wirex = 4;
  //Change this value to change the number of wire rings latitudinally (longways around the circumference)
  // If 2, this creates a thin shape such as might be made by a loop of A4 paper
  // Around 4 and above creates a spherical shape
  int wirey = 8;
  //Change this value to change the number of wire rings longitudinally (circular cross sections around the torus)
  // If wirey = 4 while wirex = 2, this results in an empty cube shape
  //Around 8 and above creates an octagon/approaching a sphere
  
  MyToroid = new Toroid(this, wirex, wirey);
  MyToroid.fill(thistorusColour);
  translate(torus_x,torus_y,torus_z);
  MyToroid.stroke(box_colour1);
  MyToroid.setRadius(torusRingWidth, torusRingDepth, torusRingDiameter);
  MyToroid.drawMode(Shape3D.SOLID | Shape3D.WIRE);

  rotateX(Rotate_X_BTN);
  rotateY(Rotate_Y_BTN);
  rotateZ(Rotate_Z_BTN);
  MyToroid.draw();
  popMatrix();
}
/**************************************************************************/
void drawSurpriseShape(PShape thisShape, int shape_x, int shape_y, int shape_z, int shapeSize, color thisshapeColour)
{
  pushMatrix();
  //int nos = 3;
  translate(shape_x, shape_y, shape_z);
  rotateX(Rotate_X_BTN);
  rotateY(Rotate_Y_BTN);
  rotateZ(Rotate_Z_BTN);
  //textureMode(IMAGE);
  //texture(img);
  //Petunias.setFill(color(thisshapeColour));
  shape(thisShape);
  popMatrix();
}

/**************************************************************************/