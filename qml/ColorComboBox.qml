/* Copyright (C) 2022 Martin Pietsch <@pmfoss>
   SPDX-License-Identifier: BSD-3-Clause */
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

ComboBox {

   id: control
   ColorListModel { id: colorModel }
   
   property color color
   property int lastIndex : 0

   signal colorSelected(color color)

   ColorDialog {
      id: clrdlg

      onAccepted: function()
           {
               control.color = clrdlg.selectedColor
           }

      onRejected: function()
           {
              control.currentIndex = control.lastIndex
           }
   }

   model: colorModel 

   contentItem: Grid {
                   spacing: 10
                   columns: 2
                   padding: 2
                   verticalItemAlignment: Grid.AlignVCenter
                   Rectangle {
                      border.color: control.palette.text
                      border.width: 1
                      color: control.model.get(control.currentIndex).code
                      width: 30
                      height: 20
                   }
                   Text {
                      text: control.model.get(control.currentIndex).name
                      font: control.font
                      color: control.palette.text
                      verticalAlignment: Text.AlignVCenter
                      elide: Text.ElideRight
                   }
                }

    popup: Popup {
              height: contentItem.implicitHeight + 2
              y: control.height - 1
              width: control.width
              padding: 1
              contentItem: Flow {
                 Repeater {
                    model: control.popup.visible ? control.model : null
                    delegate: Rectangle {
                       border.color: control.currentIndex === index ? control.palette.highlight : control.palette.text
                       border.width: control.currentIndex === index ? 2 : 1
                       color: control.model.get(index).code
                       width: 20
                       height: 20
                       
                       ToolTip {
                          text: control.model.get(index).name
                          visible: ma.containsMouse
                       }

                       MouseArea {
                          id: ma
                          anchors.fill: parent
                          hoverEnabled: true
                          acceptedButtons: Qt.LeftButton
                          onClicked: function()
                            {
                               control.color = color
                               control.popup.close()
                            }
                       }
                    }
                 }
                 Rectangle {
                    width: parent.width - 1
                    height: 30
                    color: control.palette.base
                    Text {
                       text: qsTr("more ...")
                       verticalAlignment: Text.AlignVCenter
                       anchors.centerIn: parent
                       color: control.palette.text
                    }

                    MouseArea {
                       anchors.fill: parent
                       acceptedButtons: Qt.LeftButton
                       onClicked: function()
                          {
                             control.activated(control.model.count - 1)
                          }
                       }
                 }
              }
           }

    onColorChanged: function()
         {
            var clridx = control.model.getColorIndex(control.color)

            if(clridx == -1)
            {
               clridx = control.model.count - 1

               if(control.model.get(clridx).name[0] === "#")
               {
                  control.model.set(clridx, { name: control.color.toString(), code: control.color.toString() })
               }
               else
               {
                  control.model.append({ name: control.color.toString(), code: control.color.toString() })
                  clridx++
               }
            }
            control.currentIndex = clridx
            control.lastIndex = clridx

            control.colorSelected(control.model.get(clridx).code)
         } 

    onActivated: function(index) 
         {
            if(index == control.model.count - 1)
            {
               clrdlg.open()
            } 
         }
}
