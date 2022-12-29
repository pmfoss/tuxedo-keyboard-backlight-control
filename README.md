# TUXEDO Keyboard Backlight Control

![Screenshot](./asset/screenshot.png "Screenshot")

## Description

This small tool takes the idea of the [TUXEDO Backlight Control](https://github.com/webketje/tuxedo-backlight-control) tool. It currently provides only a graphical interface. But the advantage of this tool is the opportunity to store the user defined settings to the configuration file of the [tuxedo-keyboard](https://github.com/tuxedocomputers/tuxedo-keyboard) kernel module.

The program does not claim to be completed or to provide and support a program for productive use.

## Requirements

gcc, cmake, Qt6, [tuxedo-keyboard](https://github.com/tuxedocomputers/tuxedo-keyboard) kernel module

## Compiling and running

```
mkdir build
cd build
cmake ..
cmake --build .
sudo ./tuxedo-keyboard-backlight-control
```

## License

BSD-3-Clause
