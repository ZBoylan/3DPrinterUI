// Need G4P library
import g4p_controls.*;

//variables for 3D printer
int quality;           //Low, Medium, High (0, 1, 2)
boolean printWhenReady;
float infill;          // infill % (0 - 1)
String filePath;       
int xArea;             //Range 1-200 for build area in x, y, z
int yArea;
int zArea;
float nozzleDiameter;  //range 0-1
//float layerHeight;     //range 0-.4
float layerSize;       //range range 1-2
//float topLayer;
//float bottomLayer;

//to get values from GUI elements
//getValueS() - returns a string representation of the value
//getValueI() - returns the value as an integer (effectively a rounded float)
//getValueF() - returns the value as a float

public void setup(){
  size(900, 500, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here
  inputWindow.setVisible(false);  //initally have file input window not visible until they hit button "choose file"
  
}

public void draw(){
  background(230);
  
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}

// function to set number of decimals for floats
public static float round2(float number, int scale) {
    int pow = 10;
    for (int i = 1; i < scale; i++)
        pow *= 10;
    float tmp = number * pow;
    return ( (float) ( (int) ((tmp - (int) tmp) >= 0.5f ? tmp + 1 : tmp) ) ) / pow;
}