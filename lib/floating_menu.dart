library floating_menu;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingMenu extends StatefulWidget {

  final FloatingType floatingType;
  final bool isMainButton;
  final Color mainButtonColor;
  final IconData mainButtonIcon;
  final BoxShape mainButtonShape;
  final BoxShape floatingButtonShape;
  final List<FloatingButtonModel> floatingButtons;

  FloatingMenu({
    this.floatingType,
    this.isMainButton,
    this.mainButtonColor,
    this.mainButtonIcon,
    this.mainButtonShape,
    this.floatingButtonShape,
    this.floatingButtons,
  });

  @override
  _FloatingMenuState createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<FloatingMenu> with SingleTickerProviderStateMixin {

  AnimationController animationController;
  Animation<double> translationAnimation;
  Animation<double> rotationAnimation;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400),);
    translationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 0.0, end: 1.05), weight: 50),
      TweenSequenceItem<double>(tween: Tween(begin: 1.05, end: 1.0), weight: 25)
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 0.0, end: 180.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    animationController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size snSize = MediaQuery.of(context).size;
    return Container(
      width: snSize.width,
      height: snSize.height,
      child: Stack(
        children: <Widget>[
          widget.isMainButton
            ? Positioned(
                right: 0,
                bottom: 0,
                child: Stack(
                  children: <Widget>[
                    for(FloatingButtonModel model in widget.floatingButtons)
                      Positioned(
                        right: 6,
                        child: Transform.translate(
                          offset: Offset.fromDirection(
                            getRadians(model.locationDegree),
                            model.locationDistance * translationAnimation.value,
                          ),
                          child: ScaleTransition(
                            scale: scaleAnimation,
                            child: ShapeButton(
                              size: model.size,
                              color: model.color,
                              shape: model.shape,
                              icon: Icon(model.icon, color: Colors.white),
                              onPress: model.onPress,
                            ),
                          ),
                        ),
                      ),
                    Transform(
                      transform: Matrix4.rotationZ(getRadians(rotationAnimation.value)),
                      alignment: Alignment.center,
                      child: ShapeButton(
                        size: Size(60, 60),
                        color: widget.mainButtonColor,
                        shape: widget.mainButtonShape,
                        icon: Icon(
                            animationController.isDismissed
                                ? widget.mainButtonIcon
                                : Icons.close, color: Colors.white),
                        onPress: () {
                          if (animationController.isCompleted) {
                            animationController.reverse();
                          } else {
                            animationController.forward();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(),
        ],
      ),
    );
  }

  double getRadians(double deg) {
    double unitRadians = 57.295779513;//1 rad = 180°/π = 57.295779513°
    return deg / unitRadians;
  }
}


enum FloatingType {
  VerticalStraight,
  HorizontalStraight,
  LeftStaircase,
  RightStaircase,
  LeftHalfCurve,
  RightHalfCurve,
  LeftCurve,
  RightCurve,
  CenterCurve,
}

class ShapeButton extends StatelessWidget {
  final Size size;
  final Color color;
  final Icon icon;
  final BoxShape shape;
  final VoidCallback onPress;

  ShapeButton({
    this.size,
    this.color,
    this.icon,
    this.shape,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: color, shape: shape),
        width: size.width,
        height: size.height,
        child: IconButton(
          icon: icon,
          enableFeedback: true,
          onPressed: onPress,
        ),
    );
  }
}

/// locationDegree: value should be between 0 to 360
/// locationDistance: how much distance from the main button(type double)
class FloatingButtonModel {
  final double locationDegree;
  final double locationDistance;
  final String label;
  final IconData icon;
  final Color color;
  final Size size;
  final VoidCallback onPress;
  final BoxShape shape;

  FloatingButtonModel({
    this.locationDegree,
    this.locationDistance,
    this.label,
    this.icon,
    this.color,
    this.size,
    this.onPress,
    this.shape,
  });
}