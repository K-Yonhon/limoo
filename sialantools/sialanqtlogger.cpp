/*
    Copyright (C) 2014 Sialan Labs
    http://labs.sialan.org

    This project is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This project is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "sialanqtlogger.h"

#include <QDebug>
#include <QFile>
#include <QDateTime>

QSet<SialanQtLogger*> sialan_qt_logger_objs;

void sialanQtLoggerFnc(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    foreach( SialanQtLogger *obj, sialan_qt_logger_objs )
        obj->logMsg(type,context,msg);
}

class SialanQtLoggerPrivate
{
public:
    QFile *file;
};

SialanQtLogger::SialanQtLogger(const QString &path, QObject *parent) :
    QObject(parent)
{
    p = new SialanQtLoggerPrivate;
    p->file = new QFile(path);
    p->file->open(QFile::WriteOnly);

    sialan_qt_logger_objs.insert(this);
    if( sialan_qt_logger_objs.count() == 1 )
        qInstallMessageHandler(sialanQtLoggerFnc);
}

void SialanQtLogger::logMsg(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    QByteArray localMsg = msg.toLocal8Bit();
    QString text = QString(": (%2:%3, %4) %5 : %1\n").arg(localMsg.constData()).arg(context.file).arg(context.line).arg(context.function).arg(QTime::currentTime().toString());

    switch (type) {
    case QtDebugMsg:
        text = "Debug" + text;
        p->file->write(text.toUtf8());
        p->file->flush();
        break;
    case QtWarningMsg:
        text = "Warning" + text;
        p->file->write(text.toUtf8());
        p->file->flush();
        break;
    case QtCriticalMsg:
        text = "Critical" + text;
        p->file->write(text.toUtf8());
        p->file->flush();
        break;
    case QtFatalMsg:
        text = "Fatal" + text;
        p->file->write(text.toUtf8());
        p->file->flush();
        abort();
    default:
        break;
    }
}

void SialanQtLogger::debug(const QVariant &var)
{
    qDebug() << var;
}

SialanQtLogger::~SialanQtLogger()
{
    sialan_qt_logger_objs.remove(this);
    if( sialan_qt_logger_objs.isEmpty() )
        qInstallMessageHandler(0);

    delete p;
}
