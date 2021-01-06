/*
    main.qml: Main window
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

import QtQuick
import QtQuick.Window
import QtQuick.Controls



ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("qfeh")
    id: root
    background: Rectangle {
        color: "gray"
    }

    property variant histWindow: null

    function showHistogramWindow() {
        if (histWindow === null) {
            var comp = Qt.createComponent("HistogramWindow.qml")
            histWindow = comp.createObject(root)
        }
        histWindow.filename = image.source
        histWindow.show()
    }

    Image {
        id:image
        focus: true
        source: (localDirIterator==null || localDirIterator.empty) ? 'qrc:/images/noimage.jpg': localDirIterator.currentFilename
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        asynchronous: true
        Keys.onPressed: {
            switch (event.key) {
                case Qt.Key_N:
                    localDirIterator.nextImage()
                    break
                case Qt.Key_P:
                    localDirIterator.previousImage()
                    break
                case Qt.Key_Q:
                    Qt.exit(0)
                    break
                case Qt.Key_H:
                    helpDialog.show()
                    break
                case Qt.Key_I:
                    showHistogramWindow()
                    break
            }
        }
        onSourceChanged: {
            if (histWindow !== null) {
                histWindow.close()
            }
        }
    }

    Window {
        id: helpDialog
        visible: false
        title: qsTr("Help")
        flags: "Dialog"
        width: content.width + 32
        height: content.height + 32

        Column {
            id: content
            focus: true
            spacing: 16
            anchors.centerIn: parent
            Label {
                text: "qfeh - feh implemented with Qt Quick"
                font.family: "Sans Serif"
                font.pixelSize: 20
            }

            Label {
                text: "P - Previous Image \nN - Next Image\nI - Open Histogram View\nQ - Quit"
                font.family: "Sans Serif"
                font.pixelSize: 14
            }
            Label {
                text: "Copyright 2020 Mengxiao Lin <linmx0130@gmail.com>\nLicensed with GPL v3"
                font.family: "Sans Serif"
                font.pixelSize: 14
            }

            Keys.onPressed: {
                helpDialog.close()
            }
        }
    }
}
