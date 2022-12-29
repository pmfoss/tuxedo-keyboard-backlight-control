/* Copyright (C) 2022 Martin Pietsch <@pmfoss>
   SPDX-License-Identifier: BSD-3-Clause */

#include <QApplication>
#include <QMessageBox>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStyleFactory>
#include <QTranslator>
#include <unistd.h>
#include "about.hpp"

using namespace Qt::StringLiterals;

int main(int argc, char **argv)
{
   QApplication app(argc,argv);
   QQmlApplicationEngine engine;
   QTranslator translator;
   About about;
   int retval = -1;

   app.setWindowIcon(QIcon(":/assets/icon.svg"));
   if(translator.load(QLocale(), ""_L1, ""_L1, ":/i18n"_L1))
   {
      app.installTranslator(&translator);    
   }
  
   if(getuid() == 0)
   {
      engine.rootContext()->setContextProperty("about", &about);
      engine.load(QUrl("qrc:///KBBacklightControl/qml/MainWindow.qml"));
      retval = app.exec();      
   }
   else
   {
      QMessageBox::information(nullptr, QStringLiteral("Tuxedo Keyboard Backlight Control"), translator.translate("Application", "This program needs root privileges to run!")); 
   }

   return retval;
}
