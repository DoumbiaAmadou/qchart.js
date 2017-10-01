TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    pie.cpp \
    chart.cpp

RESOURCES += qml.qrc


# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    pie.h \
    chart.h


