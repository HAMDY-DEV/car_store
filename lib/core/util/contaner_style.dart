import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Decoration? decoration = BoxDecoration(
  color: Colors.white, // لون الخلفية
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5), // لون الظل
      spreadRadius: 1, // توزيع الظل
      blurRadius: 5, // انتشار الظل
      offset: const Offset(0, 1), // تحديد موقع الظل
    ),
  ],
  borderRadius: BorderRadius.circular(10.r), // حواف مستديرة
);
