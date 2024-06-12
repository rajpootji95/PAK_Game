
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String gameUrl;

  const WebViewScreen({super.key,required this.gameUrl});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
    late final WebViewController webViewController;
    ValueNotifier<int> loadingPercentage = ValueNotifier(0);


    @override
  void initState() {
    // TODO: implement initState

    webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          debugPrint("On page started url : $url");
          setState(() {
            loadingPercentage.value = 0;
          });
        },
        onProgress: (progress) {
          debugPrint("Page progress : $progress");
          setState(() {
            loadingPercentage.value = progress;
          });
        },
        onPageFinished: (url) {
          debugPrint("On Page finished Url : $url");
          setState(() {
            loadingPercentage.value = 100;
          });
        },
        onNavigationRequest: (navigationRequest) {
          final String host = Uri.parse(navigationRequest.url).host;
          if (host.contains("youtube.com")) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Navigation to $host is blocked")));
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
      )
    )
      ..loadRequest(
          Uri.parse(widget.gameUrl)
      );
    super.initState();
    // WebViewPlatform.instance;

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Pak\n=games=",textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
            actions: [
              IconButton(
                  onPressed: () async {
                    if (await webViewController.canGoBack()) {
                      await webViewController.goBack();
                    } else {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text("No Back History Found")));
                    }
                  },
                  icon: const Icon(Icons.arrow_back)),
              IconButton(
                  onPressed: () async {
                    if (await webViewController.canGoForward()) {
                      await webViewController.goForward();
                    } else {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text("No Forward History Fund")));
                    }
                  },
                  icon: const Icon(Icons.arrow_forward)),
              IconButton(
                  onPressed: () {
                    webViewController.reload();
                  },
                  icon: const Icon(Icons.refresh_rounded))
            ],
          ),
          body: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: WebViewWidget(
                  controller: webViewController,
                ),
              ),
              if (loadingPercentage.value < 100)
                ValueListenableBuilder(
                  valueListenable: loadingPercentage,
                  builder: (_,percentage,child) {
                    return Center(
                      child: CircularProgressIndicator(
                        // The circular progress indicator is used to display the circular progress in the center of the screen with the value of the loading of page progress .
                        value: percentage / 100.0,
                      ),
                    );
                  }
                ),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     await webViewController.loadRequest(
          //         Uri.parse('https://github.com/AbubakarSaddiqueKhan'));
          //   },
          //   child: const Icon(Icons.golf_course),
          // ),
        ) );
  }
}
