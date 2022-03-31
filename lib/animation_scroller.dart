library animation_scroller;

import 'package:flutter/widgets.dart';

class AnimationScroller extends ScrollController {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  bool? animationFlg;
  int? duration;
  double? scrollOffset;
  double? keyboardHeight;
  double? _animationValue;
  double? _containerValue;

  scrollState(ScrollNotification scrollNotification, double maxScrollExtent,
      double containerValue) {
    //　Check the status of scrollNotification.
    if (scrollNotification is ScrollStartNotification) {
    } else if (scrollNotification is ScrollUpdateNotification) {
    } else if (scrollNotification is ScrollEndNotification) {
      scrollOffset = position.maxScrollExtent;
      int dValue = (duration ?? 0);

      // Judgment by scroll amount
      if (maxScrollExtent == containerValue) {
        animationFlg = false;
        _animationLogic(dValue);
      }
    }
  }

  reset() {
    scrollOffset = 0;
    jumpTo(0.0);
    animationFlg = false;
  }

  scrollReturn(int value) {
    double aValue = (_animationValue ?? 0.0);

    animateTo(aValue,
        duration: Duration(milliseconds: value), curve: Curves.linear);
  }

  widgetBuild(BuildContext context, double containerValue, int duration) {
    bool aFlg = (animationFlg ?? false);
    double kValue = (keyboardHeight ?? 0.0);
    double cValue = (_containerValue ?? 0.0);
    double offsetValue = (scrollOffset ?? 0.0);

    _containerValue = containerValue;

    // Scroll judgment
    if (aFlg) {
      kValue = kValue <= MediaQuery.of(context).viewInsets.bottom
          ? MediaQuery.of(context).viewInsets.bottom
          : kValue;

      scrollOffset = (scrollOffset ?? 0.0) <= position.maxScrollExtent
          ? position.maxScrollExtent
          : (scrollOffset ?? 0.0);

      bool aFlg = (animationFlg ?? false);

      // Judgment by scroll amount
      if (offsetValue != 0 && offsetValue > cValue && aFlg) {
        Future(() {
          _animationLogic(duration);
        });
      }
    }
  }

  focusLogic(FocusNode focusNode, double value, RenderBox box,
      double offsetValue, int duration) {
    switch (focusNode.hasFocus) {
      case true:
        animationFlg = true;
        break;
    }
  }

  _animationLogic(int duration) {
    Future(() {
      double offsetValue = (scrollOffset ?? 0.0);
      double cValue = (_containerValue ?? 0.0);

      _animationValue = offsetValue - cValue;
      double aValue = (_animationValue ?? 0.0);

      animateTo(aValue,
          duration: Duration(milliseconds: duration), curve: Curves.linear);
    });
  }
}
