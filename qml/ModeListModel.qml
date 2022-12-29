/* Copyright (C) 2022 Martin Pietsch <@pmfoss>
   SPDX-License-Identifier: BSD-3-Clause */
import QtQuick
import KBBacklightControl

ListModel {

   id: lstmodel

   ListElement {
      text: qsTr("Color")
      code: 0
      customcolor: true 
   }

   ListElement {
      text: qsTr("Breathe")
      code: 1
      customcolor: true
   }

   ListElement {
      text: qsTr("Cycle")
      code: 2
      customcolor: false
   }

   ListElement {
      text: qsTr("Dance")
      code: 3 
      customcolor: false
   }

   ListElement {
      text: qsTr("Flash")
      code: 4 
      customcolor: false
   }

   ListElement {
      text: qsTr("Random Color")
      code: 5
      customcolor: false
   }

   ListElement {
      text: qsTr("Tempo")
      code: 6
      customcolor: false
   }

   ListElement {
      text: qsTr("Wave")
      code: 7 
      customcolor: false 
   }

   /*Workaround: QTBUG-96555*/
   function initCodes()
   {
      lstmodel.get(0).code = KBBacklightControl.MODE_CUSTOM
      lstmodel.get(1).code = KBBacklightControl.MODE_BREATHE
      lstmodel.get(2).code = KBBacklightControl.MODE_CYCLE
      lstmodel.get(3).code = KBBacklightControl.MODE_DANCE
      lstmodel.get(4).code = KBBacklightControl.MODE_FLASH
      lstmodel.get(5).code = KBBacklightControl.MODE_RANDOM_COLOR
      lstmodel.get(6).code = KBBacklightControl.MODE_TEMPO
      lstmodel.get(7).code = KBBacklightControl.MODE_WAVE
   }

   function getIndexOfMode(mode)
   {
      for(var idx = 0; idx < lstmodel.count; idx++)
      {
         if(lstmodel.get(idx).code == mode)
         {
            return idx
         }
      }

      return 0
   }
}
