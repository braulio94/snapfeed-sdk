import 'package:flutter/widgets.dart';

class AnimatedContent extends StatelessWidget {
  const AnimatedContent({
    Key key,
    this.child,
    @required this.vsync,
    this.fadeDuration = const Duration(milliseconds: 350),
    this.sizeDuration = const Duration(milliseconds: 350),
    this.fadeCurve = Curves.fastOutSlowIn,
    this.sizeCurve = Curves.fastOutSlowIn,
    this.alignment = Alignment.topCenter,
  }) : super(key: key);

  final Widget child;
  final TickerProvider vsync;
  final Duration fadeDuration;
  final Duration sizeDuration;
  final Curve fadeCurve;
  final Curve sizeCurve;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: vsync,
      alignment: alignment,
      duration: sizeDuration,
      curve: sizeCurve,
      child: SizedBox(
        width: double.infinity,
        child: AnimatedSwitcher(
          duration: fadeDuration,
          switchInCurve: fadeCurve,
          switchOutCurve: fadeCurve.flipped,
          layoutBuilder: _layoutBuilder,
          child: child,
        ),
      ),
    );
  }

  Widget _layoutBuilder(Widget currentChild, List<Widget> previousChildren) {
    return Stack(
      overflow: Overflow.visible,
      alignment: alignment,
      children: <Widget>[
        ...previousChildren,
        if (currentChild != null) currentChild,
      ],
    );
  }
}
