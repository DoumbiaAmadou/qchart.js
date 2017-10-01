#ifndef CHART_H
#define CHART_H
#include "pie.h"

#include <QQmlListProperty>
#include <QObject>

class Chart : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QQmlListProperty<Pie> pieList READ getPieList  NOTIFY pieChanged)


  QList<Pie*> m_pieList ;

public:
  explicit Chart(QObject *parent = 0);
  void addPie(Pie* pie );

  QQmlListProperty<Pie> getPieList() ;

signals:
  void pieChanged();




};

#endif // CHART_H
