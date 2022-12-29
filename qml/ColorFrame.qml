/* Copyright (C) 2022 Martin Pietsch <@pmfoss>
   SPDX-License-Identifier: BSD-3-Clause */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import KBBacklightControl

Frame {

   id: control

   property KBBacklightControl kbbacklightctl
   
   signal startColorChanged()
   signal finishColorChanged()

   ButtonGroup {
      id: colorModeGroup

      onClicked: (button) => { colorModeGroup.setSingleMulti(button == rbSingle) }

      function setSingleMulti(single)
      {
         if(!single)
         {
            wdgtLeftColor.label = qsTr("left color:")
            wdgtCenterColor.visible = true
            wdgtRightColor.visible = true
            wdgtExtraColor.visible = kbbacklightctl.extra
         }
         else
         {
            wdgtLeftColor.label = qsTr("color:")
            wdgtCenterColor.visible = false
            wdgtRightColor.visible = false
            wdgtExtraColor.visible = false
         }
      }
   }

   ColumnLayout { 

      Layout.alignment: Qt.AlignVCenter

      RowLayout {
         Layout.alignment: Qt.AlignVCenter
         RadioButton {
            id: rbSingle
            text: qsTr("single color")
            ButtonGroup.group: colorModeGroup
         }

         RadioButton {
            id: rbMulti
            text: qsTr("multiple colors")
            ButtonGroup.group: colorModeGroup
         }

         Component.onCompleted: { 
            var single = kbbacklightctl.color_left == kbbacklightctl.color_center && 
                         kbbacklightctl.color_left == kbbacklightctl.color_right &&
                         kbbacklightctl.color_left == kbbacklightctl.color_extra

            rbSingle.checked = single
            rbMulti.checked = !single
            colorModeGroup.setSingleMulti(single)
         }
      } 

      ColumnLayout {
         ColorComboBoxWidget {
            id: wdgtLeftColor
            label: qsTr("left color:")
            implicitWidth: wdgtCenterColor.implicitWidth
            color: kbbacklightctl.color_left


            Connections {
               target: wdgtLeftColor
               function onColorSelected(color) { 
                  control.setBacklightColor(KBBacklightControl.REGION_LEFT, color) 
                  if(colorModeGroup.checkedButton == rbSingle)
                  {
                     wdgtCenterColor.color = color
                     wdgtRightColor.color = color
                     wdgtExtraColor.color = color
                  }
               }
            }
         }

         ColorComboBoxWidget {
            id: wdgtCenterColor
            label: qsTr("center color:")
            color: kbbacklightctl.color_center

            Connections {
               target: wdgtCenterColor
               function onColorSelected(color) { control.setBacklightColor(KBBacklightControl.REGION_CENTER, color) }
            }
         }

         ColorComboBoxWidget {
            id: wdgtRightColor
            label: qsTr("right color:")
            implicitWidth: wdgtCenterColor.implicitWidth
            color: kbbacklightctl.color_right

            Connections {
               target: wdgtRightColor
               function onColorSelected(color) { control.setBacklightColor(KBBacklightControl.REGION_RIGHT, color) }
            }
         }

         ColorComboBoxWidget {
            id: wdgtExtraColor
            label: qsTr("extra color:")
            color: kbbacklightctl.color_extra
            visible: kbbacklightctl.extra
            implicitWidth: wdgtCenterColor.implicitWidth

            Connections {
               target: wdgtExtraColor
               function onColorSelected(color) { control.setBacklightColor(KBBacklightControl.REGION_EXTRA, color) }
            }
         }
      }
   }

   function setBacklightColor(region, color)
   {
      if(colorModeGroup.checkedButton == rbSingle && region == KBBacklightControl.REGION_LEFT || colorModeGroup.checkedButton == rbMulti)
      {
            control.startColorChanged()
      }

      switch(region)
      {
         case KBBacklightControl.REGION_LEFT: kbbacklightctl.color_left = color; break
         case KBBacklightControl.REGION_CENTER: kbbacklightctl.color_center = color; break
         case KBBacklightControl.REGION_RIGHT: kbbacklightctl.color_right = color; break
         case KBBacklightControl.REGION_EXTRA: kbbacklightctl.color_extra = color; break
      }

      if(colorModeGroup.checkedButton == rbSingle && region == KBBacklightControl.REGION_LEFT || colorModeGroup.checkedButton == rbMulti)
      {
         control.finishColorChanged()
      }
   }
}
