import 'package:flutter/material.dart';

void go(BuildContext context, className) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => className));
}
