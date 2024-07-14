import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/features/auth/presentation/widget/costom_text_form_field.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CompleteRegistrationView extends StatelessWidget {
  const CompleteRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              Container(
                alignment: Alignment.center,
                width: 115.w,
                height: 115.h,
                decoration: BoxDecoration(
                  color: Colors.white, // لون الخلفية
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // لون الظل
                      spreadRadius: 1, // توزيع الظل
                      blurRadius: 5, // انتشار الظل
                      offset: const Offset(0, 1), // تحديد موقع الظل
                    ),
                  ],
                  borderRadius: BorderRadius.circular(60.r), // حواف مستديرة
                ),
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundImage: const AssetImage('assets/images/hamdy.jpg'),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 15,
                child: Container(
                  alignment: Alignment.center,
                  width: 30.w,
                  height: 30.h,
                  child: IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                        backgroundColor: AppColors.whiteColor),
                    icon: Icon(
                      size: 15,
                      Icons.camera_alt_rounded,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              ),
            ]),

            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on),
                ),
                Text(
                  'Hamdy Fathy',
                  style: getTitleStyle(context, fontWeight: FontWeight.bold),
                ),
                Gap(50.h),
              ],
            ),
            Gap(20.h),

            //Phone
            CustomTextFormField(
              prefixIcon: Icons.phone,
              hintText: S.of(context).phone_number1,
            ),
            Gap(20.h),
            //Phone2
            CustomTextFormField(
              prefixIcon: Icons.phone,
              hintText: S.of(context).phone_number2,
            ),
            Gap(20.h),
            CustomButton(
              text: S.of(context).complete_registration,
              color: AppColors.whiteColor,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
