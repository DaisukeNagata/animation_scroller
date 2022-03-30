library animation_scroller;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationScroller extends ScrollController{
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  double scrollOffset = 0.0;
  double animationValue = 0.0;
  double animationCount = 0.0;
  double keyboardHeight = 0.0;
  double _offsetDy = 0.0;
  double _containerValue = 0.0;
  bool animationFlg = true;

  onStartScroll(ScrollMetrics metrics) {
  }

  onUpdateScroll(ScrollMetrics metrics) {
  }

  onEndScroll(ScrollMetrics metrics) {
    if (scrollOffset != 0 && scrollOffset > _containerValue && animationFlg) {
      animationLogic(50);
    }
  }

  reset() {
    animationCount = 0;
    animationValue = 0;
    scrollOffset = 0;
    jumpTo(0.0);
    animationFlg = true;
  }

  scrollReturn(int value) {
    animationValue = 0;
    animateTo(animationValue,
        duration: Duration(milliseconds: value),
        curve: Curves.linear);
  }

  widgetBuild(BuildContext context, double containerValue) {
    _containerValue = containerValue;
    if (MediaQuery.of(context).viewInsets.bottom != 0 && animationFlg) {
      keyboardHeight = keyboardHeight <= MediaQuery.of(context).viewInsets.bottom ?
      MediaQuery.of(context).viewInsets.bottom :
      keyboardHeight;
    }

    if (MediaQuery.of(context).viewInsets.bottom != 0 && hasClients && animationFlg) {
      scrollOffset = scrollOffset <= position.maxScrollExtent ?
      position.maxScrollExtent : scrollOffset;

      if (scrollOffset != 0 && scrollOffset > _containerValue && animationFlg) {
        notifyListeners();
      }
    }
  }

  focusLogic(FocusNode focusNode, double value, RenderBox box, double offsetFlg) {
    switch (focusNode.hasFocus) {
      case true:
        _offsetDy = box.localToGlobal(Offset.zero).dy;
        animationFlg = true;
        _offsetDy > offsetFlg ? Future(() {notifyListeners();}) : null;
        break;
    }
  }

  listener(int duration) {
    addListener(() {
      if (scrollOffset != 0 && scrollOffset > _containerValue && animationFlg) {
        animationLogic(duration);
      }
    });
  }

  animationLogic(int duration) {
    Future(() {
      if (animationFlg) {
        animationValue = scrollOffset - _containerValue;
        animateTo(animationValue, duration: Duration(milliseconds: duration), curve: Curves.linear);
      }
    });
  }
}
