
import 'package:flutter/material.dart';
import 'dart:math' as math;

typedef FinishCallback = void Function(int index);
typedef TargetChangeCallback = void Function(int index);
typedef CreatedCallback = void Function(AnimationController controller);

class RouletteWidget extends StatefulWidget {
  const RouletteWidget({
    Key? key,
    required this.contents,
    this.radius,
    this.curve = Curves.easeOutQuart,
    this.hand,
    this.onCreated,
    this.onValueChanged,
    this.onFinish
  }) : super(key: key);

  final List<RouletteContent> contents;

  /// default value is size.width/2
  final double? radius;

  final Curve curve;

  final Widget? hand;

  /// it is called after RouletteWidget is created
  final CreatedCallback? onCreated;

  /// it is called when target value is changed
  final FinishCallback? onValueChanged;

  /// it is called when rotation finishes
  final FinishCallback? onFinish;

  @override
  _RouletteWidgetState createState() => _RouletteWidgetState();
}

class _RouletteWidgetState extends State<RouletteWidget> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<double> _animation;

  Offset _center = const Offset(0, 0);
  double _angle = 0;
  double _volumeOfWeights = 0;
  final double _acceleration = 10;

  late double _nextDegree;

  late Offset _end;
  double _velocity = 0;
  double _direction = 1;

  int _i = 1;
  int _j = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_setCenter);
    _setVolume();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5),);
    _animation = CurvedAnimation(parent: _animationController, curve: widget.curve,);
    _animation.addListener(() {
      setState(() {
        _angle = _animation.value * _velocity * _acceleration;
      });
      if(_angle.abs() > _nextDegree.abs()){
        _j = _direction == 1
            ? _i % widget.contents.length
            : (widget.contents.length - 1) - (_i % widget.contents.length);

        if(widget.onValueChanged != null) widget.onValueChanged!(_j);
        _i++;
        _nextDegree += widget.contents[_j].weight / _volumeOfWeights * 360 * _direction;
      }
    });
    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        if(widget.onFinish != null) widget.onFinish!(_j);
      }
    });
    if(widget.onCreated != null) widget.onCreated!(_animationController);
  }

  void _setVolume(){
    for(int i=0; i<widget.contents.length; i++){
      _volumeOfWeights += widget.contents[i].weight;
    }
  }

  void _setCenter(_){
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    setState(() {
      _center = Offset(renderBox.size.width/2, renderBox.size.height/2);
    });
  }

  void _onDragDown(DragDownDetails dragDownDetails){
    if(_animationController.isAnimating == true) return;
    _end = _center;
    _i=1;
    _j=0;
    _velocity = 0;
  }

  _onVerticalDragEnd(DragEndDetails dragEndDetails){
    if(_animationController.isAnimating == true) return;
    if(_end.dx < _center.dx){
      _velocity *= -1;
    }
    _onDragEnd();
  }

  _onHorizontalDragEnd(DragEndDetails dragEndDetails){
    if(_animationController.isAnimating == true) return;
    if(_end.dy >= _center.dy){
      _velocity *= -1;
    }
    _onDragEnd();
  }

  void _onDragEnd(){
    if(_velocity >= 0){
      _direction = 1;
      _nextDegree = widget.contents[0].weight/_volumeOfWeights * 360 * _direction;
    } else{
      _direction = -1;
      _nextDegree = widget.contents[widget.contents.length-1].weight/_volumeOfWeights * 360 * _direction;
    }
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: _onDragDown,
      onVerticalDragEnd: _onVerticalDragEnd,
      onVerticalDragUpdate: (verticalDragUpdate){
        if(_animationController.isAnimating == true) return;
        _end = verticalDragUpdate.localPosition;
        _velocity += verticalDragUpdate.delta.dy;
      },
      onHorizontalDragDown: _onDragDown,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      onHorizontalDragUpdate: (horizontalDragUpdate){
        if(_animationController.isAnimating == true) return;
        _end = horizontalDragUpdate.localPosition;
        _velocity += horizontalDragUpdate.delta.dx;
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned.fill(
            child: Transform.rotate(
              angle: degreeToRadian(_angle),
              child: RouletteBoard(
                contents: widget.contents,
                volume: _volumeOfWeights,
                radius: widget.radius,
              ),
            ),
          ),
          Hand(
            y: _center.dy,
            child: widget.hand ?? const SizedBox(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class RouletteBoard extends StatelessWidget {
  const RouletteBoard({
    Key? key,
    required this.contents,
    required this.volume,
    required this.radius
  }) : super(key: key);

  final List<RouletteContent> contents;
  final double volume;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RoulettePainter(contents: contents, volume: volume, radius: radius),
    );
  }
}


class RoulettePainter extends CustomPainter{
  RoulettePainter({
    required this.contents,
    required this.volume,
    this.radius,
  });

  final List<RouletteContent> contents;
  final double volume;
  double? radius;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style=PaintingStyle.fill;
    double degree = 0;
    radius ??= size.width/2;
    final Offset origin = Offset(size.width/2, size.height/2);

    for(int i=0; i<contents.length; i++){
      final Offset point = Offset(
          origin.dx + radius! * math.cos(degreeToRadian(degree)),
          origin.dy - radius! * math.sin(degreeToRadian(degree))
      );
      double next = contents[i].weight / volume * 360;

      Path path = Path()..moveTo(origin.dx, origin.dy);
      path.lineTo(point.dx, point.dy);
      path.addArc(Rect.fromCircle(center: origin, radius: radius!), degreeToRadian(-degree), degreeToRadian(-next));
      path.lineTo(origin.dx, origin.dy);
      paint.color = contents[i].piColor;
      canvas.drawPath(path, paint);

      if(contents[i].label != null){
        final double degreeForText = degree + next/2;
        final Offset offset = Offset(
            origin.dx + radius!/2 * math.cos(degreeToRadian(degreeForText)),
            origin.dy - radius!/2 * math.sin(degreeToRadian(degreeForText))
        );
        _drawText(canvas, contents[i].label!, offset, degreeForText, contents[i]);
      }

      degree += next;
    }
  }

  _drawText(Canvas canvas, String text, Offset canvasOffset, double degree, RouletteContent content){
    final TextSpan textSpan = TextSpan(text: content.label, style: content.textStyle);
    final TextPainter textPainter = TextPainter()
      ..text = textSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();
    canvas.save();

    canvas.translate(canvasOffset.dx, canvasOffset.dy);
    canvas.rotate(degreeToRadian(-degree));
    canvas.translate(-canvasOffset.dx, -canvasOffset.dy);

    final Offset textOffset = Offset(canvasOffset.dx, canvasOffset.dy-textPainter.size.height/2);
    textPainter.paint(canvas, textOffset);

    canvas.restore();
  }

  @override
  bool shouldRepaint(RoulettePainter oldDelegate) {
    return false;
  }
}

class RouletteContent{
  RouletteContent({
    this.label,
    this.weight = 1,
    required this.piColor,
    this.textStyle
  }) : assert((label == null && textStyle != null) == false);

  final String? label;
  final double weight;
  final Color piColor;
  final TextStyle? textStyle;
}


double degreeToRadian(double degree){
  return degree * math.pi / 180;
}



class Hand extends StatefulWidget {
  const Hand({
    Key? key,
    required this.child,
    required this.y
  }) : super(key: key);

  final Widget child;
  final double y;

  @override
  _HandState createState() => _HandState();
}

class _HandState extends State<Hand> {

  Offset _offset = const Offset(0,0);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_setOffset);
  }

  void _setOffset(_){
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    setState(() {
      _offset = Offset(renderBox.size.width, renderBox.size.height);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: widget.y - _offset.dy/2,
      child: widget.child,
    );
  }
}