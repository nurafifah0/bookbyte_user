import 'package:bookbyte_user/models/user.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BillScreen extends StatefulWidget {
  final User user;
  final double totalprice;

  const BillScreen({super.key, required this.user, required this.totalprice});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  var loadingPercentage = 0;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    print(widget.user.userphone);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
            'https://afifah.infinitebe.com/bookbyte/php/payment.php?&userid=${widget.user.userid}&email=${widget.user.useremail}&phone=${widget.user.userphone}&name=${widget.user.username}&amount=${widget.totalprice}'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bill"),
      ),
      body: Center(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
 

 /*  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bill"),
        ),
        body: Center(
          child: WebView(
            initialUrl:
                'https://infinitebe.com/bookbyte/php/payment.php?&userid=${widget.user.userid}&email=${widget.user.useremail}&phone=${widget.user.userphone}&name=${widget.user.username}&amount=${widget.totalprice}',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              // prg = progress as double;
              // setState(() {});
              // print('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              // print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              //print('Page finished loading: $url');
              setState(() {
                //isLoading = false;
              });
            },
          ),
        ));
  }
}
 */