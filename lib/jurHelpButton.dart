import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:io';

import 'main.dart';
import 'news.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';

String Url = 'https://lgototvet.koldashev.ru/2.html';
bool outApp = false;


WebViewController _myController;

var counter = 1;

class jureHelpButton extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<jureHelpButton> {
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
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if(selectedIndex == 0) {
      Navigator.of(context).pushNamed('/main');
      if(showScreenBanner == 0) {
        setState(() {
          showScreenBanner++;
        });
        if (!interstitialReady) return;
        interstitialAd.show();
        interstitialReady = false;
        interstitialAd = null;
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
        interstitialAd.show();
        interstitialReady = false;
        interstitialAd = null;
      }else if(showScreenBanner == 1){setState(() {
        showScreenBanner++;
      });}else{setState(() {
        showScreenBanner=0;
      });}
    }
    if(selectedIndex == 2){
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => jureHelpButton()));
    }
  }

  @override
  Widget build(BuildContext context) {

    String string = "";

    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Отсутсвует связь!";
        return Scaffold(
          backgroundColor: Colors.transparent,

          body: Container(),

        );
        break;
      case ConnectivityResult.mobile:
        string = "Мобильные данные";
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: MyWebView(selectedUrl: Url),
        );
        break;
      case ConnectivityResult.wifi:
        string = "Подключено к WiFi";
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: MyWebView(selectedUrl: Url),
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
      final result = await InternetAddress.lookup('https://lgototvet.koldashev.ru/2.html');
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
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();


  MyWebView({
    @required this.selectedUrl,
  });

  //создаем тело виджета
  @override
  Widget build(BuildContext context) {
    return WebView(
        opaque: false,
        initialUrl: selectedUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
          _myController = webViewController;
        },
        onPageFinished: (url){
        }
    );
  }

}
