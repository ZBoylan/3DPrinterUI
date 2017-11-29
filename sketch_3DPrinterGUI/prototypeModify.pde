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

import processing.serial.*;
import java.util.Arrays;

DeviceController devControl;
ArrayList<String> gcode;

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
    size(1570,950,P3D);    // must be P3D to render
}

public void setup(){
  createGUI();
  inputWindow.setVisible(false);
  warmupWindow.setVisible(false);

  // Device controller test
  try {
     devControl = new DeviceController(this, "/dev/ttyUSB0", 115200, true);
  }
  catch(RuntimeException e) {
     e.printStackTrace();
     println("Failed to open serial port, aborting");
     return;
  }
}

public void draw(){
  background(230);
  line(1130, 0, 1130, 950);
  stroke(126);
  if (confirmedClicked){
     rendering = createGraphics(250, 250, P3D);  //size of render

    vis = new RenderControler(100,100,100);
    vis.ResetCamera();
    STLParser parser = new STLParser(STLFile);
    ArrayList<Facet> data = parser.parseSTL();
    test = new Model(data, .1, .1);
    test.Slice();      // Create gcode in Model object
    gcode = test.getGCode();   // assign gcode from Model object to gui.pde gcode variable - be used to start print job
    vis.Render(test, rendering);
    image(rendering, 50 ,50);
  
  //Testing render manipulation. WIP
  /*modelTranslationTest();
  modelScalingTest();
  rotationTest();
  */
  }
}

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

                                        //Event Handlers
//Start Button Click
public void startSliceBtn_click(GButton source, GEvent event) { //_CODE_:startSliceBtn:735941:
  println("Start Print button pressed");
  // Checking isJobRunning is done within startPrintJob(), so I think we never have to
  //if (devControl.isJobRunning() == false)
  //{
    devControl.startPrintJob(gcode);
  //}
}//_CODE_:startSliceBtn:735941:



//Pause Button Click
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



//Cancel Button Click
public void cancelPrintBtn_click(GButton source, GEvent event) { //_CODE_:cancelPrintBtn:781425:
  println("Cancel Print button pressed");
  devControl.stopJob();
} //_CODE_:cancelPrintBtn:781425:



//Choose File Button Click
public void chooseFileBtn_click(GButton source, GEvent event) { //_CODE_:chooseFileBtn:320943:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
  //Select New File
  STLFile = null;
  confirmedClicked = false;
  fileTextBox.setText("Choose File...");
  //Show the input Window
  inputWindow.setVisible(true);
} //_CODE_:chooseFileBtn:320943:



//Serial Devices DropList Click
public void serialDevices_click1(GDropList source, GEvent event) { //_CODE_:serialDevices:306859:
  println("serialDevices - GDropList >> GEvent." + event + " @ " + millis()); 
  port = source.getSelectedText();
  println("Port = " + port);
} //_CODE_:serialDevices:306859:



//Baud Rate TextBox Change
public void baudRateTextBox_change(GTextField source, GEvent event) { 
  baudRate = Integer.parseInt(baudRateTextBox.getText());
  println("baudRate = " + baudRate);
} 



//Print When Ready Box Clicked
public void printWhenReadyBox_clicked(GCheckbox source, GEvent event) { //_CODE_:printWhenReadyBox:392431:
  if (printWhenReadyBox.isSelected() == false)
      printWhenReady = false;
  else
      printWhenReady = true;

  println("printWhenReady is " + printWhenReady);
} //_CODE_:printWhenReadyBox:392431:



//Infill Slider Change
public void qualitySlider_change(GSlider source, GEvent event) { //_CODE_:infillSlider:696453:
  // var name = infillSlider
  // Team wants value form 0.0 - 1.0 = divide by 100 if slider range is 0.0 - 100.0
  //infill = infillSlider.getValueF();   // round2 function will set number of decimals you want for infill
  infill = round2(infillSlider.getValueF(), 2);
  println("infill = " + infill);
} //_CODE_:infillSlider:696453:



//X Textfield Change
public void xAreaTextfield_change(GTextField source, GEvent event) { //_CODE_:xTextBox:544724:
  xArea = Integer.parseInt(xTextBox.getText());

  // This is throwing a null pointer exception and crashing atm
  if (xArea < 1)
    xTextBox.setText("1");
  if (xArea > 200)
    xTextBox.setText("200");

  println("X Area = " + xArea);
} //_CODE_:xTextBox:544724:

