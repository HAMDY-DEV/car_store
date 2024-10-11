import 'package:car_store/core/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showError({required context, required textError}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
      content: Text(textError)));
}

showSnackBar({required context, required text}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: AppColors.primaryColor,
      content: Text(text)));
}

showCustomDialog({required context, required child, actions, title}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title ?? const SizedBox(),
        content: child,
        actions: actions ?? [],
      );
    },
  );
}

showLottieDialog({required context, required String lottieAsset}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: SizedBox(
          height: 250,
          width: 250,
          child: Lottie.asset(lottieAsset),
        ),
      );
    },
  );
}
