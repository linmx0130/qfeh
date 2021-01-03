#include "imagehistogrammodel.h"
#include <QImage>
#include <QFileInfo>

ImageHistogramModel::ImageHistogramModel(QObject *parent, const QUrl& filename):
    QObject(parent)
{
    setFilename(filename);
}

ImageHistogramChannelModel* ImageHistogramModel::data(const int index)
{
    if (index < 0 || index > mChannels.size()) {
        return nullptr;
    }
    return &mChannels[index];
}

void ImageHistogramModel::setFilename(const QUrl &filename)
{
    QFileInfo fileinfo(filename.path());
    if (!fileinfo.isFile() || !fileinfo.isReadable()) {
        qDebug("Cannot open file: %s\n", filename.toString().toStdString().c_str());
        return;
    }
    mFilename = filename.path();
    QImage img(mFilename.toString());
    QVector<QString> channelName = QVector<QString> {"All", "Red", "Green", "Blue"};
    QVector<QColor> displayColor = QVector<QColor> {
            QColorConstants::White,
            QColorConstants::Red,
            QColorConstants::Green,
            QColorConstants::Blue};
    QVector<QVector<int>> counter(4, QVector<int>(256));

    for (int x=0;x<img.width();++x){
        for (int y=0;y<img.height();++y) {
            QColor pix = QColor::fromRgb(img.pixel(x, y));
            counter[0][pix.lightness()] += 1;
            counter[1][pix.red()] += 1;
            counter[2][pix.green()] += 1;
            counter[3][pix.blue()] += 1;
        }
    }
    mChannels.clear();
    int totalPixel = img.height() * img.width();
    for (int i=0;i<4;++i) {
        QVector<double> histogram(256, 0);
        for (int j=0;j<256;++j) {
            histogram[j] = (double)counter[i][j] / totalPixel;
        }
        mChannels.push_back(ImageHistogramChannelModel(this, channelName[i], displayColor[i], histogram));
    }
    qDebug("Size %d x %d\n", img.height(), img.width());

    emit filenameChanged();
}


