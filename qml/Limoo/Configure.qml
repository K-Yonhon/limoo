import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1

Rectangle {
    width: 100
    height: 62
    color: "#333333"

    Text {
        id: title
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 15*physicalPlatformScale
        width: parent.width
        font.pointSize: 20*physicalPlatformScale
        font.weight: Font.Light
        horizontalAlignment: Text.AlignLeft
        color: "#ffffff"
    }

    Column {
        id: column
        anchors.left: parent.left
        anchors.top: title.bottom
        anchors.right: parent.right
        anchors.margins: 20*physicalPlatformScale
        spacing: 4*physicalPlatformScale

        Text {
            id: conf_btn
            width: parent.width
            font.pointSize: 10*physicalPlatformScale
            font.weight: Font.Light
            horizontalAlignment: Text.AlignLeft
            color: "#ffffff"
        }

        ComboBox {
            width: parent.width
            onCurrentTextChanged: if(inited) Limoo.currentLanguage = currentText
            Component.onCompleted: {
                var lang = Limoo.currentLanguage
                model = Limoo.languages
                currentIndex = find(lang)
                inited = true
            }

            property bool inited: false
        }

        Item { width:5; height: 5*physicalPlatformScale }

        CheckBox {
            id: nrml_thumb_check
            checked: Limoo.nrmlThumbnailBar
            style: CheckBoxStyle {
                label: Text {
                    font.pointSize: 10*physicalPlatformScale
                    font.weight: Font.Light
                    horizontalAlignment: Text.AlignLeft
                    color: "#ffffff"
                    text: control.text
                }
            }

            property bool lcheck: Limoo.nrmlThumbnailBar
            onLcheckChanged: checked = lcheck
            onCheckedChanged: Limoo.nrmlThumbnailBar = checked
        }

        Item { width:5; height: 5*physicalPlatformScale }

        CheckBox {
            id: fcr_thumb_check
            checked: Limoo.fcrThumbnailBar
            style: CheckBoxStyle {
                label: Text {
                    font.pointSize: 10*physicalPlatformScale
                    font.weight: Font.Light
                    horizontalAlignment: Text.AlignLeft
                    color: "#ffffff"
                    text: control.text
                }
            }

            property bool lcheck: Limoo.fcrThumbnailBar
            onLcheckChanged: checked = lcheck
            onCheckedChanged: Limoo.fcrThumbnailBar = checked
        }
    }

    LanguageSwitcher {
        onRefresh: {
            title.text = qsTr("Configure")
            conf_btn.text = qsTr("Language")
            nrml_thumb_check.text = qsTr("Thumbnalbar")
            fcr_thumb_check.text = qsTr("Fullscreen Thumbnalbar")
        }
    }
}
