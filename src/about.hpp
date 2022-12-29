/* Copyright (C) 2022 Martin Pietsch <@pmfoss>
   SPDX-License-Identifier: BSD-3-Clause */

#ifndef ABOUT_H
#define ABOUT_H

#include <QMessageBox>
#include <QObject>

class About : public QObject
{
   Q_OBJECT

   public:
     explicit About() { }

     /*shows the "AboutQt" dialog*/ 
     Q_INVOKABLE void aboutQt();
     /*shows the "About dialog*/ 
     Q_INVOKABLE void about();
};

#endif /*ABOUT_H*/
