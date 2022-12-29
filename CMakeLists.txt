cmake_minimum_required(VERSION 3.16)
project(tuxedo-keyboard-backlight-control VERSION 1.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 COMPONENTS Core Quick Widgets LinguistTools REQUIRED)

include_directories(
        ${PROJECT_SOURCE_DIR}/src
)

qt_add_executable(tuxedo-keyboard-backlight-control
    src/main.cpp
    src/about.cpp src/about.hpp
)

qt_add_qml_module(tuxedo-keyboard-backlight-control
    URI KBBacklightControl
    VERSION 1.0
    QML_FILES
       qml/ColorComboBox.qml
       qml/ColorComboBoxWidget.qml
       qml/ColorFrame.qml
       qml/ColorListModel.qml
       qml/MainWindow.qml
       qml/ModeListModel.qml
    SOURCES
       ${CMAKE_CURRENT_SOURCE_DIR}/src/kbbacklightctrl.hpp 
       ${CMAKE_CURRENT_SOURCE_DIR}/src/kbbacklightctrl.cpp
    
)

qt_add_translations(tuxedo-keyboard-backlight-control
    TS_FILES
    i18n/base.ts 
    i18n/de.ts)

qt_add_resources(tuxedo-keyboard-backlight-control images
     PREFIX /
     FILES "assets/icon.svg"
)

target_link_libraries(tuxedo-keyboard-backlight-control PRIVATE 
   Qt6::Core
   Qt6::Widgets
   Qt6::Quick
)

