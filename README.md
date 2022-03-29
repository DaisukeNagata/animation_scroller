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

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

...

## Example

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

    _scrollController.addListener(() {
      _scrollController.containerValue = _containerValue;
      _scrollController.listener(50);
    });
  }

  scrollLogic(FocusNode node) {
    double value = (_widgetKey.currentContext?.size?.height ?? 0.0);
    RenderBox box = _widgetKeyBottom.currentContext?.findRenderObject() as RenderBox;
    double offsetFlg = MediaQuery.of(context).size.height - _scrollController.keyboardHeight - value;
    _scrollController.offsetDy = box.localToGlobal(Offset.zero).dy;
    _scrollController.focusLogic(node, value, box, offsetFlg);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _scrollController.widgetBuild(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () {
          _scrollController.reset();
          FocusScope.of(context).unfocus();
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
              _scrollController.onStartScroll(scrollNotification.metrics);
            } else if (scrollNotification is ScrollUpdateNotification) {
              _scrollController.onUpdateScroll(scrollNotification.metrics);
            } else if (scrollNotification is ScrollEndNotification) {
              _scrollController.onEndScroll(scrollNotification.metrics);
            }
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
                          _scrollController.animationFlg = false;
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

* Animate to the tapped UI.
* The amount of animation can be adjusted by the UI.


Please adjust the scroll amount by substituting the value for the 'containerValue' value.