//Y TextField Change
public void yAreaTextfield_change1(GTextField source, GEvent event) { //_CODE_:yTextBox:577150:
  yArea = Integer.parseInt(yTextBox.getText());

  // This is throwing a null pointer exception and crashing atm
  if (yArea < 1)
    yTextBox.setText("1");
  if (yArea > 200)
    yTextBox.setText("200");

  println("Y Area = " + yArea);
} //_CODE_:yTextBox:577150:

//Z TextField Change
public void zAreaTextfield_change1(GTextField source, GEvent event) { //_CODE_:zTextBox:384490:
  zArea = Integer.parseInt(zTextBox.getText());

  // This is throwing a null pointer exception and crashing atm
  if (zArea < 1)
    zTextBox.setText("1");
  if (zArea > 200)
    zTextBox.setText("200");

  println("Z Area = " + zArea);
} //_CODE_:zTextBox:384490:



//Quality Low Clicked
public void qualityLowRad_clicked(GOption source, GEvent event) { //_CODE_:qualityLowRad:596469:
  quality = 0;
  println("quality set to low = " + quality);
} //_CODE_:qualityLowRad:596469:

//Quality Med Clicked
public void qualityMedRad_clicked(GOption source, GEvent event) { //_CODE_:qualityMedRad:556993:
  quality = 1;
  println("quality set to medium = " + quality);
} //_CODE_:qualityMedRad:556993:

//Quality High Clicked
public void qualityHighRad_clicked(GOption source, GEvent event) { //_CODE_:qualityHighRad:770558:
  quality = 2;
  println("quality set to high = " + quality);
} //_CODE_:qualityHighRad:770558:



//Filament 1.75 Clicked
public void filament175_clicked(GOption source, GEvent event) { 
  filament = 1.75;
  println("filament  = " + filament);
} 

//Filament 3.00 Clicked
public void filament3_clicked(GOption source, GEvent event) { 
  filament = 3.00;
  println("filament  = " + filament);
}



//Nozzle Slider Change
public void nozzleSlider_change(GSlider source, GEvent event) { //_CODE_:nozzleSlider:915112:
  nozzleDiameter = round2(nozzleSlider.getValueF(), 2);
  println("Nozzle diameter = " + nozzleDiameter);
} //_CODE_:nozzleSlider:915112:



//Layer Scale Slider Change
public void sliderLayerScale_change(GSlider source, GEvent event) { //_CODE_:layerScaleSlider:493757:
  layerScale = round2(layerScaleSlider.getValueF(), 2);
  println("Layer scale = " + layerScale);
} //_CODE_:layercaleSlider:493757:



//Warm Up Button Clicked
public void warmUpBtn_click(GButton source, GEvent event) { //_CODE_:warmUpBtn:690847:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
  warmupWindow.setVisible(true);
} //_CODE_:warmUpBtn:690847:
//Warmup Window
synchronized public void warmupWin_draw(PApplet appc, GWinData data) { 
  appc.background(230);
} 
//Warmup Confirm Button Click
public void warmupconfirmBtn_click(GButton source, GEvent event) { 
  println("warmupconfirmBtn - GButton >> GEvent." + event + " @ " + millis());
  headTemp = Integer.parseInt(headTempTextBox.getText());
  println("Head Temperature = " + headTemp);
  bedTemp = Integer.parseInt(bedTempTextBox.getText());
  println("Bed Temperature = " + bedTemp);
  warmupWindow.setVisible(false);
}
//Warmup Cancel Button Click
public void warmupcancelBtn_click(GButton source, GEvent event) { 
  println("warmupcancelBtn - GButton >> GEvent." + event + " @ " + millis());
  warmupWindow.setVisible(false);
}


