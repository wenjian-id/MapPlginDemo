#include "/home/ai-ad/Qt5.9.2/5.9.2/gcc_64/include/QtGui/QGuiApplication"
#include "/home/ai-ad/Qt5.9.2/5.9.2/gcc_64/include/QtQml/QQmlApplicationEngine"
#include <QtPlugin>

int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);

    Q_IMPORT_PLUGIN(GeoServiceProviderFactory)

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();


}

