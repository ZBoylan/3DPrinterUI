/*

GUI for 3D printer

Zachary Boylan, Zaid Bhujwala, Rebecca Peralta, George Ventura

Usage: Before running the gui.pde, ensure that sketch_3DPrinterGUI is within the package/folder 
of this .pde file.
Required Processing Libraries needed before running gui.pde:
  - ControlP5
  - G4P
  - ToxicLibs
  
To start GUI, simply press the "Play" button on Processing 3.3.6 or run gui.pde by double clicking
it.

This version is a first prototype so not all features are present/functional but are accurate.
All features are mattered to change in final implementation.

*/



/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here
 } //_CODE_:button1:12356:

 * Do not rename this tab!
 * =========================================================
 */

import processing.core.PApplet;
import g4p_controls.*;
import java.awt.*;
import java.io.File;

// for DeviceController class
import processing.serial.*;
import java.util.Arrays;
DeviceController devControl;
ArrayList<String> gcode;
// end of DeviceController 

// for render & slicing
PGraphics rendering;
RenderControler vis;
boolean realsed = true;
boolean confirmedClicked = false;

int i=0;
int j=0;

Model test;

int last;

public void settings(){
    size(1000,700,P3D);    // must be P3D to render
}

public void setup(){
  createGUI();
  inputWindow.setVisible(false);

  // Device controller test
  try {
     devControl = new DeviceController(true);  //updated for new DeviceController constructor when using test mode
  }
  catch(RuntimeException e) {
     e.printStackTrace();
     println("Failed to open serial port, aborting");
     return;
  }
}

public void draw(){
  background(230);
  if (confirmedClicked){
     rendering = createGraphics(250, 250, P3D);  //size of render

    vis = new RenderControler(100,100,100);
    vis.ResetCamera();
    STLParser parser = new STLParser(STLFile);
    ArrayList<Facet> data = parser.parseSTL();
   // test = new Model(data, .1, .1);  //Model constructor function changed to     public Model(ArrayList<Facet> facets)
    
    // In newest Slicing team files - the Slicer class will create the gcode with function public ArrayList<String> createGCode(ArrayList<Layer> layers)
    //test.Slice();      // Create gcode in Model object
    //gcode = test.getGCode();   // assign gcode from Model object to gui.pde gcode variable - be used to start print job
   // vis.Render(test, rendering);
    image(rendering, 50 ,50);
  
  //Testing render manipulation. WIP
  /*modelTranslationTest();
  modelScalingTest();
  rotationTest();
  */
  }
}

/*    // Wait on these functions until we receive more updated files.
//prototype mouse events for render
void modelTranslationTest()
  {
    if(mousePressed)
    {
      test.Translate(1,1);
      vis.Render(test, rendering);
      image(rendering, 50 ,50);
    }
    else
      {
      test.Translate(-1,-1);
      vis.Render(test, rendering);
      image(rendering, 50 ,50);
      }
  }

void modelScalingTest()
  {
    if(mousePressed)
    {
      test.Scale(new PVector(1.01,1.01, 1.01));
      vis.Render(test, rendering);
      image(rendering, 50 ,50);
    }
    else
      {
      test.Scale(new PVector(.99, .99, .99));
      vis.Render(test, rendering);
      image(rendering, 50 ,50);
      }
  }

  void rotationTest()
    {
      if(mousePressed)
      {
        POV temp = vis.getPOV();
        temp.Rotate(1, 0);
        vis.SetPOV(temp);
        vis.Render(test, rendering);
        image(rendering, 50 ,50);
      }
      else
        {
          POV temp = vis.getPOV();
        temp.Rotate(0, 1);
        vis.SetPOV(temp);
        vis.Render(test, rendering);
        image(rendering, 50 ,50);
        }

    }
    */

public void startSliceBtn_click(GButton source, GEvent event) { //_CODE_:startSliceBtn:735941:
  println("Start Print button pressed");
  // Checking isJobRunning is done within startPrintJob(), so I think we never have to
  //if (devControl.isJobRunning() == false)
  //{
    devControl.startPrintJob(gcode);
  //}
}//_CODE_:startSliceBtn:735941:

public void pauseSliceBtn_click(GButton source, GEvent event) { //_CODE_:pauseSliceBtn:624877:
  println("Pause / Resume button pressed");
  if (pauseSliceBtn.getText() == "Pause"){
    devControl.pauseJob();
    pauseSliceBtn.setText("Resume");
  }
  else {
    devControl.resumeJob();
    pauseSliceBtn.setText("Pause");    // allows you to pause more than once per print job
  }
} //_CODE_:pauseSliceBtn:624877:

