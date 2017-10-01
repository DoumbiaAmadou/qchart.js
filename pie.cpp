#include "pie.h"

int Pie::value() const
{
  return m_value;
}

QString Pie::color() const
{
  return m_color;
}

Pie::Pie(QObject *parent)
{
  m_value = 90 ;
  m_color = "#666666" ;
}

Pie::Pie(int value ,QString color ,QObject *parent) : QObject(parent)
{
  m_value = value ;
  m_color = color ;
}
