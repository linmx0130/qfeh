/*
    HistogramWindow.qml: window for displaying histograms
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
import QtQuick.Window

import me.mengxiaolin.qfeh.ImageHistogramChannelModel
import me.mengxiaolin.qfeh.ImageHistogramModel


Window {
    property string filename

    id: histogramWindow
    visible: true
    title: qsTr("Histogram")
    flags: "Dialog"
    minimumHeight: 512
    maximumHeight: 512
    minimumWidth: 512
    maximumWidth: 512

    ImageHistogramModel {
        id: histogramModel
        filename: histogramWindow.filename

    }
    Grid {
        rows: 2
        columns: 2
        spacing: 0
        Repeater {
            model: 4
            HistogramCanvas {
                histModel: histogramModel.channelCount > index ? histogramModel.data(index) : null;
            }
        }
    }
}
