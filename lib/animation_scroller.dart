library animation_scroller;

import 'package:flutter/widgets.dart';

class AnimationScroller extends ScrollController {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  int? _durationValue;
  bool? initFlg;
  bool? animationFlg;
  double? scrollOffset;
  double? _animationValue;

  /// Notify logic of scroll status.
  scrollState(ScrollNotification scrollNotification, double maxScrollExtent,
      double containerValue) {
    ///　Check the status of scrollNotification.
    if (scrollNotification is ScrollStartNotification) {
    } else if (scrollNotification is ScrollUpdateNotification) {
    } else if (scrollNotification is ScrollEndNotification) {
      /// Notify logic of scroll status. beta dart 2.17.0 logic
      // bool aFlg = (animationFlg ?? false);

      /// Judgment by scroll amount.
      // _maxScrollExtent = maxScrollExtent;
      // if (_maxScrollExtent == containerValue && aFlg) {
      //   animationFlg = false;
      //   initFlg = false;
      //   _animationLogic(containerValue);
      // }
    }
  }

  /// Initialization of each value.
  reset() {
    initFlg = false;
    scrollOffset = 0.0;
    _animationValue = 0.0;
    jumpTo(0.0);
    animationFlg = false;
  }

  /// Bind with a widget.
  widgetBuild(double containerValue, int duration) {
    bool iFlg = (initFlg ?? false);
    bool aFlg = (animationFlg ?? false);
    _durationValue = duration;
    double offset = (scrollOffset ?? 0.0);

    /// Scroll judgment.
    if (aFlg) {
      /// Substitute scroll amount.
      scrollOffset = (scrollOffset ?? 0.0) <= position.maxScrollExtent
          ? position.maxScrollExtent
          : (scrollOffset ?? 0.0);

      /// Judging a certain animation
      if (offset > containerValue && iFlg) {
        iFlg = false;
        _animationLogic(containerValue);
      }
    }
  }

  /// Speed set and flg check.
  speedCheck() {
    animationFlg = true;
  }

  /// Scroll animation.
  _animationLogic(double containerValue) {
    Future(() {
      double offsetValue = (scrollOffset ?? 0.0);
      int duration = (_durationValue ?? 0);

      /// Judgment by scroll amount.
      if (offsetValue >= containerValue) {
        /// Substitute the amount of animation.
        _animationValue = offsetValue - containerValue;
        double aValue = (_animationValue ?? 0.0);
        animateTo(aValue,
            duration: Duration(milliseconds: duration), curve: Curves.linear);
      }
    });
  }
}
