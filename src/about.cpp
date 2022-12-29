/* Copyright (C) 2022 Martin Pietsch <@pmfoss>
   SPDX-License-Identifier: BSD-3-Clause */

#include "about.hpp"

void About::aboutQt()
{
   QMessageBox::aboutQt(nullptr, tr("About Qt"));
}

void About::about()
{
   QMessageBox::about(nullptr, tr("About ..."), tr(
                     "<p><h3>About TUXEDO Keyboard Backlight Control</h3></p> <p>This small tool takes the idea of the <a href=\"https://github.com/webketje/tuxedo-backlight-control\">TUXEDO Backlight Control</a> tool. It currently provides only a graphical interface. But the advantage of this tool is the opportunity to store the user defined settings to the configuration file of the <a href=\"https://github.com/tuxedocomputers/tuxedo-keyboard\">tuxedo-keyboard</a> kernel module.<br /> The program does not claim to be completed or to provide and support a program for productive use.</p> <p>The source code is licensed under the BSD-3-Clause-License and published on <a href=\"https://github.com/pmfoss/tuxedo-keyboard-backlight-control\">Github</a></p> <p>Copyright (C) 2022 Martin Pietsch (@pmfoss)</p>"));
}
