/*
    HistogramCanvas.qml: canvas for displaying a histogram
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

import QtQuick 2.0
import me.mengxiaolin.qfeh.ImageHistogramChannelModel

Canvas {
    width: 256
    height: 256
    property ImageHistogramChannelModel histModel
    onPaint: {
        var ctx = getContext("2d")
        ctx.fillStyle="black"
        ctx.fillRect(0, 0, 256, 256)
        if (histModel == null) {
            return;
        }
        var maxVal = 0;
        for (var i=0;i<256;++i) {
            if (histModel.get(i) > maxVal) {
                maxVal = histModel.get(i);
            }
        }
        ctx.moveTo(0, 256);
        ctx.fillStyle = histModel.displayColor
        for (i=0;i<256;++i) {
            var y = Math.max(256 - histModel.get(i) / maxVal * 256, 0);
            ctx.fillRect(i, y, 2, 256);
        }
    }
}
