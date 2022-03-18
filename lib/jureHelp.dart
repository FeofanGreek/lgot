import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:io';

import 'main.dart';
import 'news.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';

String Url = 'https://lgototvet.koldashev.ru/lgototvet.html';
bool outApp = false;


WebViewController _myController;

var counter = 1;

class PlayWithComputer extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<PlayWithComputer> {
  static const platform = MethodChannel('ru.koldashev.lgototvet/ads');
  Future<void> showInterstitial() async {
    platform.invokeMethod('showInterstitial');
    setState(() {});
  }

  Future<void> showBanner() async {
    platform.invokeMethod('showBanner');
    floatHeight = 200;
    setState(() {});
  }

  Future<void> hideBanner() async {
    platform.invokeMethod('hideBanner');
    floatHeight = 200;
    setState(() {});
  }

  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;



  Timer timer;

  @override
  void initState() {

    _connectivity.initialise();
      _connectivity.myStream.listen((source) {
        if (mounted) {setState(() => _source = source);}
        print("добавляем листенер");
      });

    timer = new Timer.periodic(Duration(seconds: 10), (timer) {

    });
    //hideBanner();
    super.initState();
  }

  /*void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if(selectedIndex == 0) {
      Navigator.of(context).pushNamed('/main');
      if(showScreenBanner == 0) {
        setState(() {
          showScreenBanner++;
        });
        //if (!interstitialReady) return;
        //interstitialAd.show();
        //interstitialReady = false;
        //interstitialAd = null;
      }else if(showScreenBanner == 1){setState(() {
        showScreenBanner++;
      });}else{setState(() {
        showScreenBanner=0;
      });}
    }
    if(selectedIndex == 1){
      Navigator.of(context).pushNamed('/news');
      if(showScreenBanner == 0) {
        setState(() {
          showScreenBanner++;
        });
        if (!interstitialReady) return;
        //interstitialAd.show();
        interstitialReady = false;
        //interstitialAd = null;
      }else if(showScreenBanner == 1){setState(() {
        showScreenBanner++;
      });}else{setState(() {
        showScreenBanner=0;
      });}
    }
    if(selectedIndex == 2){
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => PlayWithComputer()));
    }
  }*/

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (selectedIndex == 0) {
      Navigator.of(context).pushNamed('/main');
      if (showScreenBanner == 0) {
        setState(() {
          showScreenBanner++;
        });
        //showInterstitial();
        // if (!interstitialReady) return;
        // interstitialAd.show();
        // interstitialReady = false;
        // interstitialAd = null;
      } else if (showScreenBanner == 1) {
        setState(() {
          showScreenBanner++;
        });
      } else {
        setState(() {
          showScreenBanner = 0;
        });
      }
    }
    if (selectedIndex == 1) {
      Navigator.of(context).pushNamed('/news');
      if (showScreenBanner == 0) {
        setState(() {
          showScreenBanner++;
        });
        //showInterstitial();
        // if (!interstitialReady) return;
        // interstitialAd.show();
        // interstitialReady = false;
        // interstitialAd = null;
      } else if (showScreenBanner == 1) {
        setState(() {
          showScreenBanner++;
        });
      } else {
        setState(() {
          showScreenBanner = 0;
        });
      }
    }
    if (selectedIndex == 2) {
      //hideBanner();
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => PlayWithComputer()));
    }
  }

  @override
  Widget build(BuildContext context) {

    String string = "";

    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Отсутсвует связь!";
        return Scaffold(
          backgroundColor: Color(0xFFffffff),
          appBar: AppBar(
              title: Container(width: 200, height: 50, child: Stack( children: <Widget> [Positioned(left:0, top: 5, child: Image.asset('images/logo.png',  height: 44, width:99, ),),]),),
              centerTitle: false,
              backgroundColor: Color(0xFFFFFFFF),
              brightness: Brightness.light,
              // leading: Container(width: 250, margin: EdgeInsets.fromLTRB(20,10,10,10), child: Image.asset('images/lgotLogo.png',  height: 44, width:99, ),)
              actions: <Widget>[
                GestureDetector(
                    onTap: () {
                      callClient('88005113854');
                    },
                    child:
                    Container(
                        margin: EdgeInsets.fromLTRB(0,5,10,5),
                        child: RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                            text: '8 (800) 511-38-54 ', style: TextStyle(fontSize: 16.0, color: Color(0xFFFF2A24), fontFamily: 'Open Sans',fontWeight: FontWeight.bold ),
                            children: <TextSpan>[
                              TextSpan(text: '\nБесплатная юридическая', style: TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'Open Sans', fontWeight: FontWeight.bold)),
                              TextSpan(text: ' \nконсультация', style: TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'Open Sans', fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                    )
                ),
              ]
          ),
          body: Center(child: LinearProgressIndicator()/*Text("$string", style: TextStyle(fontSize: 36),textAlign: TextAlign.center,)*/),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time_outlined),
                label: 'Пособия',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description_outlined ),
                label: 'Новости',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded),
                label: 'Спросить',
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Color(0xFFFF2A24),
            onTap: _onItemTapped,
          ),
        );
        break;
      case ConnectivityResult.mobile:
        string = "Мобильные данные";
        return Scaffold(
          appBar: AppBar(
              title: Container(width: 200, height: 99, child: Stack( children: <Widget> [Positioned(left:0, top: 22, child: Image.asset('images/logo.png',  height: 44, width:99, ),),]),),
              centerTitle: false,
              backgroundColor: Color(0xFFFFFFFF),
              brightness: Brightness.light,
              actions: <Widget>[
                GestureDetector(
                    onTap: () {
                      callClient('88005113854');
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(0,5,10,5),
                        child: RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                            text: '8 (800) 511-38-54 ', style: TextStyle(fontSize: 16.0, color: Color(0xFFFF2A24), fontFamily: 'Open Sans',fontWeight: FontWeight.bold ),
                            children: <TextSpan>[
                              TextSpan(text: '\nБесплатная юридическая', style: TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'Open Sans', fontWeight: FontWeight.bold)),
                              TextSpan(text: ' \nконсультация', style: TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'Open Sans', fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                    )
                ),
              ]
          ),
          body: MyWebView(selectedUrl: Url),bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time_outlined),
              label: 'Пособия',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined ),
              label: 'Новости',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded),
              label: 'Спросить',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Color(0xFFFF2A24),
          onTap: _onItemTapped,
        ),
        );
        break;
      case ConnectivityResult.wifi:
        string = "Подключено к WiFi";
        return Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
            appBar: AppBar(
            title: Container(width: 200, height: 99, child: Stack( children: <Widget> [Positioned(left:0, top: 22, child: Image.asset('images/logo.png',  height: 44, width:99, ),),]),),
              centerTitle: false,
              backgroundColor: Color(0xFFFFFFFF),
              brightness: Brightness.light,
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    callClient('88005113854');
                  },
                  child: Container(
                  margin: EdgeInsets.fromLTRB(0,5,10,5),
                    child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                    text: '8 (800) 511-38-54 ', style: TextStyle(fontSize: 16.0, color: Color(0xFFFF2A24), fontFamily: 'Open Sans',fontWeight: FontWeight.bold ),
                      children: <TextSpan>[
                          TextSpan(text: '\nБесплатная юридическая', style: TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'Open Sans', fontWeight: FontWeight.bold)),
                          TextSpan(text: ' \nконсультация', style: TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'Open Sans', fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  )
                ),
              ]
            ),
                body: MyWebView(selectedUrl: Url),bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.access_time_outlined),
                      label: 'Пособия',
                      ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.description_outlined ),
                        label: 'Новости',
                      ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.message_rounded),
                        label: 'Спросить',
                      ),
                      ],
                    currentIndex: selectedIndex,
                  selectedItemColor: Color(0xFFFF2A24),
                  onTap: _onItemTapped,
                ),
              );
        break;
    }
  }

  @override
  void dispose() {
    //_connectivity.disposeStream();
    timer.cancel();
    super.dispose();
  }
}

callClient(url) async {
  if (await canLaunch('tel://$url')) {
    await launch('tel://$url');
  } else {
    throw 'Невозможно набрать номер $url';
  }
  print('пробуем позвонить');
}
//запускаем сайт
class MyConnectivity {
  MyConnectivity._internal();
  static final MyConnectivity _instance = MyConnectivity._internal();
  static MyConnectivity get instance => _instance;
  Connectivity connectivity = Connectivity();
  StreamController controller = StreamController.broadcast();
  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('https://lgototvet.koldashev.ru/lgototvet.html');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}

class MyWebView extends StatelessWidget {

  String selectedUrl;
  //final flutterWebviewPlugin = new FlutterWebviewPlugin();
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();


  MyWebView({
    @required this.selectedUrl,
  });

  //создаем тело виджета
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0,0,0,80),
        child:WebView(
            initialUrl: selectedUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
              _myController = webViewController;
            },
            onPageFinished: (url){
            }
        )
    );
  }

}
