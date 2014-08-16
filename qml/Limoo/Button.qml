/*
    Copyright (C) 2014 Sialan Labs
    http://labs.sialan.org

    Limoo is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Limoo is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.2

Rectangle {
    id: button
    smooth: true
    width: row.width + 20*physicalPlatformScale
    height: 30*physicalPlatformScale
    color: press? highlightColor : normalColor

    property alias text: txt.text
    property alias icon: icn.source
    property alias fontSize: txt.font.pixelSize
    property alias textFont: txt.font

    property alias hoverEnabled: marea.hoverEnabled

    property alias iconHeight: icn.height
    property bool iconCenter: false

    property alias press: marea.pressed
    property alias enter: marea.containsMouse
    property alias cursorShape: marea.cursorShape

    property string highlightColor: "#333333"
    property string normalColor: "#00000000"
    property alias textColor: txt.color

    signal clicked()

    Row {
        id: row
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: 3*physicalPlatformScale
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 4*physicalPlatformScale

        Image {
            id: icn
            anchors.verticalCenter: parent.verticalCenter
            sourceSize: Qt.size(width,height)
            height: source==""? 0 : parent.height-12*physicalPlatformScale
            width: height
            smooth: true
        }

        Text{
            id: txt
            y: parent.height/2 - height/2 - 1*physicalPlatformScale
            color: "#ffffff"
//            font.bold: true
            font.family: globalFontFamily
            font.pixelSize: 9*fontsScale
        }
    }

    MouseArea{
        id: marea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: button.clicked()
    }
}
