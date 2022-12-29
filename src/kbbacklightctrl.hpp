/* Copyright (C) 2022 Martin Pietsch <@pmfoss>
   SPDX-License-Identifier: BSD-3-Clause */

#ifndef KBBACKLIGHTCTRL_H
#define KBBACKLIGHTCTRL_H

#include <QObject>
#include <QColor>
#include <QDate>
#include <QFile>
#include <QIODevice>
#include <QMessageBox>
#include <QtQml/qqml.h>

/*path to the configuration file of the module*/
#define KBBACKLIGHTCTRL_CONFIGURATION_FILE "/etc/modprobe.d/tuxedo_keyboard.conf"

/*template content of the configuration file*/
#define KBBACKLIGHTCTRL_CONFIGURATION_LINE "options tuxedo-keyboard state=%1 mode=%2 brightness=%3 color_left=0x%4 color_center=0x%5 color_right=0x%6 color_extra=0x%7"

class KBBacklightControl : public QObject
{
   Q_OBJECT
   QML_ELEMENT

   public:
      /*enumeration of the backlight modes*/
      enum Modes {
         MODE_CUSTOM = 0,
         MODE_BREATHE,
         MODE_CYCLE,
         MODE_DANCE,
         MODE_FLASH,
         MODE_RANDOM_COLOR,
         MODE_TEMPO,
         MODE_WAVE
      };
      Q_ENUM(Modes)

      /*enumeration of the keyboard regions*/
      enum Regions {
         REGION_LEFT = 0,
         REGION_CENTER,
         REGION_RIGHT,
         REGION_EXTRA
      };
      Q_ENUMS(Regions)

      /*enumeration of the backlight states*/
      enum States {
         STATE_OFF = 0,
         STATE_ON
      };
      Q_ENUM(States)

   private: 
      /*mode of the keyboard backlight. see enum Modes*/
      Q_PROPERTY(KBBacklightControl::Modes mode READ getMode WRITE setMode NOTIFY modeChanged)
      /*value of the keyboard backlights brightness*/
      Q_PROPERTY(uint8_t brightness READ getBrightness WRITE setBrightness NOTIFY brightnessChanged)
      /*state of the keyboard backlight. see enum States*/
      Q_PROPERTY(KBBacklightControl::States state READ getState WRITE setState NOTIFY stateChanged)
      /*contains true if the keyboard has an EXTRA region, otherwise false*/
      Q_PROPERTY(bool extra READ hasExtra CONSTANT)
      /*color of the left keyboard backlight region*/
      Q_PROPERTY(QColor color_left READ getColorLeft WRITE setColorLeft NOTIFY colorChanged)
      /*color of the center keyboard backlight region*/
      Q_PROPERTY(QColor color_center READ getColorCenter WRITE setColorCenter NOTIFY colorChanged)
      /*color of the right keyboard backlight region*/
      Q_PROPERTY(QColor color_right READ getColorRight WRITE setColorRight NOTIFY colorChanged)
      /*color of the EXTRA keyboard backlight region*/
      Q_PROPERTY(QColor color_extra READ getColorExtra WRITE setColorExtra NOTIFY colorChanged)

      /*path to the sysfs driver files*/
      static const QString SysPath;

   public:
      using QObject::QObject;
      /*sets the mode of the keyboard backlight*/
      void setMode(KBBacklightControl::Modes newmode);
      /*returns the mode of the keyboard backlight*/
      KBBacklightControl::Modes getMode() const; 
      /*sets the brightness of the keyboard backlight*/
      void setBrightness(uint8_t newbrightness);
      /*returns the brightness of the keyboard backlight*/
      uint8_t getBrightness() const;
      /*sets the state of the keyboard backlight*/
      void setState(KBBacklightControl::States newstate);
      /*returns the state of the keyboard backlight*/
      KBBacklightControl::States getState() const;
      /*returns true, if the keyboard has an EXTRA region. Otherwise false.*/
      bool hasExtra() const;
      /*sets the color of the left keyboard backlight region*/
      inline void setColorLeft(QColor newcolor) 
             { this->setColor(newcolor, KBBacklightControl::REGION_LEFT); }
      /*sets the color of the center keyboard backlight region*/
      inline void setColorCenter(QColor newcolor) 
             { this->setColor(newcolor, KBBacklightControl::REGION_CENTER); }
      /*sets the color of the right keyboard backlight region*/
      inline void setColorRight(QColor newcolor) 
             { this->setColor(newcolor, KBBacklightControl::REGION_RIGHT); }
      /*sets the color of the EXTRA keyboard backlight region*/
      inline void setColorExtra(QColor newcolor) 
             { this->setColor(newcolor, KBBacklightControl::REGION_EXTRA); }
      /*returns the color of the left keyboard backlight region*/
      inline QColor getColorLeft() const
             { return this->getColor(KBBacklightControl::REGION_LEFT); }
      /*returns the color of the center keyboard backlight region*/
      inline QColor getColorCenter() const
             { return this->getColor(KBBacklightControl::REGION_CENTER); }
      /*returns the color of the right keyboard backlight region*/
      inline QColor getColorRight() const
             { return this->getColor(KBBacklightControl::REGION_RIGHT); }
      /*returns the color of the extra keyboard backlight region*/
      inline QColor getColorExtra() const
             { return this->getColor(KBBacklightControl::REGION_EXTRA); }

      /*save the current keyboard backlight setting to the configuration file*/
      Q_INVOKABLE void saveConfiguration();

   signals:
      /*emitted if the mode of the keyboard backlight is changed*/
      void modeChanged();
      /*emitted if the state of the keyboard backlight is changed*/
      void stateChanged();
      /*emitted if the brightness of the keyboard backlight is changed*/
      void brightnessChanged();
      /*emitted if the color of a keyboard backlight region is changed*/
      void colorChanged(KBBacklightControl::Regions region);

   protected:
      /*creates a backup of the existing configuration file*/
      void backupConfiguration(QFile &cfile);
      /*sets the color of a specific keyboard backlight region*/
      void setColor(QColor& newcolor, KBBacklightControl::Regions region);
      /*returns the color of a specific keyboard backlight region*/
      QColor getColor(KBBacklightControl::Regions region) const;
      /*sets the value of a specific property of the keyboard backlight*/
      void setValue(const QString& name, uint32_t newvalue, int base = 10);
      /*returns the value of a specific property of the keyboard backlight*/
      uint32_t getValue(const QString& name, int base = 10) const;
};

#endif /*KBBACKLIGHTCTRL_H*/
