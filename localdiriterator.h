/*
    localdiriterator.h: the header of LocalDirIterator
    Copyright (C) 2020 Mengxiao Lin <linmx0130@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#ifndef LOCALDIRITERATOR_H
#define LOCALDIRITERATOR_H

#include <QObject>
#include <QString>
#include <QUrl>

class LocalDirIterator:public QObject {
    Q_OBJECT
    Q_PROPERTY(QUrl currentFilename READ currentFilename NOTIFY currentFilenameChanged)
    Q_PROPERTY(bool empty READ empty NOTIFY emptyChanged)
public:
    LocalDirIterator(QObject *parent = nullptr, const QString& path= "");
    bool empty() const;
    QUrl currentFilename() const;

    Q_INVOKABLE void nextImage();
    Q_INVOKABLE void previousImage();

signals:
    void emptyChanged();
    bool currentFilenameChanged();


private:
    QVector<QString> imageList;
    unsigned int position;
};

#endif // LOCALDIRITERATOR_H
