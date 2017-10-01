#ifndef PIE_H
#define PIE_H

#include <QObject>
#include <QString>

class Pie : public QObject
{
  Q_OBJECT
  Q_PROPERTY(int value READ value  NOTIFY valueChanged)
  Q_PROPERTY(QString color READ color NOTIFY colorChanged)

  int m_value ;
  QString m_color ;

public:
   explicit Pie( QObject *parent = 0);
  explicit Pie(int value , QString color,  QObject *parent = 0);

  int value() const;

  QString color() const;

signals:

  void valueChanged();
  void colorChanged();

public slots:
};

#endif // PIE_H
