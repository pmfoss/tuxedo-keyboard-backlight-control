/* Copyright (C) 2022 Martin Pietsch <@pmfoss>
   SPDX-License-Identifier: BSD-3-Clause */
import QtQuick 2.12

ListModel {
   
   id: colormodel

   function getColorIndex(color)
   {
      for(var i = 0; i < colormodel.count; i++)
      {
         var item = colormodel.get(i)
         if(item.code == color)
         {
            return i
         }
      }   
      return -1   
   }

   ListElement {
      name: qsTr("black")
      code: "#000000"
   }

   ListElement {
      name: qsTr("white")
      code: "#ffffff"
   }

   ListElement {
      name: qsTr("gray")
      code: "#808080"
   }

   ListElement {
      name: qsTr("silver")
      code: "#c0c0c0"
   }

   ListElement {
      name: qsTr("red")
      code: "#ff0000"
   }

   ListElement {
      name: qsTr("maroon")
      code: "#800000"
   }

   ListElement {
      name: qsTr("orange")
      code: "#ffa500"
   }

   ListElement {
      name: qsTr("orangered")
      code: "#ff4500"
   }

   ListElement {
      name: qsTr("yellow")
      code: "#ffff00"
   }

   ListElement {
      name: qsTr("olive")
      code: "#808000"
   }

   ListElement {
      name: qsTr("lime")
      code: "#00ff00"
   }

   ListElement {
      name: qsTr("green")
      code: "#008000"
   }

   ListElement {
      name: qsTr("aqua")
      code: "#00ffff"
   }

   ListElement {
      name: qsTr("teal")
      code: "#008080"
   }

   ListElement {
      name: qsTr("blue")
      code: "#0000ff"
   }

   ListElement {
      name: qsTr("navy")
      code: "#000080"
   }

   ListElement {
      name: qsTr("fuchsia")
      code: "#ff00ff"
   }

   ListElement {
      name: qsTr("purple")
      code: "#800080"
   }

   ListElement {
      name: qsTr("salmon")
      code: "#fa8072"
   }

   ListElement {
      name: qsTr("slateblue")
      code: "#6a5acd"
   }

   ListElement {
      name: qsTr("lightgreen")
      code: "#90ee90"
   }

   ListElement {
      name: qsTr("khaki")
      code: "#f0e68c"
   }
}

