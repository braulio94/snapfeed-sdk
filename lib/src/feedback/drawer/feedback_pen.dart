import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeedbackPen extends StatefulWidget {
  const FeedbackPen({
    Key key,
    @required this.color,
  })  : assert(color != null),
        super(key: key);

  final Color color;

  @override
  _FeedbackPenState createState() => _FeedbackPenState();
}

class _FeedbackPenState extends State<FeedbackPen> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _slideAnimation;

  Color _currentColor;
  Color _nextColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.color;
    _nextColor = widget.color;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _currentColor = _nextColor;
            _animationController.reverse();
          });
        }
      });

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ));
  }

  @override
  void didUpdateWidget(FeedbackPen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      _nextColor = widget.color;
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SlideTransition(
        position: _slideAnimation,
        child: IntrinsicHeight(
          child: CustomPaint(
            foregroundPainter: _PenNosePainter(_currentColor),
            child: Image.asset(
              'assets/images/pen.png',
              package: 'snapfeed',
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _PenNosePainter extends CustomPainter {
  _PenNosePainter(this._color)
      : assert(_color != null),
        _nosePaint = Paint()
          ..color = _color.withOpacity(0.8)
          ..style = PaintingStyle.fill;

  final Color _color;
  final Paint _nosePaint;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, 20), radius: 6.5),
      math.pi * 0.1,
      -math.pi * 1.2,
      false,
      _nosePaint,
    );
  }

  @override
  bool shouldRepaint(_PenNosePainter oldDelegate) => oldDelegate._color != _color;
}
