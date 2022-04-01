library animation_scroller;

import 'package:flutter/widgets.dart';

class AnimationScroller extends ScrollController {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  bool? initflg;
  bool? animationFlg;
  int? durationValue;
  double? scrollOffset;
  double? keyboardHeight;
  double? _animationValue;
  double? _containerValue;
  double? _maxScrollExtent;

  // Notify logic of scroll status.
  scrollState(ScrollNotification scrollNotification, double maxScrollExtent,
      double containerValue) {
    //　Check the status of scrollNotification.
    if (scrollNotification is ScrollStartNotification) {
    } else if (scrollNotification is ScrollUpdateNotification) {
    } else if (scrollNotification is ScrollEndNotification) {
      scrollOffset = position.maxScrollExtent;
      bool aFlg = (animationFlg ?? false);

      /// Judgment by scroll amount.
      _maxScrollExtent = maxScrollExtent;
      if (_maxScrollExtent == containerValue && aFlg) {
        animationFlg = false;
      }
    }
  }

  // Initialization of each value.
  reset() {
    initflg = true;
    durationValue = 0;
    scrollOffset = 0.0;
    keyboardHeight = 0.0;
    _animationValue = 0.0;
    _containerValue = 0.0;
    _maxScrollExtent = 0.0;
    jumpTo(0.0);
    animationFlg = false;
  }

  // Bind with a widget.
  widgetBuild(BuildContext context, double containerValue, int duration) {
    bool iflg = (initflg ?? false);
    bool aFlg = (animationFlg ?? false);
    double kValue = (keyboardHeight ?? 0.0);
    double cValue = (_containerValue ?? 0.0);
    double offsetValue = (scrollOffset ?? 0.0);

    // Scroll judgment.
    if (aFlg) {

      /// Substitute keyboard height.
      kValue = kValue <= MediaQuery.of(context).viewInsets.bottom
          ? MediaQuery.of(context).viewInsets.bottom
          : kValue;

      /// Substitute scroll amount.
      scrollOffset = (scrollOffset ?? 0.0) <= position.maxScrollExtent
          ? position.maxScrollExtent
          : (scrollOffset ?? 0.0);

      /// Scroll judgment
      if (offsetValue > cValue && iflg) {
        animationFlg = false;
        /// Scroll animation method
        _animationLogic(duration);
      } else if (!iflg) {
        /// Scroll animation method
        _animationLogic(duration);
      }

      _containerValue = containerValue;
    }
  }

  // Speed set and flg check.
  speedCheck(FocusNode focusNode, int value) {
    ///　check focusNode state.
    switch (focusNode.hasFocus) {
      case true:
        durationValue = value;
        animationFlg = true;
        break;
    }
  }

  // Scroll animation.
  _animationLogic(int duration) {
    Future(() {
      double offsetValue = (scrollOffset ?? 0.0);
      double cValue = (_containerValue ?? 0.0);

      /// Judgment by scroll amount.
      if (offsetValue > cValue) {
        /// Substitute the amount of animation.
        _animationValue = offsetValue - cValue;
        double aValue = (_animationValue ?? 0.0);
        animateTo(aValue,
            duration: Duration(milliseconds: duration), curve: Curves.linear);
      }
    });
  }
}
