# Package EMB Add-In

This is a basic implementation for packaging the EMB add-in files

* EMBonds_32.xll
* EMBonds_64.xll
* Sample_Pricing_Sheet.xlsm

The **add-in.zip** contains these files plus some extra files including a VBScript that is invoked from the **index.html** and **app.js**.

The file **app.json** points to the current hosted directory on *http://dev.embonds.com/addin/* where the installation file [Install.zip](http://dev.embonds.com/addin/install.zip) is located.

## Usage
To test the installation:
1. Download [Install.zip](http://dev.embonds.com/addin/install.zip) to your local machine.
2. Extract the contents on your desktop.
3. Run the installation executable.
4. When the Openfin application opens, click on **Install AddIn** button. It will invoke excel and open the pricing sheet.


