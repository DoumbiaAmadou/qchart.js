#include "chart.h"

Chart::Chart(QObject *parent) : QObject(parent)
{
  m_pieList= QList<Pie*>();
}

void Chart::addPie(Pie *pie)
{
  m_pieList<<pie;
}


QQmlListProperty<Pie> Chart::getPieList(){

  return QQmlListProperty<Pie>(this ,m_pieList);
}

QQmlListProperty<Pie> Chart::getPieListChild()
{
  return QQmlListProperty<Pie>(this ,m_child);
}

void Chart::addChild(Pie *pie)
{
  m_child<< pie ;
}

