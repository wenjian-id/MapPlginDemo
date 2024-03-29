import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.3
import QtLocation       5.3
import QtPositioning    5.3

Window {
    id: main
    visible: true
    height: 700
    width: 1000

    /*对GPS坐标做处理，Wps84转Gcj-02*/
    property real pi: 3.1415926535897932384626
    property real a: 6378245.0
    property real ee: 0.00669342162296594323;


    function transformLat(x , y)
    {
        var ret
        ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * Math.sqrt(Math.abs(x))
        ret += (20.0 * Math.sin(6.0 * x * pi) + 20.0 * Math.sin(2.0 * x * pi)) * 2.0 / 3.0
        ret += (20.0 * Math.sin(y * pi) + 40.0 * Math.sin(y / 3.0 * pi)) * 2.0 / 3.0
        ret += (160.0 * Math.sin(y / 12.0 * pi) + 320 * Math.sin(y * pi / 30.0)) * 2.0 / 3.0
        return ret
    }

    function transformLon(x, y) {
        var ret
        ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * Math.sqrt(Math.abs(x))
        ret += (20.0 * Math.sin(6.0 * x * pi) + 20.0 * Math.sin(2.0 * x * pi)) * 2.0 / 3.0
        ret += (20.0 * Math.sin(x * pi) + 40.0 * Math.sin(x / 3.0 * pi)) * 2.0 / 3.0
        ret += (150.0 * Math.sin(x / 12.0 * pi) + 300.0 * Math.sin(x / 30.0 * pi)) * 2.0 / 3.0
        return ret
    }

    function  wps84_To_Gcj02(lat, lon) {
        var dLat, dLon, radLat, magic, sqrtMagic , mgLat, mgLon
        dLat = transformLat(lon - 105.0, lat - 35.0);
        dLon = transformLon(lon - 105.0, lat - 35.0);
        radLat = lat / 180.0 * pi;
        magic = Math.sin(radLat);
        magic = 1 - ee * magic * magic;
        sqrtMagic = Math.sqrt(magic);
        dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
        dLon = (dLon * 180.0) / (a / sqrtMagic * Math.cos(radLat) * pi);
        mgLat = lat + dLat;
        mgLon = lon + dLon;

        return  QtPositioning.coordinate(mgLat, mgLon);
    }


    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    Map {
        id: _map
        anchors.fill: parent
        zoomLevel:                  18
        center:                     wps84_To_Gcj02(23.06, 113.4, 0.0)
        gesture.flickDeceleration:  3000

        // 地图插件
        plugin: Plugin { name: "Gaode" }

    }

}
