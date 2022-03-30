library animation_scroller;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationScroller extends ScrollController{
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  int duration = 0;
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
      animationLogic(duration);
    }
  }

  reset() {
    animationValue = 0;
    scrollOffset = 0;
    jumpTo(0.0);
    animationFlg = false;
  }

  scrollReturn(int value) {
    animationValue = 0;
    animateTo(animationValue,
        duration: Duration(milliseconds: value),
        curve: Curves.linear);
  }

  widgetBuild(BuildContext context, double containerValue, int duration) {
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
        animationLogic(duration);
      }
    }
  }

  focusLogic(FocusNode focusNode, double value, RenderBox box, double offsetFlg, int duration) {
    switch (focusNode.hasFocus) {
      case true:
        _offsetDy = box.localToGlobal(Offset.zero).dy;
        animationFlg = true;
        _offsetDy > offsetFlg ? Future(() {animationLogic(duration);}) : null;
        break;
    }
  }

  animationLogic(int duration) {
    Future(() {
      if (scrollOffset != 0 && scrollOffset > _containerValue && animationFlg) {
        animationValue = scrollOffset - _containerValue;
        animateTo(animationValue, duration: Duration(milliseconds: duration), curve: Curves.linear);
      }
    });
  }
}
