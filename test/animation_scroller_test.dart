import 'package:flutter_test/flutter_test.dart';

import 'package:animation_scroller/animation_scroller.dart';

void main() {
  test('adds one to input values', () {
    final scroller = AnimationScroller();
    expect(scroller.addOne(2), 3);
    expect(scroller.addOne(-7), -6);
    expect(scroller.addOne(0), 1);
  });
}
