library particles_flutter;

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_wallet/ui/util/particles/painter.dart';

class CircularParticle extends StatefulWidget {
  const CircularParticle({
    Key? key,
    this.height,
    this.width,
    this.onTapAnimation = true,
    this.numberOfParticles = 500,
    this.speedOfParticles = 2,
    this.awayRadius = 100,
    this.isRandomColor,
    this.particleColor = Colors.white,
    this.awayAnimationDuration = const Duration(milliseconds: 600),
    this.maxParticleSize = 4,
    this.isRandSize = false,
    this.randColorList = const <Color>[
      Colors.black,
      Colors.blue,
      Colors.white,
      Colors.red,
      Colors.green,
    ],
    this.awayAnimationCurve = Curves.easeIn,
    this.enableHover = false,
    this.hoverColor = Colors.orangeAccent,
    this.hoverRadius = 80,
    this.connectDots = false,
  }) : super(key: key);
  final double? awayRadius;
  final double? height;
  final double? width;
  final bool? onTapAnimation;
  final double? numberOfParticles;
  final double? speedOfParticles;
  final bool? isRandomColor;
  final Color? particleColor;
  final Duration? awayAnimationDuration;
  final Curve? awayAnimationCurve;
  final double? maxParticleSize;
  final bool? isRandSize;
  final List<Color>? randColorList;
  final bool? enableHover;
  final Color? hoverColor;
  final double? hoverRadius;
  final bool? connectDots; //not recommended

  @override
  _CircularParticleState createState() => _CircularParticleState();
}

