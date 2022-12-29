/* Copyright (C) 2022 Martin Pietsch <@pmfoss>
   SPDX-License-Identifier: BSD-3-Clause */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Pane {
   id: control

   property alias label: lblText.text
   property alias color: cbColor.color
   property alias model: cbColor.model

   signal colorSelected(color color)

   RowLayout {
 
      anchors.fill: parent
  
      Text {
         id: lblText
         Layout.alignment: Qt.AlignLeft 
         color: parent.palette.text
      }

      ColorComboBox {
         id: cbColor
         Layout.alignment: Qt.AlignRight 

         onColorSelected: (color) => { control.colorSelected(color) }
      }
   }
}
