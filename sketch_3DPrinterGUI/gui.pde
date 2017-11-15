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

public void startSliceBtn_click(GButton source, GEvent event) { //_CODE_:startSliceBtn:735941:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:startSliceBtn:735941:

public void pauseSliceBtn_click(GButton source, GEvent event) { //_CODE_:pauseSliceBtn:624877:
  println("pauseSliceBtn - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:pauseSliceBtn:624877:

public void cancelPrintBtn_click(GButton source, GEvent event) { //_CODE_:cancelPrintBtn:781425:
  println("cancelPrintBtn - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:cancelPrintBtn:781425:

public void qualitySlider_change(GSlider source, GEvent event) { //_CODE_:infillSlider:696453:
  println("slider1 - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:infillSlider:696453:

public void qualityLowRad_clicked(GOption source, GEvent event) { //_CODE_:qualityLowRad:596469:
  println("qualityLowRad - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:qualityLowRad:596469:

public void qualityMedRad_clicked(GOption source, GEvent event) { //_CODE_:qualityMedRad:556993:
  println("qualityMedRad - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:qualityMedRad:556993:

public void qualityHighRad_clicked(GOption source, GEvent event) { //_CODE_:qualityHighRad:770558:
  println("qualityHighRad - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:qualityHighRad:770558:

public void printWhenReadyBox_clicked(GCheckbox source, GEvent event) { //_CODE_:printWhenReadyBox:392431:
  println("printWhenReadyBox - GCheckbox >> GEvent." + event + " @ " + millis());
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
  //Show the input Window
  inputWindow.setVisible(true);
} //_CODE_:chooseFileBtn:320943:

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

public void searchFileBtn_click(GButton source, GEvent event) { //_CODE_:searchFileBtn:687641:
  println("searchFileBtn - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:searchFileBtn:687641:

public void gcodeTextBox_change(GTextArea source, GEvent event) { //_CODE_:gcodeTextBox:726640:
  println("textarea1 - GTextArea >> GEvent." + event + " @ " + millis());
} //_CODE_:gcodeTextBox:726640:

public void cancelInputBtn_click(GButton source, GEvent event) { //_CODE_:cancelInputBtn:629030:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
  inputWindow.setVisible(false);
  
} //_CODE_:cancelInputBtn:629030:

public void confirmBtn_click(GButton source, GEvent event) { //_CODE_:confirmBtn:275116:
  println("confirmBtn - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:confirmBtn:275116:



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
  infillSlider.setLimits(1, 0, 100);
  infillSlider.setNbrTicks(100);
  infillSlider.setNumberFormat(G4P.INTEGER, 0);
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
  chooseFileBtn = new GButton(this, 710, 70, 80, 30);
  chooseFileBtn.setText("Choose File");
  chooseFileBtn.addEventHandler(this, "chooseFileBtn_click");
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