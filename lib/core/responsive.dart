import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  final MediaQueryData mq;
  Responsive(this.context) : mq = MediaQuery.of(context);

  double wp(double percent) => mq.size.width * percent / 100;
  double hp(double percent) => mq.size.height * percent / 100;
}
