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
  Widget build(BuildContext context) {
    /// Bind with a widget.
    _scrollController.widgetBuild(_containerValue, 1);
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
                    onChangeEnd: (value) {
                      /// Initialize scroll value
                      _scrollController.reset();
                      _containerValue = value;
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
                  _scrollController.speedCheck();
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
                  _scrollController.speedCheck();
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
