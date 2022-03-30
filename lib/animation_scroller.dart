library animation_scroller;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationScroller extends ScrollController{
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  int duration = 0;
  double keyboardHeight = 0.0;
  double _offsetDy = 0.0;
  double _scrollOffset = 0.0;
  double _animationValue = 0.0;
  double _containerValue = 0.0;
  bool animationFlg = true;

  scrollState(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollStartNotification) {

    } else if (scrollNotification is ScrollUpdateNotification) {

    } else if (scrollNotification is ScrollEndNotification) {
      _scrollOffset = position.maxScrollExtent;
      if (_scrollOffset != 0 && _scrollOffset > _containerValue && animationFlg) {
        animationLogic(duration);
      }
      if (position.maxScrollExtent - offset == _containerValue) {
        animationFlg = false;
      }
    }
  }

  reset() {
    _scrollOffset = 0;
    jumpTo(0.0);
    animationFlg = false;
  }

  scrollReturn(int value) {
    animateTo(_animationValue,
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
      _scrollOffset = _scrollOffset <= position.maxScrollExtent ?
      position.maxScrollExtent : _scrollOffset;

      if (_scrollOffset != 0 && _scrollOffset > _containerValue && animationFlg) {
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
      if (_scrollOffset != 0 && _scrollOffset > _containerValue && animationFlg) {
        _animationValue = _scrollOffset - _containerValue;
        animateTo(_animationValue, duration: Duration(milliseconds: duration), curve: Curves.linear);
      }
    });
  }
}