class _CircularParticleState extends State<CircularParticle>
    with TickerProviderStateMixin {
  _CircularParticleState();

  Animation<double>? animation;
  AnimationController? controller;
  List<Offset> offsets = <Offset>[];
  List<bool> randDirection = <bool>[];
  double speedOfparticle = 0;
  Random rng = Random();
  double randValue = 0;
  double? dx;
  double? dy;
  List<double> randomDouble = <double>[];
  AnimationController? awayAnimationController;

  List<double> randomSize = <double>[];
  List<int> hoverIndex = <int>[];
  List<List> lineOffset = <List>[];

  void initailizeOffsets(_) {
    for (int index = 0; index < widget.numberOfParticles!; index++) {
      offsets.add(Offset(
          rng.nextDouble() * widget.width!, rng.nextDouble() * widget.height!));
      randomDouble.add(rng.nextDouble());
      randDirection.add(rng.nextBool());
      randomSize.add(rng.nextDouble());
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(initailizeOffsets);
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller!)
      ..addListener(() {
        setState(() {
          speedOfparticle = widget.speedOfParticles!;
          for (int index = 0; index < offsets.length; index++) {
            if (randDirection[index]) {
              randValue = -speedOfparticle;
            } else {
              randValue = speedOfparticle;
            }
            dx = offsets[index].dx + (randValue * randomDouble[index]);
            dy = offsets[index].dy + randomDouble[index] * speedOfparticle;
            if (dx! > widget.width!) {
              dx = dx! - widget.width!;
            } else if (dx! < 0) {
              dx = dx! + widget.width!;
            }
            if (dy! > widget.height!) {
              dy = dy! - widget.height!;
            } else if (dy! < 0) {
              dy = dy! + widget.height!;
            }
            offsets[index] = Offset(dx!, dy!);
          }
          if (widget.connectDots!) {
            connectLines(); //not recommended
          }
        });
      });
    controller!.repeat();
    changeDirection();
    super.initState();
  }

  @override
  void dispose() {
    awayAnimationController?.dispose();
    controller?.dispose();
    super.dispose();
  }

  Future<void> changeDirection() async {
    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(milliseconds: 600));

      for (int index = 0; index < widget.numberOfParticles!; index++) {
        randDirection[index] = rng.nextBool();
      }
      return true;
    });
  }

  void connectLines() {
    lineOffset = [];
    double distanceBetween = 0;
    for (int point1 = 0; point1 < offsets.length; point1++) {
      for (int point2 = 0; point2 < offsets.length; point2++) {
        //    if(offsets)
        distanceBetween = sqrt(pow(offsets[point2].dx - offsets[point1].dx, 2) +
            pow(offsets[point2].dy - offsets[point1].dy, 2));
        if (distanceBetween < 50) {
          lineOffset.add([offsets[point1], offsets[point2], distanceBetween]);
        }
      }
    }
  }

  void onTapGesture(double tapdx, double tapdy) {
    awayAnimationController = AnimationController(
        duration: widget.awayAnimationDuration, vsync: this);
    awayAnimationController!.reset();
    double directiondx;
    double directiondy;
    final List<double> distance = <double>[];
    double noAnimationDistance = 0;

    if (widget.onTapAnimation!) {
      final List<Animation<Offset>> awayAnimation = [];
      awayAnimationController!.forward();
      for (int index = 0; index < offsets.length; index++) {
        distance.add(sqrt(
            ((tapdx - offsets[index].dx) * (tapdx - offsets[index].dx)) +
                ((tapdy - offsets[index].dy) * (tapdy - offsets[index].dy))));
        directiondx = (tapdx - offsets[index].dx) / distance[index];
        directiondy = (tapdy - offsets[index].dy) / distance[index];
        final Offset begin = offsets[index];
        awayAnimation.add(Tween<Offset>(
                begin: begin,
                end: Offset(
                  offsets[index].dx -
                      (widget.awayRadius! - distance[index]) * directiondx,
                  offsets[index].dy -
                      (widget.awayRadius! - distance[index]) * directiondy,
                ))
            .animate(CurvedAnimation(
                parent: awayAnimationController!,
                curve: widget.awayAnimationCurve!))
          ..addListener(() {
            if (distance[index] < widget.awayRadius!)
              setState(() {
                offsets[index] = awayAnimation[index].value;
              });
            if (awayAnimationController!.isCompleted &&
                index == offsets.length - 1) {
              awayAnimationController!.dispose();
            }
          }));
      }
    } else {
      for (int index = 0; index < offsets.length; index++) {
        noAnimationDistance = sqrt(
            ((tapdx - offsets[index].dx) * (tapdx - offsets[index].dx)) +
                ((tapdy - offsets[index].dy) * (tapdy - offsets[index].dy)));
        directiondx = (tapdx - offsets[index].dx) / noAnimationDistance;
        directiondy = (tapdy - offsets[index].dy) / noAnimationDistance;
        if (noAnimationDistance < widget.awayRadius!) {
          setState(() {
            offsets[index] = Offset(
              offsets[index].dx -
                  (widget.awayRadius! - noAnimationDistance) * directiondx,
              offsets[index].dy -
                  (widget.awayRadius! - noAnimationDistance) * directiondy,
            );
          });
        }
      }
    }
  }

  void onHover(double tapdx, double tapdy) {
    {
      awayAnimationController = AnimationController(
          duration: widget.awayAnimationDuration, vsync: this);
      awayAnimationController!.reset();

      double noAnimationDistance = 0;
      for (int index = 0; index < offsets.length; index++) {
        noAnimationDistance = sqrt(
            ((tapdx - offsets[index].dx) * (tapdx - offsets[index].dx)) +
                ((tapdy - offsets[index].dy) * (tapdy - offsets[index].dy)));

        if (noAnimationDistance < widget.hoverRadius!) {
          setState(() {
            if (hoverIndex.length >
                (widget.numberOfParticles! * 0.1).floor() + 1) {
              hoverIndex.removeAt(0);
            }
            hoverIndex.add(index);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final RenderBox getBox = context.findRenderObject() as RenderBox;
        onTapGesture(getBox.globalToLocal(details.globalPosition).dx,
            getBox.globalToLocal(details.globalPosition).dy);
      },
      onPanUpdate: (DragUpdateDetails details) {
        if (widget.enableHover!) {
          final RenderBox getBox = context.findRenderObject() as RenderBox;
          onHover(getBox.globalToLocal(details.globalPosition).dx,
              getBox.globalToLocal(details.globalPosition).dy);
        }
      },
      onPanEnd: (DragEndDetails details) {
        hoverIndex = [];
      },
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: CustomPaint(
          painter: ParticlePainter(
              offsets: offsets,
              isRandomColor: widget.isRandomColor!,
              particleColor: widget.particleColor!,
              maxParticleSize: widget.maxParticleSize!,
              randSize: randomSize,
              isRandSize: widget.isRandSize!,
              randColorList: widget.randColorList!,
              hoverIndex: hoverIndex,
              enableHover: widget.enableHover!,
              hoverColor: widget.hoverColor!,
              lineOffsets: lineOffset),
        ),
      ),
    );
  }
}
