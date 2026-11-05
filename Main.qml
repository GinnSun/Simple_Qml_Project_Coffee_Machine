import QtQuick
import QtQuick.Controls

Window {
    width: 1000
    height: 800
    visible: true
    title: "Smart Coffee Machine"


    SwipeView {
        id: view
        anchors.fill: parent

        Column {
            id: mainPage
            padding: 5
            spacing: 10
            Switch {
                anchors.rightMargin: 10
                id: language
                height: 25
                text: "Russian"
                font.pixelSize: 12
                checked: true
                anchors.right: mainPage.right
            }


            Text {
                text: language.checked ? "Выберите кофе" : "Choose Coffee"
                font.pixelSize: 40
                font.bold: true
                anchors.horizontalCenter: mainPage.horizontalCenter
            }

            Switch {
                id: powerSwitch
                text: language.checked ? "Питание" : "Power"
                font.pixelSize: 14
                checked: false
            }

            ButtonGroup { id: coffee }

            RadioButton {
                enabled: powerSwitch.checked
                text: language.checked ? "Эспрессо" : "Espresso"
                ButtonGroup.group: coffee
            }
            RadioButton {
                text: language.checked ? "Американо" : "Americano"
                ButtonGroup.group: coffee
                enabled: powerSwitch.checked
            }
            RadioButton {
                text: language.checked ? "Капучино" : "Capuchino"
                ButtonGroup.group: coffee
                enabled: powerSwitch.checked
            }

            Row {
                spacing: 5
                Slider {
                    id: strengthOfCoffee
                    from: 0
                    to: 5
                    stepSize: 1
                    value: 0
                    enabled: powerSwitch.checked
                }
                Text {
                    font.pixelSize: 12
                    text: (language.checked ? "Крепость: " : "Strength: ") + strengthOfCoffee.value
                    enabled: powerSwitch.checked
                }
            }
            Button {
                width: 300
                height: 50
                font.pixelSize: 30
                text: language.checked && powerSwitch.checked ? "Приготовить" : powerSwitch.checked ? "Cook" : !powerSwitch.checked && language.checked ? "Питание выключено" : "Power is off"
                enabled: powerSwitch.checked
            }
        }

        Column {
            id: settingsPage
            spacing: 20
            padding: 10
            Row {
                width: 400
                Slider {
                    id: tSlider
                    from: 80
                    to: 100
                    stepSize: 0.5
                    value: 80
                }
                Text {
                    text: (language.checked ? "Температура: " : "Temperature: ") + tSlider.value
                    font.pixelSize: 12
                }
            }
            CheckBox {
                text: language.checked ? "Автоотчистка" : "Auto Cleaning"
                font.pixelSize: 14
                checked: true
            }
            TextField {
                placeholderText: language.checked ? "Введите имя" : "Enter name"
                font.pixelSize: 14
            }
            Text {
                text: language.checked ? "Индикатор уровня воды" : "Indicator of water level"
                font.pixelSize: 14
                font.bold: true
            }
            Rectangle {
                id: waterLevel
                color: "white"
                width: 50
                height: 200
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width - 10
                    height: (parent.width - 10) * (strengthOfCoffee.value > 0 ? strengthOfCoffee.value : 1)
                    color: "lightblue"
                }
            }
        }

        Column {
            id: informationPage
            padding: 10
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: 20
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    asynchronous: true
                    smooth: true
                    source: "Imgs/coffe_machine.png"
                    width: 250
                    height: 250
                }
                TextArea {
                    horizontalAlignment: Text.AlignHCenter
                    width: 600
                    height: 250
                    wrapMode: TextArea.WordWrap
                    readOnly: true
                    text: language.checked ?
                              "Компактная кофемашина для идеального утра. Одно нажатие, и вы получаете насыщенный эспрессо, нежный капучино или ароматный латте с плотной молочной пеной. Встроенная кофемолка сохраняет аромат свежих зёрен, а простое управление и съёмный контейнер для воды делают уход за машиной лёгким. Современный дизайн впишется в любую кухню."
                                           :
                                             "A compact coffee machine for a perfect morning. With one touch, enjoy a rich espresso, a smooth cappuccino, or a fragrant latte topped with velvety milk foam. The built-in grinder preserves the aroma of fresh beans, while simple controls and a removable water tank make maintenance effortless. Its modern design fits any kitchen."

                    font.pixelSize: 16

                }
            }
        }
    }

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
