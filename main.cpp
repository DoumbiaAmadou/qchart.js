#include "chart.h"
#include <QtQml>
#include <QApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQmlApplicationEngine>
#include <QGuiApplication>


int main(int argc, char *argv[])
{
  QApplication app(argc, argv);
  Chart * chart = new Chart() ;
  chart->addPie(new Pie(500,"#667054"));
  chart->addPie(new Pie(40,"#907562"));
  chart->addPie(new Pie(20,"#FF7054"));
  chart->addPie(new Pie(80,"#DD054"));
  chart->addPie(new Pie(60,"#CC7054"));
  qmlRegisterType<Pie>("Cpp", 1, 0, "Pie");
  qmlRegisterType<Chart>("Cpp", 1, 0, "Chart");

  QQmlApplicationEngine engine;
  engine.rootContext()->setContextProperty("currentPie" ,chart);
  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

  return app.exec();
}

