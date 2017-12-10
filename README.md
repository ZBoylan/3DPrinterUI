# 3DPrinterUI
## CS 350 - UI team
https://github.com/ZBoylan/3DPrinterUI

### Description
This project contains the GUI of a generic 3D printer using Processing 3.3.6. This is a free open-source project open to the public for modifications.

### Prerequisites
Things that are needed for running and editing the software:
* Java 8
* Processing 3.3.6

Within Processing 3.3.6, a couple libraries are needed for running the gui.pde:

* g4p_controls
* ToxicLibs (for temporary render)

### Installation
To install the project for testing purposes, download the project from the provided GitHub link or clone the repository onto your computer.  

To install Processing:
> Go to https://processing.org/download/ > Download the latest version of Processing for your operating system > Follow installation instructions provided.

To add the required libraries to Processing:
> Open Processing > _Sketch_ > _Import Library_ > _Add Library_ > _G4P_ and _ToxicLibs_.

To run gui.pde correctly, be sure to include all files/packages from other groups which are:
* Slicing
    - Facet.pde
    - Layer.pde
    - Line.pde
    - Model.pde
    - STLConverter.pde
    - STLParser.pde
    - Slicer.pde
* Rendering
* Device Controller
    - DeviceController.java

### Usage
To run the gui:
> Go to where the project is located > Open _gui.pde_ > Click the "Run" button (button that looks like a "Play" symbol).

### Authors
* Zaid Bhujwala
* Zachary Boylan
* Rebecca Peralta
* George Ventura
