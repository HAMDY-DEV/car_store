import 'package:flutter/material.dart';

void navigatorTo(BuildContext context, view) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) {
      return view;
    },
  ));
}

void navigatorPop(BuildContext context) {
  Navigator.of(context).pop();
}

void navigatorToReplacement(BuildContext context, view) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) {
      return view;
    },
  ));
}

void navigatorToAndRemoveUntil(BuildContext context, view) {
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
    builder: (context) {
      return view;
    },
  ), (route) => false);
}