//Homing Button Clicked
public void homingBtn_click(GButton source, GEvent event) { //_CODE_:recenterHeadBtn:245560:
  println("homingBtn - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:homingBtn:245560:



//Connect Button Clicked
public void connectBtn_click(GButton source, GEvent event) { //_CODE_:connectBtn:421460:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:connectBtn:421460:



//Arrow Button Clicked
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



//Choose File Window
synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:inputWindow:608766:
  appc.background(230);
} //_CODE_:inputWindow:608766:

//File TextBox Change
public void fileTextBox_change(GTextField source, GEvent event) { //_CODE_:fileTextBox:274303:
  println("fileTextBox - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:fileTextBox:274303:

//Select File Button Click
public void searchFileBtn_click(GButton source, GEvent event) { //_CODE_:searchFileBtn:687641:
  println("searchFileBtn - GButton >> GEvent." + event + " @ " + millis());
  selectInput("Select a STL file:", "fileSelected");
} //_CODE_:searchFileBtn:687641:

public void fileSelected(File selection) {
  STLFile = selection.getAbsolutePath();
  fileTextBox.setText(STLFile);
}

//GCode TextBox Change
public void gcodeTextBox_change(GTextArea source, GEvent event) { //_CODE_:gcodeTextBox:726640:
  println("textarea1 - GTextArea >> GEvent." + event + " @ " + millis());
} //_CODE_:gcodeTextBox:726640:

//Cancel Input BUtton Click
public void cancelInputBtn_click(GButton source, GEvent event) { //_CODE_:cancelInputBtn:629030:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
  inputWindow.setVisible(false);
} //_CODE_:cancelInputBtn:629030:

//Confirm Button Click
public void confirmBtn_click(GButton source, GEvent event) { //_CODE_:confirmBtn:275116:
  println("confirmBtn - GButton >> GEvent." + event + " @ " + millis());
  if (fileTextBox.getText() == STLFile) {
    currentFile.setText(STLFile);
    inputWindow.setVisible(false);
    confirmedClicked = true;
  }
} //_CODE_:confirmBtn:275116:



 


                                      // Create all the GUI controls.
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  
  //Start Button
  startSliceBtn = new GButton(this, 1160, 620, 100, 40);
  startSliceBtn.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  startSliceBtn.setText("Start");
  startSliceBtn.addEventHandler(this, "startSliceBtn_click");
  
  //Pause Button
  pauseSliceBtn = new GButton(this, 1280, 620, 100, 40);
  pauseSliceBtn.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  pauseSliceBtn.setText("Pause");
  pauseSliceBtn.addEventHandler(this, "pauseSliceBtn_click");
  
  //Cancel Button
  cancelPrintBtn = new GButton(this, 1400, 620, 100, 40);
  cancelPrintBtn.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  cancelPrintBtn.setText("Cancel");
  cancelPrintBtn.addEventHandler(this, "cancelPrintBtn_click");
  
  //Choose File Button
  chooseFileBtn = new GButton(this, 1160, 30, 100, 40);
  chooseFileBtn.setFont(new Font(Font_Type, Font.PLAIN, 16));
  chooseFileBtn.setText("Choose File");
  chooseFileBtn.addEventHandler(this, "chooseFileBtn_click");
  //Current File Label
  currentFile = new GLabel(this, 1280, 40, 900, 20);
  currentFile.setTextAlign(GAlign.LEFT, GAlign.BOTTOM);
  currentFile.setFont(new java.awt.Font("Monospaced", Font.ITALIC, 14));
  currentFile.setText("No File Selected...");
  currentFile.setOpaque(false);
  
  //Serial Devices Label
  serialDevicesLabel = new GLabel(this, 1160, 60, 200, 80);
  serialDevicesLabel.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  serialDevicesLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  serialDevicesLabel.setText("Select Serial Device:");
  serialDevicesLabel.setOpaque(false);
  //Serial Devices DropList
  serialDevices = new GDropList(this, 1350, 85, 150, 100, 3);
  String[] deviceList = {"    ", "1111","2222","3333"};
  serialDevices.setItems(deviceList, 0);
  serialDevices.addEventHandler(this, "serialDevices_click1");
  
  //Baud Rate Label
  baudRateLabel = new GLabel(this, 1160, 120, 200, 50);
  baudRateLabel.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  baudRateLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  baudRateLabel.setText("Baud Rate:");
  baudRateLabel.setOpaque(false);
  //Baud Rate TextBox
  baudRateTextBox = new GTextField(this, 1270, 125, 70, 30, G4P.SCROLLBARS_NONE);
  baudRateTextBox.setOpaque(true);
  baudRateTextBox.addEventHandler(this, "baudRateTextBox_change");
  
  //Print When Ready CheckBox
  printWhenReadyBox = new GCheckbox(this, 1160, 170, 200, 50);
  printWhenReadyBox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  printWhenReadyBox.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  printWhenReadyBox.setText("Print When Ready");
  printWhenReadyBox.setOpaque(false);
  printWhenReadyBox.addEventHandler(this, "printWhenReadyBox_clicked");
  
  //Infill Label
  infillLabel = new GLabel(this, 1390, 150, 80, 20);
  infillLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  infillLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  infillLabel.setText("Infill:");
  infillLabel.setOpaque(false);
  //Infill Slider
  infillSlider = new GSlider(this, 1350, 170, 160, 50, 10.0);
  infillSlider.setShowValue(true);
  infillSlider.setShowLimits(true);
  infillSlider.setLimits(0.5, 0.0, 1.0);
  infillSlider.setNbrTicks(100);
  infillSlider.setNumberFormat(G4P.DECIMAL, 0);
  infillSlider.setOpaque(false);
  infillSlider.addEventHandler(this, "qualitySlider_change");
  
  //X Label
  xLabel = new GLabel(this, 1155, 240, 80, 20);
  xLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  xLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  xLabel.setText("X Area:");
  xLabel.setOpaque(false);
  //X TextBox
  xTextBox = new GTextField(this, 1240, 235, 70, 30, G4P.SCROLLBARS_NONE);
  xTextBox.setOpaque(true);
  xTextBox.addEventHandler(this, "xAreaTextfield_change");
  
  //Y Label
  yLabel = new GLabel(this, 1155, 290, 80, 20);
  yLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  yLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  yLabel.setText("Y Area:");
  yLabel.setOpaque(false);
  //Y TextBox
  yTextBox = new GTextField(this, 1240, 285, 70, 30, G4P.SCROLLBARS_NONE);
  yTextBox.setOpaque(true);
  yTextBox.addEventHandler(this, "yAreaTextfield_change1");
  
  //Z Label
  zLabel = new GLabel(this, 1155, 340, 80, 20);
  zLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  zLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  zLabel.setText("Z Area:");
  zLabel.setOpaque(false);
  //Z TextBox
  zTextBox = new GTextField(this, 1240, 335, 70, 30, G4P.SCROLLBARS_NONE);
  zTextBox.setOpaque(true);
  zTextBox.addEventHandler(this, "zAreaTextfield_change1");

  //Quality Label
  qualityLabel = new GLabel(this, 1390, 240, 80, 20);
  qualityLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  qualityLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  qualityLabel.setText("Quality:");
  qualityLabel.setOpaque(false);
  //Quality Radio Group
  qualityGroup = new GToggleGroup();
  //Quality Low
  qualityLowRad = new GOption(this, 1350, 260, 120, 30);
  qualityLowRad.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  qualityLowRad.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  qualityLowRad.setText("Low");
  qualityLowRad.setOpaque(false);
  qualityLowRad.addEventHandler(this, "qualityLowRad_clicked");
  //Quality Med
  qualityMedRad = new GOption(this, 1350, 290, 120, 30);
  qualityMedRad.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  qualityMedRad.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  qualityMedRad.setText("Medium");
  qualityMedRad.setOpaque(false);
  qualityMedRad.addEventHandler(this, "qualityMedRad_clicked");
  //Quality High
  qualityHighRad = new GOption(this, 1350, 320, 120, 30);
  qualityHighRad.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  qualityHighRad.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  qualityHighRad.setText("High");
  qualityHighRad.setOpaque(false);
  qualityHighRad.addEventHandler(this, "qualityHighRad_clicked");
  //Set Quality Rad Group
  qualityGroup.addControl(qualityLowRad);
  qualityLowRad.setSelected(true);
  qualityGroup.addControl(qualityMedRad);
  qualityGroup.addControl(qualityHighRad);

  //Filament Diameter Label
  filamentLabel= new GLabel(this, 1165, 390, 200, 20);
  filamentLabel.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  filamentLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  filamentLabel.setText("Filament Diameter:");
  filamentLabel.setOpaque(false);
  //Filament Rad Group
  filamentGroup = new GToggleGroup();
  //Filament 1.75
  filament175 = new GOption(this, 1350, 385, 60, 30);
  filament175.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  filament175.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  filament175.setText("1.75");
  filament175.setOpaque(false);
  filament175.addEventHandler(this, "filament175_clicked");
  //Filament 3.00
  filament3 = new GOption(this, 1430, 385, 80, 30);
  filament3.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  filament3.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  filament3.setText("3.00");
  filament3.setOpaque(false);
  filament3.addEventHandler(this, "filament3_clicked");
  //Set Filament Rad Group
  filamentGroup.addControl(filament175);
  filament175.setSelected(true);
  filamentGroup.addControl(filament3);
  
  //Nozzle Label
  nozzleLabel = new GLabel(this, 1135, 440, 200, 20);
  nozzleLabel.setTextAlign(GAlign.CENTER, GAlign.LEFT);
  nozzleLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  nozzleLabel.setText("Nozzle Diameter:");
  nozzleLabel.setOpaque(false);
  //Nozzle Slider
  nozzleSlider = new GSlider(this, 1350, 430, 160, 40, 10.0);
  nozzleSlider.setShowValue(true);
  nozzleSlider.setLimits(0.5, 0.0, 1.0);
  nozzleSlider.setNumberFormat(G4P.DECIMAL, 2);
  nozzleSlider.setOpaque(false);
  nozzleSlider.addEventHandler(this, "nozzleSlider_change");

  //Layer Scale Label
  layerScaleLabel = new GLabel(this, 1115, 490, 200, 30);
  layerScaleLabel.setTextAlign(GAlign.CENTER, GAlign.LEFT);
  layerScaleLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  layerScaleLabel.setText("Layer Scale:");
  layerScaleLabel.setOpaque(false);
  //Layer Scale Slider
  layerScaleSlider = new GSlider(this, 1350, 485, 160, 40, 10.0);
  layerScaleSlider.setShowValue(true);
  layerScaleSlider.setLimits(0.2, 0.01, 0.4);
  layerScaleSlider.setNumberFormat(G4P.DECIMAL, 2);
  layerScaleSlider.setOpaque(false);
  layerScaleSlider.addEventHandler(this, "sliderLayerScale_change");

  //Warm Up Button
  warmUpBtn = new GButton(this, 1160, 550, 100, 50);
  warmUpBtn.setFont(new Font(Font_Type, Font.PLAIN, 16));
  warmUpBtn.setText("Warm Up Printer");
  warmUpBtn.addEventHandler(this, "warmUpBtn_click");
  
  //Homing Button
  homingBtn = new GButton(this, 1280, 550, 100, 50);
  homingBtn.setFont(new Font(Font_Type, Font.PLAIN, 16));
  homingBtn.setText("Homing");
  homingBtn.addEventHandler(this, "homingBtn_click");
  
  //Connect Button
  connectBtn = new GButton(this, 1400, 550, 100, 50);
  connectBtn.setFont(new Font(Font_Type, Font.PLAIN, 16));
  connectBtn.setText("Connect to Printer");
  connectBtn.addEventHandler(this, "connectBtn_click");
  
  //Status Label
  statusLabel = new GLabel(this, 1160, 800, 230, 30);
  statusLabel.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  statusLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  statusLabel.setText("Status:");
  statusLabel.setOpaque(false);


  //Right Arrow
  rightArrowbtn = new GButton(this, 1330, 720, 42, 36);
  rightArrowbtn.setIcon("ArrowRight.png", 1, GAlign.EAST, GAlign.RIGHT, GAlign.MIDDLE);
  rightArrowbtn.addEventHandler(this, "rightArrowbtn_click1");
  //Up Arrow
  upArrowbtn = new GButton(this, 1280, 690, 40, 41);
  upArrowbtn.setIcon("ArrowUp.png", 1, GAlign.EAST, GAlign.RIGHT, GAlign.MIDDLE);
  upArrowbtn.addEventHandler(this, "upArrowbtn_click1");
  //Left Arrow
  leftArrowbtn = new GButton(this, 1230, 720, 44, 36);
  leftArrowbtn.setIcon("ArrowLeft.png", 1, GAlign.EAST, GAlign.RIGHT, GAlign.MIDDLE);
  leftArrowbtn.addEventHandler(this, "leftArrowbtn_click1");
  //Down Arrow
  downArrowbtn = new GButton(this, 1280, 750, 40, 40);
  downArrowbtn.setIcon("ArrowDown.png", 1, GAlign.EAST, GAlign.RIGHT, GAlign.MIDDLE);
  downArrowbtn.addEventHandler(this, "downArrowbtn_click1");
  
  //Choose File Window
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
  
  //Warm Up Settings Window
  warmupWindow = GWindow.getWindow(this, "Warm Up Settings", 100, 100, 400, 250, JAVA2D);
  warmupWindow.noLoop();
  warmupWindow.addDrawHandler(this, "warmupWin_draw");
  //Head Temp
  headTempLabel = new GLabel(warmupWindow, 10, 10, 350, 30);
  headTempLabel.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  headTempLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  headTempLabel.setText("Head Temperature:");
  headTempLabel.setOpaque(false);
  headTempTextBox = new GTextField(warmupWindow, 180, 10, 70, 30, G4P.SCROLLBARS_NONE);
  headTempTextBox.setOpaque(true);
  headTempTextBox.addEventHandler(this, "headTempTextBox_change");
  //Bed Temp
  bedTempLabel = new GLabel(warmupWindow, 10, 100, 200, 30);
  bedTempLabel.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  bedTempLabel.setFont(new Font(Font_Type, Font.PLAIN, Font_Size));
  bedTempLabel.setText("Bed Temperature:");
  bedTempLabel.setOpaque(false);
  bedTempTextBox = new GTextField(warmupWindow, 180, 100, 70, 30, G4P.SCROLLBARS_NONE);
  bedTempTextBox.setOpaque(true);
  bedTempTextBox.addEventHandler(this, "bedTempTextBox_change");
  //Confirm
  warmupconfirmBtn = new GButton(warmupWindow, 10, 200, 80, 30);
  warmupconfirmBtn.setFont(new Font(Font_Type, Font.PLAIN, 16));
  warmupconfirmBtn.setText("Confirm");
  warmupconfirmBtn.addEventHandler(this, "warmupconfirmBtn_click");
  //Cancel
  warmupcancelBtn = new GButton(warmupWindow, 310, 200, 80, 30);
  warmupcancelBtn.setFont(new Font(Font_Type, Font.PLAIN, 16));
  warmupcancelBtn.setText("Cancel");
  warmupcancelBtn.addEventHandler(this, "warmupcancelBtn_click");
  warmupWindow.loop();
}

                                       //Variables:
GButton startSliceBtn;

GButton pauseSliceBtn;

GButton cancelPrintBtn;

//Choose File
GButton chooseFileBtn;
GLabel currentFile;
String STLFile;

//Serial Devices
GLabel serialDevicesLabel;
GDropList serialDevices;
String port;

//Baud Rate
Integer baudRate;
GLabel baudRateLabel;
GTextField baudRateTextBox;

GCheckbox printWhenReadyBox;

//Infill
GSlider infillSlider;
GLabel infillLabel;

//XYZ
GTextField xTextBox;
GTextField yTextBox;
GTextField zTextBox;
GLabel xLabel;
GLabel yLabel;
GLabel zLabel;

//Quality
GToggleGroup qualityGroup;
GOption qualityLowRad;
GOption qualityMedRad;
GOption qualityHighRad;
GLabel qualityLabel;

//Filament Diameter
GToggleGroup filamentGroup;
GOption filament175;
GOption filament3;
GLabel filamentLabel;
Float filament;

//Nozzle
GSlider nozzleSlider;
GLabel nozzleLabel;

//Layer
GSlider layerScaleSlider;
GLabel layerScaleLabel;

GButton warmUpBtn;

GButton homingBtn;

GButton connectBtn;

GLabel statusLabel;

GButton rightArrowbtn;
GButton upArrowbtn;
GButton leftArrowbtn;
GButton downArrowbtn;

//Choose File Window
GWindow inputWindow;
GTextField fileTextBox;
GButton searchFileBtn;
GTextArea gcodeTextBox;
GButton cancelInputBtn;
GButton confirmBtn;

//Warm Up Settings Window 
GWindow warmupWindow;
GLabel headTempLabel;
GTextField headTempTextBox;
GLabel bedTempLabel;
GTextField bedTempTextBox;
GButton warmupconfirmBtn;
GButton warmupcancelBtn;
Integer headTemp;
Integer bedTemp;


//Font Settings
String Font_Type = "Sans-Serif"; 
Integer Font_Size = 18;