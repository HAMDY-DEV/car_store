import 'package:car_store/core/util/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageView extends StatelessWidget {
  ImageView({super.key, required this.url});

  String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        foregroundColor: AppColors.primaryColor,
      ),
      body: Image.network(
        url,
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
