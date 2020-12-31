/*
    localdiriterator.cpp: the implementation of LocalDirIterator
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

#include "localdiriterator.h"
#include <QDir>

LocalDirIterator::LocalDirIterator(QObject *parent, const QString& path): QObject(parent), position(0){
    QDir dir(path);
    dir.setFilter(QDir::Files);
    qDebug("reading path: %s\n", path.toStdString().c_str());
    auto files = dir.entryInfoList().toVector();
    for (const QFileInfo& finfo: files) {
        QString path = finfo.absoluteFilePath();
        if (path.endsWith(".jpg", Qt::CaseInsensitive) || path.endsWith(".png", Qt::CaseInsensitive)) {
            imageList.append(path);
        }
    }
}

bool LocalDirIterator::empty() const {
    return imageList.length() == 0;
}

void LocalDirIterator::nextImage() {
    position++;
    if (position >= imageList.length()) {
        position = 0;
    }
    emit currentFilenameChanged();
}

void LocalDirIterator::previousImage() {
    position--;
    if (position == -1) {
        position = imageList.length() - 1;
    }
    emit currentFilenameChanged();
}

QUrl LocalDirIterator::currentFilename() const {
    if (empty()) return QUrl("qrc:/images/noimage.jpg");
    return QUrl("file:" + imageList[position]);
}
