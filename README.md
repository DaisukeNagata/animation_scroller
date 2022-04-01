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

# Pub.dev Version

[![Pub Version](https://img.shields.io/pub/v/animation_scroller?color=emerald)](https://pub.dev/packages/animation_scroller/versions/0.2.5)


## Movie





https://user-images.githubusercontent.com/16457165/160855117-c595945b-507e-44ae-97ba-cf287d229a84.mov




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
// zero Scrolls to the bottom part.　 It is the place of zero
_scrollController.widgetBuild(context, 0, _scrollController.duration);
     
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

    _focusNode.addListener(() {
      scrollLogic(_focusNode);
    });

    _focusNode2.addListener(() {
      scrollLogic(_focusNode2);
    });

    _scrollController.duration = 100;
  }

  scrollLogic(FocusNode node) {
    double value = (_widgetKey.currentContext?.size?.height ?? 0.0);
    RenderBox box = _widgetKeyBottom.currentContext?.findRenderObject() as RenderBox;
    double offsetFlg = MediaQuery.of(context).size.height - (_scrollController.keyboardHeight ?? 0.0) - value;
    _scrollController.focusLogic(node, value, box, offsetFlg, (_scrollController.duration ?? 0));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _scrollController.widgetBuild(context, _containerValue, (_scrollController.duration ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          _scrollController.reset();
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            _scrollController.scrollState(scrollNotification, _scrollController.position.maxScrollExtent, _containerValue);
            return true;
          },
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
                          _scrollController.scrollOffset = 0;
                        });
                      },
                      onChanged: (double value) {
                        setState(() {
                          _containerValue = value;
                        });
                      },
                    ),
                  ],
                ),
                setTextFiled(_widgetKey, _focusNode),
                const Padding(padding: EdgeInsets.only(top: 20)),
                setTextFiled(_widgetKeyBottom, _focusNode2),
                Container(
                  color: Colors.black,
                  width: _containerValue,
                  height: _containerValue,
                )
              ],
            ),
          ),
        ), // This
      ), // trailing comma makes auto-formatting nicer for build methods.
    );
  }

  TextField setTextFiled(key, focusNode) {
    return TextField(
      keyboardType: TextInputType.datetime,
      key: key,
      focusNode: focusNode,
      onSubmitted: (value) => _scrollController.scrollReturn(200),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'start',
      ),
    );
  }
}
```

## Getting started

* In the example, tapping textfiled scrolls to the specified position.
