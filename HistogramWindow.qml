import QtQuick 2.0
import QtQuick.Window

import me.mengxiaolin.qfeh.ImageHistogramChannelModel
import me.mengxiaolin.qfeh.ImageHistogramModel

Window {
    property string filename

    id: histogramWindow
    visible: true
    title: qsTr("Histogram")
    flags: "Tool"
    width: 300
    height: 300

    ImageHistogramModel {
        id: histModel
        filename: histogramWindow.filename
        onHistogramChanged: {
            histCanvas.requestPaint()
        }
    }
    onFilenameChanged: {
        console.log("Filename received: ", filename);
    }

    Canvas {
        id: histCanvas
        anchors.fill: parent
        width: 300
        height: 300
        onPaint: {
            var ctx = getContext("2d")
            ctx.fillStyle="black"
            ctx.fillRect(0, 0, 300, 300)
            console.log("Histogram channel count =", histModel.channelCount)
            if (histModel.channelCount > 0) {
                var allChannel = histModel.data(0)
                var maxVal = 0;
                for (var i=0;i<256;++i) {
                    if (allChannel.get(i) > maxVal) {
                        maxVal = allChannel.get(i);
                    }
                }
                console.log("Max val=", maxVal)
                ctx.moveTo(0, 300);
                ctx.fillStyle=allChannel.displayColor
                for (i=0;i<256;++i) {
                    var y = Math.max(300 - allChannel.get(i) / maxVal * 270, 0);
                    ctx.fillRect(i, y, 2, 300);
                }
            }
        }
    }
}
