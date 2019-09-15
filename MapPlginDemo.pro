TEMPLATE = app
INCLUDEPATH += "/home/ai-ad/Qt5.9.2/5.9.2/gcc_64/include"

QT += qml quick  location  network
CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

include(QtLocationPlugin/LocationPlugin.pri)

INCLUDEPATH += \
    QtLocationPlugin \


LOCATION_PLUGIN_DESTDIR = $${OUT_PWD}/QtLocationPlugin
LOCATION_PLUGIN_NAME    = GeoServiceProviderFactory


