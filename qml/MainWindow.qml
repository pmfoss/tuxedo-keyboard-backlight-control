/* Copyright (C) 2022 Martin Pietsch <@pmfoss>
   SPDX-License-Identifier: BSD-3-Clause */
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 2.12
import KBBacklightControl

ApplicationWindow {
   id: awMain
   visible: true
   width: lytContent.implicitWidth + 10
   height: lytContent.implicitHeight + 20
   title: "TUXEDO Keyboard Backlight Control"
   
   property int backupModeIndex

   KBBacklightControl {
      id: kbbacklightctl
   }
   
   ModeListModel {
      id: modeModel

      Component.onCompleted: { modeModel.initCodes() }
   }
  
   SystemPalette { id: sysPalette }

   palette {
      window: sysPalette.window
      base: sysPalette.base
      button: sysPalette.button
      text: sysPalette.text
      windowText: sysPalette.windowText
      placeholderText: sysPalette.placeholderText
      buttonText: sysPalette.buttonText
      highlight: sysPalette.highlight
   }

   menuBar: MenuBar {
               Menu {
                  title: qsTr("Program")
 
                  Action { 
                     text: qsTr("Save configuration")
                     shortcut: "Ctrl+S"
                     onTriggered: { kbbacklightctl.saveConfiguration() }
                  }
                  MenuSeparator { }
                  Action {
                     text: qsTr("About Qt")
                     onTriggered: { about.aboutQt() }
                  }
                  Action {
                     text: qsTr("About ...")
                     onTriggered: { about.about() }
                  }
                  MenuSeparator { }
                  Action { 
                     text: qsTr("Quit")
                     shortcut: "Alt+F4"
                     onTriggered: { Qt.quit() }
                  }
               }
            }

   ColumnLayout {
      id: lytContent
      anchors.fill: parent

      CheckBox {
         id: cbState
         checked: kbbacklightctl.state
         text: kbbacklightctl.state ? qsTr("backlight is on") : qsTr("backlight is off")
         onClicked: { kbbacklightctl.state = (cbState.checked ? KBBacklightControl.STATE_ON : KBBacklightControl.STATE_OFF) }
      }

      RowLayout {
         Layout.alignment: Qt.AlignCenter
         Text {
            text: qsTr("Mode:")
            color: parent.palette.buttonText
         }

         ComboBox {
            id: cbMode
            model: modeModel 
            currentIndex: modeModel.getIndexOfMode(kbbacklightctl.mode) 
            textRole: "text"
            popup {
               y: cbMode.height - 1
            }

            onActivated: (index) => { kbbacklightctl.mode = cbMode.model.get(index).code }           
         }
      } 

      Timer {
         id: tmResetMode
         interval: 500 
         repeat: false
         onTriggered: kbbacklightctl.mode = cbMode.model.get(awMain.backupModeIndex).code
      }

      ColorFrame {
         Layout.alignment: Qt.AlignCenter
         id: frmColor
         kbbacklightctl: kbbacklightctl    
         visible: cbMode.model.get(cbMode.currentIndex).customcolor

         onStartColorChanged: { 
               awMain.backupModeIndex = cbMode.currentIndex 
               kbbacklightctl.mode = KBBacklightControl.MODE_CUSTOM
            } 

         onFinishColorChanged: { tmResetMode.start() }
      }

      RowLayout {
         Layout.alignment: Qt.AlignCenter
         Layout.topMargin: 5
         Layout.bottomMargin: 20
         Text {
            text: qsTr("brightness:")
            color: parent.palette.buttonText
         }
 
         Slider {
            id: sldBrightness
            from: 0
            to: 255
            stepSize: 1
            value: kbbacklightctl.brightness

            ToolTip {
               parent: sldBrightness.handle
               visible: sldBrightness.pressed
               text: Number(sldBrightness.value * 100 / 255).toLocaleString(Qt.locale(), "f", 2) + "%"
            }

            onMoved: { kbbacklightctl.brightness = sldBrightness.value }
         }
      }
   }
}
