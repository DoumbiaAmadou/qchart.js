#ifndef CHART_H
#define CHART_H
#include "pie.h"

#include <QQmlListProperty>
#include <QObject>

class Chart : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QQmlListProperty<Pie> pieList READ getPieList  NOTIFY pieChanged)
  Q_PROPERTY(QQmlListProperty<Pie> pieListChild READ getPieListChild  NOTIFY pieChanged)

  QList<Pie*> m_child ;
  QList<Pie*> m_pieList ;

public:
  explicit Chart(QObject *parent = 0);
  void addPie(Pie* pie );

  QQmlListProperty<Pie> getPieList() ;
  QQmlListProperty<Pie> getPieListChild();
  void addChild(Pie *pie);

//  Q_INVOKABLE Pie *getChild();

signals:
  void pieChanged();




};

#endif // CHART_H
