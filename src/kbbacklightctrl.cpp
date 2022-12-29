/* Copyright (C) 2022 Martin Pietsch <@pmfoss>
   SPDX-License-Identifier: BSD-3-Clause */

#include "kbbacklightctrl.hpp"

/*convert the value of a QColor instance to a int RGB value*/
inline uint32_t convertToRGB(QColor color)
{ 
   return color.red() << 16 | color.green() << 8 | color.blue();
}

const QString KBBacklightControl::SysPath = "/sys/devices/platform/tuxedo_keyboard/";

void KBBacklightControl::setMode(KBBacklightControl::Modes newmode)
{
   this->setValue(QStringLiteral("mode"), static_cast<uint32_t>(newmode)); 
   emit this->modeChanged();
}

KBBacklightControl::Modes KBBacklightControl::getMode() const
{
   return static_cast<KBBacklightControl::Modes>(this->getValue(QStringLiteral("mode")));
}

void KBBacklightControl::setBrightness(uint8_t newbrightness)
{
   this->setValue(QStringLiteral("brightness"), static_cast<uint32_t>(newbrightness)); 
   emit this->brightnessChanged();
}

uint8_t KBBacklightControl::getBrightness() const
{
   return static_cast<uint8_t>(this->getValue(QStringLiteral("brightness")));
}

void KBBacklightControl::setState(KBBacklightControl::States newstate)
{
   this->setValue(QStringLiteral("state"), static_cast<uint32_t>(newstate)); 
   emit this->stateChanged();
}

KBBacklightControl::States KBBacklightControl::getState() const
{
   return static_cast<KBBacklightControl::States>(this->getValue(QStringLiteral("state")));
}

bool KBBacklightControl::hasExtra() const
{
   return static_cast<bool>(this->getValue(QStringLiteral("extra")));
}

void KBBacklightControl::backupConfiguration(QFile &cfile)
{
   QString newname = cfile.fileName() + QDate::currentDate().toString(".yyyyMMdd");
   int i = 1;

   if(!cfile.copy(newname))
   {
      while(!cfile.copy(newname + QString(".%1").arg(i)))
      {
         i++;
      }
   }
}

void KBBacklightControl::saveConfiguration()
{
   QFile cfile = QStringLiteral(KBBACKLIGHTCTRL_CONFIGURATION_FILE);
   QMessageBox::StandardButton bqret;
   QString cline = QStringLiteral(KBBACKLIGHTCTRL_CONFIGURATION_LINE);

   if(cfile.exists())
   {
      bqret = QMessageBox::question(nullptr, 
         tr("Save Configuration"), 
         tr("Do you want to create a backup of the current configuration?"));

      if(bqret == QMessageBox::Yes)
      {
         this->backupConfiguration(cfile); 
      }
   } 

   if(cfile.open(QIODevice::WriteOnly))
   {
      cline = cline.arg(this->getState()) \
                 .arg(this->getMode()) \
                 .arg(this->getBrightness()) \
                 .arg(convertToRGB(this->getColorLeft()), 6, 16, QChar('0')) \
                 .arg(convertToRGB(this->getColorCenter()), 6, 16, QChar('0')) \
                 .arg(convertToRGB(this->getColorRight()), 6, 16, QChar('0')) \
                 .arg(convertToRGB(this->getColorExtra()), 6, 16, QChar('0'));
      cfile.write(cline.toLatin1());
      cfile.close();
   }
}

void KBBacklightControl::setColor(QColor& newcolor, KBBacklightControl::Regions region)
{
   switch(region)
   {
      case REGION_LEFT:
         this->setValue(QStringLiteral("color_left"), convertToRGB(newcolor), 16); 
         break;
          
      case REGION_CENTER:
         this->setValue(QStringLiteral("color_center"), convertToRGB(newcolor), 16); 
         break;
          
      case REGION_RIGHT:
         this->setValue(QStringLiteral("color_right"), convertToRGB(newcolor), 16); 
         break;
          
      case REGION_EXTRA:
         this->setValue(QStringLiteral("color_extra"), convertToRGB(newcolor), 16); 
         break;
   }

   emit this->colorChanged(region);
}

QColor KBBacklightControl::getColor(KBBacklightControl::Regions region) const
{
   uint32_t color = 0;

   switch(region)
   {
      case REGION_LEFT:
         color = this->getValue(QStringLiteral("color_left"), 16);
         break;

      case REGION_CENTER:
         color = this->getValue(QStringLiteral("color_center"), 16);
         break;

      case REGION_RIGHT:
         color = this->getValue(QStringLiteral("color_right"), 16);
         break;

      case REGION_EXTRA:
         color = this->getValue(QStringLiteral("color_extra"), 16);
         break;
   }
   
   return QColor(color); 
}

uint32_t KBBacklightControl::getValue(const QString& name, int base) const
{
   QFile pfile(KBBacklightControl::SysPath + name);
   QByteArray arr;
   QString retval;

   if(pfile.open(QIODeviceBase::ReadOnly))
   {
      retval = pfile.readLine();
      pfile.close();
   }
   
   return retval.toULong(nullptr, base); 
}

void KBBacklightControl::setValue(const QString& name, uint32_t newvalue, int base)
{
   QFile pfile(KBBacklightControl::SysPath + name);

   if(pfile.open(QIODeviceBase::WriteOnly))
   {
      if(base == 16)
      {
         pfile.write(QString("0x%1").arg(newvalue, 6, base, QChar('0')).toLatin1());
      }
      else
      {
         pfile.write(QString("%1").arg(newvalue, 0, base).toLatin1());
      }
      pfile.close();
   }
}