public void cancelPrintBtn_click(GButton source, GEvent event) { //_CODE_:cancelPrintBtn:781425:
  println("Cancel Print button pressed");
  devControl.stopJob();
} //_CODE_:cancelPrintBtn:781425:

public void qualitySlider_change(GSlider source, GEvent event) { //_CODE_:infillSlider:696453:
  // var name = infillSlider
  // Team wants value form 0.0 - 1.0 = divide by 100 if slider range is 0.0 - 100.0
  //infill = infillSlider.getValueF();   // round2 function will set number of decimals you want for infill
  infill = round2(infillSlider.getValueF(), 2);
  println("infill = " + infill);
} //_CODE_:infillSlider:696453:

public void qualityLowRad_clicked(GOption source, GEvent event) { //_CODE_:qualityLowRad:596469:
  quality = 0;
  println("quality set to low = " + quality);
} //_CODE_:qualityLowRad:596469:

public void qualityMedRad_clicked(GOption source, GEvent event) { //_CODE_:qualityMedRad:556993:
  quality = 1;
  println("quality set to medium = " + quality);
} //_CODE_:qualityMedRad:556993:

public void qualityHighRad_clicked(GOption source, GEvent event) { //_CODE_:qualityHighRad:770558:
  quality = 2;
  println("quality set to high = " + quality);
} //_CODE_:qualityHighRad:770558:

public void printWhenReadyBox_clicked(GCheckbox source, GEvent event) { //_CODE_:printWhenReadyBox:392431:
  if (printWhenReadyBox.isSelected() == false)
      printWhenReady = false;
  else
      printWhenReady = true;

  println("printWhenReady is " + printWhenReady);
} //_CODE_:printWhenReadyBox:392431:

