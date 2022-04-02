<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->


# Pub.dev version

[![Pub Version](https://img.shields.io/pub/v/animation_scroller?color=emerald)](https://pub.dev/packages/animation_scroller/versions/)



## Environment

```
Flutter 2.13.0-0.0.pre.301 • channel master • https://github.com/flutter/flutter.git
Framework • revision c4585ecc46 (17 hours ago) • 2022-03-29 11:02:09 -0700
Engine • revision 13414a51e7
Tools • Dart 2.17.0 (build 2.17.0-248.0.dev) • DevTools 2.11.4
```


## Example

Some devices may not support the behavior.


introduction

```
// "Value" Scrolls to the bottom part.　 It is the place of zero
_scrollController.widgetBuild(context, Value, _scrollController.duration);
     
```

All 
```
import 'package:animation_scroller/animation_scroller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'EveryDaySoft_Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ChangeNotifier {
  double _containerValue = 100.0;
  final _focusNode = FocusNode();
  final _focusNode2 = FocusNode();
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _widgetKeyBottom = GlobalKey();
  final AnimationScroller _scrollController = AnimationScroller();

  @override
  void initState() {
    super.initState();

    /// Listen to the notification
    _focusNode.addListener(() {
      /// focusNode and go to scroll speed setting
      _scrollController.speedCheck(_focusNode);
    });

    /// Listen to the notification from focusNode and go to scroll speed setting
    _focusNode2.addListener(() {
      /// focusNode and go to scroll speed setting
      _scrollController.speedCheck(_focusNode2);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Bind with a widget.
    _scrollController.widgetBuild(context, _containerValue, 100);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();

          /// Initialize scroll value
          _scrollController.reset();
        },

        /// Receive scroll notifications. beta 2.17.0 logic
        // child: NotificationListener<ScrollNotification>(
        //   onNotification: (scrollNotification) {
        //     /// Notifies the scroll status.
        //     _scrollController.scrollState(scrollNotification,
        //         _scrollController.position.maxScrollExtent, _containerValue);
        //     return true;
        //   },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.black,
                  width: _containerValue,
                  height: _containerValue,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Slider(
                      value: _containerValue,
                      min: 0,
                      max: MediaQuery.of(context).size.width,
                      divisions: 1000,
                      onChangeStart: (_) {
                        setState(() {
                          FocusScope.of(context).unfocus();
                        });
                      },
                      onChanged: (double value) {
                        setState(() {
                          /// The value of container is useful for the amount of animation.
                          _containerValue = value;
                        });
                      },
                    ),
                  ],
                ),
                TextField(
                  keyboardType: TextInputType.datetime,
                  key: _widgetKey,
                  focusNode: _focusNode,
                  onTap: () {
                    _scrollController.animationFlg = true;
                    _scrollController.initFlg = true;
                  },
                  onSubmitted: (value) => _scrollController.reset(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'start',
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                TextField(
                  keyboardType: TextInputType.datetime,
                  key: _widgetKeyBottom,
                  focusNode: _focusNode2,
                  onTap: () {
                    _scrollController.animationFlg = true;
                    _scrollController.initFlg = true;
                  },

                  /// Initialize scroll value
                  onSubmitted: (value) => _scrollController.reset(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'end',
                  ),
                ),
                Container(
                  color: Colors.black,
                  width: _containerValue,
                  height: _containerValue,
                )
            ],
          ),
        ), // This
      ), // trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

## Getting started

* In the example, tapping textfiled scrolls to the specified position.
