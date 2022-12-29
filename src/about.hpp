#ifndef ABOUT_H
#define ABOUT_H

#include <QMessageBox>
#include <QObject>

class About : public QObject
{
   Q_OBJECT

   public:
     explicit About() { }

     Q_INVOKABLE void aboutQt();
     Q_INVOKABLE void about();
};

#endif /*ABOUT_H*/
