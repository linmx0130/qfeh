/*
    imagehistogrammodel.h: the header of histogram data model
    Copyright (C) 2021 Mengxiao Lin <linmx0130@gmail.com>

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

#ifndef IMAGEHISTOGRAMMODEL_H
#define IMAGEHISTOGRAMMODEL_H

#include <QAbstractListModel>
#include <QColor>
#include <QVector>
#include <QString>
#include <QUrl>

class ImageHistogramChannelModel: public QObject {
    Q_OBJECT
    Q_PROPERTY(QString channelName READ channelName)
    Q_PROPERTY(QColor displayColor READ displayColor)
public:
    ImageHistogramChannelModel( QObject* parent=nullptr, const QString& channelName="", const QColor& displayColor=QColorConstants::White, const QVector<double>& histogram=QVector<double>()):
        QObject(parent), mChannelName(channelName), mDisplayColor(displayColor), mHistogram(histogram)
    {}
    ImageHistogramChannelModel(const ImageHistogramChannelModel & m):
        ImageHistogramChannelModel(m.parent(), m.channelName(), m.displayColor(), m.mHistogram)
    {}
    ImageHistogramChannelModel& operator=(const ImageHistogramChannelModel &m)
    {
        mChannelName = m.channelName();
        mDisplayColor = m.displayColor();
        mHistogram = m.mHistogram;
        return (*this);
    }
    Q_INVOKABLE double get(int index) const {
        return mHistogram[index];
    }
    QString channelName() const{
        return mChannelName;
    }
    QColor displayColor() const {
        return mDisplayColor;
    }

private:
    QString mChannelName;
    QColor mDisplayColor;
    QVector<double> mHistogram;
};

class ImageHistogramModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl filename READ filename WRITE setFilename NOTIFY histogramChanged)
    Q_PROPERTY(int channelCount READ channelCount NOTIFY histogramChanged)
public:

    ImageHistogramModel(QObject *parent=0, const QUrl& filename=QUrl(""));
    Q_INVOKABLE ImageHistogramChannelModel* data(const int index);
    QUrl filename() const {
        return mFilename;
    }
    int channelCount() const {
        return mChannels.size();
    }
public slots:
    void setFilename(const QUrl& filename);
signals:
    void histogramChanged();
private:
    QUrl mFilename;
    QVector<ImageHistogramChannelModel> mChannels;
    void recomputeHistogram();
};

#endif // IMAGEHISTOGRAMMODEL_H