public void warmUpBtn_click(GButton source, GEvent event) { //_CODE_:warmUpBtn:690847:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:warmUpBtn:690847:

public void recenterHeadBtn_click(GButton source, GEvent event) { //_CODE_:recenterHeadBtn:245560:
  println("recenterHeadBtn - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:recenterHeadBtn:245560:

public void connectBtn_click(GButton source, GEvent event) { //_CODE_:connectBtn:421460:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:connectBtn:421460:

public void chooseFileBtn_click(GButton source, GEvent event) { //_CODE_:chooseFileBtn:320943:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
  //Select New File
  STLFile = null;
  confirmedClicked = false;
  fileTextBox.setText("Choose File...");
  //Show the input Window
  inputWindow.setVisible(true);
} //_CODE_:chooseFileBtn:320943:

public void nozzleSlider_change(GSlider source, GEvent event) { //_CODE_:nozzleSlider:915112:
  nozzleDiameter = round2(nozzleSlider.getValueF(), 2);
  println("Nozzle diameter = " + nozzleDiameter);
} //_CODE_:nozzleSlider:915112:

public void sliderLayerSize_change(GSlider source, GEvent event) { //_CODE_:layerSizeSlider:493757:
  layerSize = round2(layerSizeSlider.getValueF(), 2);
  println("Layer size = " + layerSize);
} //_CODE_:layerSizeSlider:493757:

public void xAreaTextfield_change(GTextField source, GEvent event) { //_CODE_:xTextBox:544724:
  xArea = Integer.parseInt(xTextBox.getText());

  // This is throwing a null pointer exception and crashing atm
  if (xArea < 1)
    xTextBox.setText("1");
  if (xArea > 200)
    xTextBox.setText("200");

  println("X Area = " + xArea);
} //_CODE_:xTextBox:544724:

public void yAreaTextfield_change1(GTextField source, GEvent event) { //_CODE_:yTextBox:577150:
  yArea = Integer.parseInt(yTextBox.getText());

  // This is throwing a null pointer exception and crashing atm
  if (yArea < 1)
    yTextBox.setText("1");
  if (yArea > 200)
    yTextBox.setText("200");

  println("Y Area = " + yArea);
} //_CODE_:yTextBox:577150:

public void zAreaTextfield_change1(GTextField source, GEvent event) { //_CODE_:zTextBox:384490:
  zArea = Integer.parseInt(zTextBox.getText());

  // This is throwing a null pointer exception and crashing atm
  if (zArea < 1)
    zTextBox.setText("1");
  if (zArea > 200)
    zTextBox.setText("200");

  println("Z Area = " + zArea);
} //_CODE_:zTextBox:384490:

public void rightArrowbtn_click1(GButton source, GEvent event) { //_CODE_:rightArrowbtn:338278:
  println("rightArrowbtn - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:rightArrowbtn:338278:

public void upArrowbtn_click1(GButton source, GEvent event) { //_CODE_:upArrowbtn:481853:
  println("upArrowbtn - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:upArrowbtn:481853:

public void leftArrowbtn_click1(GButton source, GEvent event) { //_CODE_:leftArrowbtn:840976:
  println("leftArrowbtn - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:leftArrowbtn:840976:

public void downArrowbtn_click1(GButton source, GEvent event) { //_CODE_:downArrowbtn:888588:
  println("downArrowbtn - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:downArrowbtn:888588:

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:inputWindow:608766:
  appc.background(230);
} //_CODE_:inputWindow:608766:

public void fileTextBox_change(GTextField source, GEvent event) { //_CODE_:fileTextBox:274303:
  println("fileTextBox - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:fileTextBox:274303:

//Select File
public void searchFileBtn_click(GButton source, GEvent event) { //_CODE_:searchFileBtn:687641:
  println("searchFileBtn - GButton >> GEvent." + event + " @ " + millis());
  selectInput("Select a STL file:", "fileSelected");
} //_CODE_:searchFileBtn:687641:

public void fileSelected(File selection) {
  STLFile = selection.getAbsolutePath();
  fileTextBox.setText(STLFile);
}

public void gcodeTextBox_change(GTextArea source, GEvent event) { //_CODE_:gcodeTextBox:726640:
  println("textarea1 - GTextArea >> GEvent." + event + " @ " + millis());
} //_CODE_:gcodeTextBox:726640:

public void cancelInputBtn_click(GButton source, GEvent event) { //_CODE_:cancelInputBtn:629030:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
  inputWindow.setVisible(false);
} //_CODE_:cancelInputBtn:629030:

public void confirmBtn_click(GButton source, GEvent event) { //_CODE_:confirmBtn:275116:
  println("confirmBtn - GButton >> GEvent." + event + " @ " + millis());
  if (fileTextBox.getText() == STLFile) {
    currentFile.setText(STLFile);
    inputWindow.setVisible(false);
    confirmedClicked = true;
  }
} //_CODE_:confirmBtn:275116:

//Layer Slider
public void layerSlider_change(GSlider source, GEvent event) { //_CODE_:infillSlider:696453:
  layerHeight = round2(layerSlider.getValueF(), 2);
  layerValue.setText(str (layerHeight));
  println("layerHeight = " + layerHeight);
}

// Create all the GUI controls.
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  startSliceBtn = new GButton(this, 530, 30, 80, 30);
  startSliceBtn.setText("Start");
  startSliceBtn.addEventHandler(this, "startSliceBtn_click");
  pauseSliceBtn = new GButton(this, 620, 30, 80, 30);
  pauseSliceBtn.setText("Pause");
  pauseSliceBtn.addEventHandler(this, "pauseSliceBtn_click");
  cancelPrintBtn = new GButton(this, 710, 30, 80, 30);
  cancelPrintBtn.setText("Cancel");
  cancelPrintBtn.addEventHandler(this, "cancelPrintBtn_click");
  infillSlider = new GSlider(this, 630, 140, 160, 50, 10.0);
  infillSlider.setShowValue(true);
  infillSlider.setShowLimits(true);
  infillSlider.setLimits(0.5, 0.0, 1.0);
  infillSlider.setNbrTicks(100);
  infillSlider.setNumberFormat(G4P.DECIMAL, 0);
  infillSlider.setOpaque(false);
  infillSlider.addEventHandler(this, "qualitySlider_change");
  infillLabel = new GLabel(this, 669, 120, 80, 20);
  infillLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  infillLabel.setText("Infill %");
  infillLabel.setOpaque(false);
  qualityGroup = new GToggleGroup();
  qualityLowRad = new GOption(this, 630, 220, 120, 20);
  qualityLowRad.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  qualityLowRad.setText("Low");
  qualityLowRad.setOpaque(false);
  qualityLowRad.addEventHandler(this, "qualityLowRad_clicked");
  qualityMedRad = new GOption(this, 630, 240, 120, 20);
  qualityMedRad.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  qualityMedRad.setText("Medium");
  qualityMedRad.setOpaque(false);
  qualityMedRad.addEventHandler(this, "qualityMedRad_clicked");
  qualityHighRad = new GOption(this, 630, 260, 120, 20);
  qualityHighRad.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  qualityHighRad.setText("High");
  qualityHighRad.setOpaque(false);
  qualityHighRad.addEventHandler(this, "qualityHighRad_clicked");
  qualityGroup.addControl(qualityLowRad);
  qualityLowRad.setSelected(true);
  qualityGroup.addControl(qualityMedRad);
  qualityGroup.addControl(qualityHighRad);
  qualityLabel = new GLabel(this, 630, 200, 80, 20);
  qualityLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  qualityLabel.setText("Quality");
  qualityLabel.setOpaque(false);
  printWhenReadyBox = new GCheckbox(this, 530, 150, 100, 30);
  printWhenReadyBox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  printWhenReadyBox.setText("Print When Ready");
  printWhenReadyBox.setOpaque(false);
  printWhenReadyBox.addEventHandler(this, "printWhenReadyBox_clicked");
  warmUpBtn = new GButton(this, 530, 370, 80, 50);
  warmUpBtn.setText("Warm Up Printer");
  warmUpBtn.addEventHandler(this, "warmUpBtn_click");
  recenterHeadBtn = new GButton(this, 620, 370, 80, 50);
  recenterHeadBtn.setText("Recenter Head to Origin");
  recenterHeadBtn.addEventHandler(this, "recenterHeadBtn_click");
  connectBtn = new GButton(this, 710, 370, 80, 49);
  connectBtn.setText("Connect to Printer");
  connectBtn.addEventHandler(this, "connectBtn_click");
  statusLabel = new GLabel(this, 30, 430, 230, 30);
  statusLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  statusLabel.setText("Status");
  statusLabel.setOpaque(false);

  chooseFileBtn = new GButton(this, 530, 70, 80, 30);
  chooseFileBtn.setText("Choose File");
  chooseFileBtn.addEventHandler(this, "chooseFileBtn_click");

  //Current File Label
  currentFile = new GLabel(this, 620, 80, 900, 20);
  currentFile.setTextAlign(GAlign.LEFT, GAlign.BOTTOM);
  currentFile.setFont(new java.awt.Font("Monospaced", Font.ITALIC, 12));
  currentFile.setText("No File Selected...");
  currentFile.setOpaque(false);


  rightArrowbtn = new GButton(this, 190, 360, 42, 36);
  rightArrowbtn.setIcon("ArrowRight.png", 1, GAlign.EAST, GAlign.RIGHT, GAlign.MIDDLE);
  rightArrowbtn.addEventHandler(this, "rightArrowbtn_click1");
  upArrowbtn = new GButton(this, 140, 330, 40, 41);
  upArrowbtn.setIcon("ArrowUp.png", 1, GAlign.EAST, GAlign.RIGHT, GAlign.MIDDLE);
  upArrowbtn.addEventHandler(this, "upArrowbtn_click1");
  leftArrowbtn = new GButton(this, 90, 360, 44, 36);
  leftArrowbtn.setIcon("ArrowLeft.png", 1, GAlign.EAST, GAlign.RIGHT, GAlign.MIDDLE);
  leftArrowbtn.addEventHandler(this, "leftArrowbtn_click1");
  downArrowbtn = new GButton(this, 140, 380, 40, 40);
  downArrowbtn.setIcon("ArrowDown.png", 1, GAlign.EAST, GAlign.RIGHT, GAlign.MIDDLE);
  downArrowbtn.addEventHandler(this, "downArrowbtn_click1");

  nozzleSlider = new GSlider(this, 630, 280, 160, 40, 10.0);
  nozzleSlider.setShowValue(true);
  nozzleSlider.setLimits(0.5, 0.0, 1.0);
  nozzleSlider.setNumberFormat(G4P.DECIMAL, 2);
  nozzleSlider.setOpaque(false);
  nozzleSlider.addEventHandler(this, "nozzleSlider_change");
  nozzleLabel = new GLabel(this, 790, 290, 110, 20);
  nozzleLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  nozzleLabel.setText("Nozzle Diameter");
  nozzleLabel.setOpaque(false);
  layerSizeSlider = new GSlider(this, 630, 320, 160, 40, 10.0);
  layerSizeSlider.setShowValue(true);
  layerSizeSlider.setLimits(1.5, 1.0, 2.0);
  layerSizeSlider.setNumberFormat(G4P.DECIMAL, 2);
  layerSizeSlider.setOpaque(false);
  layerSizeSlider.addEventHandler(this, "sliderLayerSize_change");
  layerSizeLabel = new GLabel(this, 790, 330, 110, 20);
  layerSizeLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  layerSizeLabel.setText("Layer Size");
  layerSizeLabel.setOpaque(false);
  xTextBox = new GTextField(this, 550, 200, 70, 30, G4P.SCROLLBARS_NONE);
  xTextBox.setOpaque(true);
  xTextBox.addEventHandler(this, "xAreaTextfield_change");
  yTextBox = new GTextField(this, 550, 240, 70, 30, G4P.SCROLLBARS_NONE);
  yTextBox.setOpaque(true);
  yTextBox.addEventHandler(this, "yAreaTextfield_change1");
  zTextBox = new GTextField(this, 550, 280, 70, 30, G4P.SCROLLBARS_NONE);
  zTextBox.setOpaque(true);
  zTextBox.addEventHandler(this, "zAreaTextfield_change1");
  xLabel = new GLabel(this, 470, 200, 80, 20);
  xLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  xLabel.setText("X Area");
  xLabel.setOpaque(false);
  yLabel = new GLabel(this, 470, 240, 80, 20);
  yLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  yLabel.setText("Y Area");
  yLabel.setOpaque(false);
  zLabel = new GLabel(this, 470, 280, 80, 20);
  zLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  zLabel.setText("Z Area");
  zLabel.setOpaque(false);

  inputWindow = GWindow.getWindow(this, "Choose input", 0, 0, 300, 350, JAVA2D);
  inputWindow.noLoop();
  inputWindow.addDrawHandler(this, "win_draw1");
  fileTextBox = new GTextField(inputWindow, 10, 20, 160, 30, G4P.SCROLLBARS_NONE);
  fileTextBox.setPromptText("Choose File...");
  fileTextBox.setOpaque(true);
  fileTextBox.addEventHandler(this, "fileTextBox_change");
  searchFileBtn = new GButton(inputWindow, 180, 20, 80, 30);
  searchFileBtn.setText("Search");
  searchFileBtn.addEventHandler(this, "searchFileBtn_click");
  gcodeTextBox = new GTextArea(inputWindow, 10, 80, 280, 220, G4P.SCROLLBARS_VERTICAL_ONLY);
  gcodeTextBox.setOpaque(true);
  gcodeTextBox.addEventHandler(this, "gcodeTextBox_change");
  cancelInputBtn = new GButton(inputWindow, 190, 310, 80, 30);
  cancelInputBtn.setText("Cancel");
  cancelInputBtn.addEventHandler(this, "cancelInputBtn_click");
  confirmBtn = new GButton(inputWindow, 30, 310, 80, 30);
  confirmBtn.setText("Confirm");
  confirmBtn.addEventHandler(this, "confirmBtn_click");
  inputWindow.loop();
  inputWindow.setVisible(false);

  //Layer Slider
  layerSlider = new GSlider(this, 30, 470, 422, 50, (float) 10.0);
  layerSlider.setShowLimits(true);
  layerSlider.setLimits(0.0, 0.01, 0.4);
  layerSlider.setNbrTicks(50);
  layerSlider.setNumberFormat(G4P.DECIMAL, 0);
  layerSlider.setOpaque(false);
  layerSlider.addEventHandler(this, "layerSlider_change");

  layerLabel = new GLabel(this, 30, 460, 80, 30);
  layerLabel.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  layerLabel.setText("Layer Height:");
  layerLabel.setOpaque(false);

  layerValue = new GLabel(this, 110, 460, 90, 30);
  layerValue.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  layerValue.setText("0");
  layerValue.setOpaque(false);

}

// Variable declarations
// autogenerated do not edit
GButton startSliceBtn;
GButton pauseSliceBtn;
GButton cancelPrintBtn;
GSlider infillSlider;
GLabel infillLabel;
GToggleGroup qualityGroup;
GOption qualityLowRad;
GOption qualityMedRad;
GOption qualityHighRad;
GLabel qualityLabel;
GCheckbox printWhenReadyBox;
GButton warmUpBtn;
GButton recenterHeadBtn;
GButton connectBtn;
GLabel statusLabel;
GButton chooseFileBtn;
GButton rightArrowbtn;
GButton upArrowbtn;
GButton leftArrowbtn;
GButton downArrowbtn;
GWindow inputWindow;
GTextField fileTextBox;
GButton searchFileBtn;
GTextArea gcodeTextBox;
GButton cancelInputBtn;
GButton confirmBtn;
String STLFile;
float layerHeight;
GLabel currentFile;

//Layer Slider
GSlider layerSlider;
GLabel layerLabel;
GLabel layerValue;

GSlider nozzleSlider;
GLabel nozzleLabel;
GSlider layerSizeSlider;
GLabel layerSizeLabel;
GTextField xTextBox;
GTextField yTextBox;
GTextField zTextBox;
GLabel xLabel;
GLabel yLabel;
GLabel zLabel;