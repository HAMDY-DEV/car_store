import 'package:car_store/core/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showLoading({required context}) {
  /* showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: SizedBox(
          height: 250,
          width: 250,
          child: RiveAnimation.asset(
            'assets/riv/loading_book.riv',
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );
}*/
}
showError({required context, required textError}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
      content: Text(textError)));
}

showSnackBar({required context, required textError}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: AppColors.primaryColor,
      content: Text(textError)));
}

showCustomDialog({required context, required child, actions, title}) {
  showDialog(
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
/*
showRiveDialog({required context, required String path}) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: SizedBox(
          height: 250,
          width: 250,
          child: RiveAnimation.asset(
            path,
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );*/