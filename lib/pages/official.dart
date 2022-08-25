import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:starwars/pages/component/app_bar_layout.dart';

class OfficialPage extends StatefulWidget {
  const OfficialPage({Key? key}) : super(key: key);

  @override
  State<OfficialPage> createState() => _OfficialPageState();
}

class _OfficialPageState extends State<OfficialPage> {
  late InAppWebViewController webView;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBarLayout(context, null,'pop'),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest:
                URLRequest(url: Uri.parse("https://www.starwars.com/")),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
          )
        ],
      ),
    );
  }
}
