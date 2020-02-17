import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main.dart';
import 'Models/localize_and_translate.dart';
import 'dart:io';
class InAppWebViewExampleScreen extends StatefulWidget {
  @override
  _InAppWebViewExampleScreenState createState() =>
      new _InAppWebViewExampleScreenState();
}

class _InAppWebViewExampleScreenState extends State<InAppWebViewExampleScreen> {
  InAppWebViewController webView;
  String url="https://www.a966a.com/gerken/app/product.aspx";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffc4dbea),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xffc4dbea),
            title: Text(translator.translate('gerken'),
              style: TextStyle(color: Colors.black,fontFamily: "NetworkUpdate"),)
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
//              accountName: new Text("Pratap Kumar"),
//              accountEmail: new Text("kprathap23@gmail.com"),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: AssetImage('resources/gerken.jpeg'),fit: BoxFit.fill,
                  ),
                ),
//              currentAccountPicture: CircleAvatar(
//                  backgroundImage: NetworkImage(
//                      "https://randomuser.me/api/portraits/men/46.jpg")),
              ),
              new ListTile(
                  leading: Icon(
                    FontAwesomeIcons.signOutAlt,size: 20,
                    color: Color(0xFF7F7E96),
                  ),
                  title: new Text("تسجيل الخروج"),
                  onTap: () {
                    setState(() {
                      if (webView != null) {
                        webView.loadUrl(url: 'https://www.a966a.com/gerken/app/logout.aspx');
                      }
                    });
                    Navigator.pop(context);
                  }),
              new ListTile(
                  leading:  Icon(
                    FontAwesomeIcons.productHunt,size: 20,
                    color: Color(0xFF7F7E96),
                  ),
                  title: new Text("المنتجات"),
                  onTap: () {
                    setState(() {
                      if (webView != null) {
                        webView.loadUrl(url: 'https://www.a966a.com/gerken/app/product.aspx');
                      }
                    });
                    Navigator.pop(context);
                  }),
              new ListTile(
                  leading: Icon(Icons.shopping_cart,size: 20,
                    color: Color(0xFF7F7E96),),
                  title: new Text("طلباتي"),
                  onTap: () {
                    setState(() {
                      if (webView != null) {
                        webView.loadUrl(url: 'https://www.a966a.com/gerken/app/order.aspx');
                      }
                    });
                    Navigator.pop(context);
                  }),
              new ListTile(
                  leading:  Icon(
                    Icons.location_on,size: 20,
                    color: Color(0xFF7F7E96),
                  ),
                  title: new Text("تغيرالعنوان"),
                  onTap: () {
                    setState(() {
                      if (webView != null) {
                        webView.loadUrl(url: 'https://www.a966a.com/gerken/app/update_address.aspx');
                      }
                    });
                    Navigator.pop(context);
                  }),

              new Divider(),
              new ListTile(
                leading: Icon(Icons.power_settings_new,size: 20,
                  color: Color(0xFF7F7E96),),
                title: new Text("خروج"),
                onTap: () =>  exit(0),
              )],
          ),
        ),
        body: SafeArea(
            child: Column(children: <Widget>[
              Container(
                color: Color(0xffc4dbea),
                  padding: EdgeInsets.all(0.10),
                  child: progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container()),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(0.1),
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.transparent)),
                  child: InAppWebView(
                    initialUrl: url,
                    //initialFile: "assets/index.html",
                    initialHeaders: {},
                    initialOptions: InAppWebViewWidgetOptions(
//                        crossPlatform: InAppWebViewOptions(
//                          debuggingEnabled: true,
//                        )
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                    onLoadStart: (InAppWebViewController controller, String url) {
                      print("onLoadStart $url");
                      setState(() {
                        this.url = url;
                      });
                    },
                    onLoadStop: (InAppWebViewController controller, String url) async {
                      print("onLoadStop $url");
                      setState(() {
                        this.url = url;
                      }); 
                    },
                    onProgressChanged: (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                    onUpdateVisitedHistory: (InAppWebViewController controller, String url, bool androidIsReload) {
                      print("onUpdateVisitedHistory $url");
                      setState(() {
                        this.url = url;
                      });
                    },
                  ),
                ),
              ),
            ]))
    );
  }
}