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

    ImageHistogramModel {
        id: histModel
        filename: parent.filename
        onFilenameChanged: {
            histCanvas.requestPaint()
        }
    }

    Canvas {
        id: histCanvas
        anchors.fill: parent
        width: 320
        height: 320
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
                    var y = Math.max(300 - Math.log(1 + allChannel.get(i) / maxVal) * 300, 0)
                    ctx.fillRect(i, y, 2, 300);
                }
            }
        }
    }
}
