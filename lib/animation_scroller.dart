library animation_scroller;

import 'package:flutter/widgets.dart';

class AnimationScroller extends ScrollController {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  bool? animationFlg;
  int? duration;
  double? scrollOffset;
  double? keyboardHeight;
  double? _offsetDy;
  double? _animationValue;
  double? _containerValue;

  scrollState(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollStartNotification) {
    } else if (scrollNotification is ScrollUpdateNotification) {
    } else if (scrollNotification is ScrollEndNotification) {
      scrollOffset = position.maxScrollExtent;
      bool aFlg = (animationFlg ?? false);
      int dValue = (duration ?? 0);
      double cValue = (_containerValue ?? 0.0);
      double offsetValue = (scrollOffset ?? 0.0);

      if (offsetValue != 0 && offsetValue > cValue && aFlg) {
        animationLogic(dValue);
      }
      if (position.maxScrollExtent - offsetValue == cValue) {
        aFlg = false;
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

    _containerValue = containerValue;
    if (MediaQuery.of(context).viewInsets.bottom != 0 && aFlg) {
      kValue = kValue <= MediaQuery.of(context).viewInsets.bottom
          ? MediaQuery.of(context).viewInsets.bottom
          : kValue;
    }

    if (MediaQuery.of(context).viewInsets.bottom != 0 && hasClients && aFlg) {
      scrollOffset = (scrollOffset ?? 0.0) <= position.maxScrollExtent
          ? position.maxScrollExtent
          : (scrollOffset ?? 0.0);

      bool aFlg = (animationFlg ?? false);
      double cValue = (_containerValue ?? 0.0);
      double offsetValue = (scrollOffset ?? 0.0);
      if (offsetValue != 0 && offsetValue > cValue && aFlg) {
        animationLogic(duration);
      }
    }
  }

  focusLogic(FocusNode focusNode, double value, RenderBox box, double offsetFlg,
      int duration) {
    switch (focusNode.hasFocus) {
      case true:
        _offsetDy = box.localToGlobal(Offset.zero).dy;
        animationFlg = true;

        double offsetDyValue = (_offsetDy ?? 0.0);

        if (offsetDyValue > offsetFlg) {
          Future(() {
            animationLogic(duration);
          });
        }
        break;
    }
  }

  animationLogic(int duration) {
    Future(() {
      bool aFlg = (animationFlg ?? false);
      double offsetValue = (scrollOffset ?? 0.0);
      double cValue = (_containerValue ?? 0.0);

      if (offsetValue != 0 && offsetValue > cValue && aFlg) {
        _animationValue = offsetValue - cValue;
        double aValue = (_animationValue ?? 0.0);

        animateTo(aValue,
            duration: Duration(milliseconds: duration), curve: Curves.linear);
      }
    });
  }
}
