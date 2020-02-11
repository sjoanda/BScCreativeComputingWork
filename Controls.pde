/**************************************************************************/
// Draws control panel.  All methods for control panel should be invoked here
void controls()
{
  fill(controls_bg);
  rect(0,controls_y,controls_width, controls_depth);
  control_buttons();
}
/**************************************************************************/

//Sets up button array
void PopulateButtonArray()
{
  int nob = number_of_buttons;
  int index = 0;
  buttonArray = new int[number_of_buttons][4];
  for(index = 0;index<nob;index++)
  {
     //Write values to each index row, and each place within that index row
     buttonArray[index][0] = index;
     //Button x coordinate
     int calculate_button_x_value = ((index+1)*(button_spacing+button_size));
     buttonArray[index][1] = calculate_button_x_value;
     //Button y coordinate    
     int calculate_button_Y_value = (buttonLine1 + controls_y);
     buttonArray[index][2] = calculate_button_Y_value;
     //Button z coordinate    
     buttonArray[index][3] = buttonLine1;
     //println("Printed some rows!" + buttonLine1);
  }
  
}

/**************************************************************************/

//Draws buttons on control panel
void control_buttons()
{
  PopulateButtonArray();
  draw_buttons(Button_default);
}
/**************************************************************************/
void draw_buttons(PImage imageToUse)
{
  int c_b_nob = number_of_buttons;
  int c_b_index = 0;
  
    for(c_b_index = 0; c_b_index<c_b_nob; c_b_index++)
    {
    int thisx = buttonArray[c_b_index][1];
    int thisy = buttonArray[c_b_index][2];
    //int thisz = buttonArray[c_b_index][3];
    image(imageToUse,thisx,thisy,button_size,button_size);
    }
  drawText();

}
/**************************************************************************/
void draw_pressed_button(PImage PressedimageToUse, int buttonNumber)
{
  int c_b_index = buttonNumber;
  //pushMatrix();
  int thatx = buttonArray[c_b_index][1];
  int thaty = buttonArray[c_b_index][2];
  //int thatz = buttonArray[c_b_index][3];
  image(PressedimageToUse,thatx,thaty,button_size,button_size);
    
}
/**************************************************************************/

void drawText()
{
  int c_b_nob = number_of_buttons;
  int c_b_index = 0;
  int textx = 0;
  int texty = 0;
  int textz = 0;
  int xTextStop = textx + button_size + button_spacing/4;
  int yTextStop = texty + button_size + button_spacing/4;
  String thisString;
  fill(200);
  textSize(11.5); 
  textAlign(CENTER);
  
  for(c_b_index = 0; c_b_index < c_b_nob; c_b_index++)
  {
      textx = buttonArray[c_b_index][1];
      texty = (buttonArray[c_b_index][2] + button_size);
      textz = buttonArray[c_b_index][3];
      thisString = button_text_array[c_b_index];
      text(thisString, textx, texty, xTextStop, yTextStop);
  }
}

/**************************************************************************/
void mousePressed()
{
  boolean ButtonStatus = false;
  for (int ButtonNumber = 0; ButtonNumber < number_of_buttons; ButtonNumber++)
  {
   ButtonStatus = CheckButton(ButtonNumber);
    if (ButtonStatus == true)
    {
     println("Button on is " + (ButtonNumber+1));
     MyPeasycam.beginHUD();
     draw_pressed_button(Button_pressed,ButtonNumber);
     MyPeasycam.endHUD();

     switch(ButtonNumber) //ensure correct number of switch cases for buttons
          {
          case 0:
          // "Translate X Button",
          if (mouseButton == LEFT)
          {
            boxx = (boxx + Translate_scale_BTN);
          }
          if (mouseButton == RIGHT)
          {
            boxx = (boxx - Translate_scale_BTN);
          }
            //translate is done by redrawing box rather than translate() function;
            //drawShape(Shape);
            break;
            
          case 1:
          // "Translate Y",
          if (mouseButton == LEFT)
          {
            boxy = (boxy + Translate_scale_BTN);
          }
          if (mouseButton == RIGHT)
          {
            boxy = (boxy - Translate_scale_BTN);
          }
            //translate is done by redrawing box rather than translate() function;
            break;
            
          case 2:
          // "Translate Z",
          if (mouseButton == LEFT)
          {
            boxz = (boxz + Translate_scale_BTN);
          }
          if (mouseButton == RIGHT)
          {
            boxz = (boxz - Translate_scale_BTN);
          }
            //translate is done by redrawing box rather than translate() function;
            break;
            
          case 3:
          // "Rotate X",
          if (mouseButton == LEFT)
          {
            Rotate_X_BTN = (Rotate_X_BTN + Rotate_scale_BTN);
          }
          if (mouseButton == RIGHT)
          {
            Rotate_X_BTN = (Rotate_X_BTN - Rotate_scale_BTN);
          }
            break;
            
          case 4:
          // "Rotate Y",
           if (mouseButton == LEFT)
          {
            Rotate_Y_BTN = (Rotate_Y_BTN + Rotate_scale_BTN);
          }
          if (mouseButton == RIGHT)
          {
            Rotate_Y_BTN = (Rotate_Y_BTN - Rotate_scale_BTN);
          }
            break;
          
          case 5:
          // "Rotate Z",
          if (mouseButton == LEFT)
          {
            Rotate_Z_BTN = (Rotate_Z_BTN + Rotate_scale_BTN);
          }
          if (mouseButton == RIGHT)
          {
            Rotate_Z_BTN = (Rotate_Z_BTN - Rotate_scale_BTN);
          }
            break;  
            
          case 6:
          // "Draw Cube",
            Shape = 'b';  // yes these are out of order.
            // I wanted to use "b" for "box".
            break;
            
          case 7:
          // "Draw Torus",
            Shape = 'a';
            break;
            
          case 8:
          // "Surprise Me!",
            if (shapeSurpriseMe == true)
            {
              shapeSurpriseMe = false;
              SurpriseMe = Bromeliad;
            }
            else if (shapeSurpriseMe == false)
            {
              shapeSurpriseMe = true;
              SurpriseMe = Petunias;
            }
            Shape = 'c';
            break;

          case 9:
         //"Scale Inc",
          box_size = (box_size + Scale_BTN);
            break;

         case 10:
         //"Scale Dec",
          box_size = (box_size - Scale_BTN);
          break;
            
         case 11:
         //"Camera On" toggle Peasycam on and off
            if (active == true)
            {
              active = false;
            }
            else if (active == false)
            {
              active = true;
            }
            MyPeasycam.setActive(active);
            break;
            
        }// switch statement closer
        
        break; //final break out of Switch loop
     } // if statement closer
        
    //delay(50);
    redraw();
     
    }//for loop closer
    
}// mousePressed closer

/**************************************************************************/

boolean CheckButton(int ImageNumber)
{
boolean X_Hit = false;
boolean Y_Hit = false;
boolean ReturnStatus = false;

   if ((mouseX > buttonArray[ImageNumber][1]) && (mouseX < (buttonArray[ImageNumber][1] + button_size)))
      X_Hit = true;
      
   if ((mouseY > buttonArray[ImageNumber][2]) && (mouseY < (buttonArray[ImageNumber][2] + button_size)))
      Y_Hit = true;
      
   if (X_Hit && Y_Hit)
      ReturnStatus = true;
   //println("status of button" + ImageNumber + " is " + ReturnStatus);
   return ReturnStatus;
}

/**************************************************************************/