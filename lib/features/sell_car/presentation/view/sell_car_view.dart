import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/core/widget/custom_chac_box.dart';
import 'package:car_store/features/auth/presentation/widget/costom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SellCarView extends StatefulWidget {
  const SellCarView({super.key});

  @override
  State<SellCarView> createState() => _SellCarViewState();
}

class _SellCarViewState extends State<SellCarView> {
  String? _selectedOption = 'new';
  bool? _alarm = false;
  bool? _cruiseControl = false;
  bool? _bluetooth = false;
  bool? _frontParkingSensor = false;
  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedOption = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: getTitleStyle(context,
                    fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              CustomTextFormField(hintText: 'Enter title'),
              Gap(20.h),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    'Condition',
                    style: getTitleStyle(context,
                        fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  Text(
                    'Year',
                    style: getTitleStyle(context,
                        fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(
                    flex: 8,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: 'new',
                                groupValue: _selectedOption,
                                onChanged: _handleRadioValueChange),
                            Text(
                              'New',
                              style: getBodyStyle(context,
                                  fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 'used',
                                groupValue: _selectedOption,
                                onChanged: _handleRadioValueChange),
                            Text(
                              'Used',
                              style: getBodyStyle(context,
                                  fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      keyboardType: TextInputType.number,
                      hintText: 'Model',
                    ),
                  ),
                ],
              ),
              Gap(20.h),
              Row(
                children: [
                  Text(
                    'Brand',
                    style: getBodyStyle(context,
                        fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Gap(10.h),
                  Text(
                    'Model',
                    style: getBodyStyle(context,
                        fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  const Spacer()
                ],
              ),
              Row(children: [
                Expanded(
                  child: CustomTextFormField(
                    hintText: 'Select Brand',
                  ),
                ),
                Gap(10.h),
                Expanded(
                  child: CustomTextFormField(
                    hintText: 'Select Model',
                  ),
                ),
              ]),
              Gap(20.h),
              Text(
                'Features',
                style: getTitleStyle(context,
                    fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              CustomTextFormField(hintText: 'Search'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomChacBox(
                    text: 'Alarm',
                    value: _alarm,
                    onChanged: (value) {
                      setState(() {
                        _alarm = value;
                      });
                    },
                  ),
                  const Spacer(),
                  CustomChacBox(
                    text: 'Cruise Control',
                    value: _cruiseControl,
                    onChanged: (value) {
                      setState(() {
                        _cruiseControl = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomChacBox(
                    text: 'Bluetooth',
                    value: _bluetooth,
                    onChanged: (value) {
                      setState(() {
                        _bluetooth = value;
                      });
                    },
                  ),
                  const Spacer(),
                  CustomChacBox(
                    text: 'Front Parking Sensor',
                    value: _frontParkingSensor,
                    onChanged: (value) {
                      setState(() {
                        _frontParkingSensor = value;
                      });
                    },
                  ),
                ],
              ),
              Gap(20.h),
              Row(
                children: [
                  Text(
                    'Location',
                    style: getBodyStyle(context,
                        fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Gap(10.h),
                  Text(
                    'Price',
                    style: getBodyStyle(context,
                        fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  const Spacer()
                ],
              ),
              Row(children: [
                Expanded(
                  child: CustomTextFormField(
                      hintText: 'Search Location', hintFontSize: 12.sp),
                ),
                Gap(10.h),
                Expanded(
                  child: CustomTextFormField(
                      hintText: 'Enter Price', hintFontSize: 12.sp),
                ),
              ]),
              Gap(20.h),
              Text(
                'Description',
                style: getTitleStyle(context,
                    fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Container(
                decoration: decoration,
                child: TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Write description about your car',
                  ),
                ),
              ),
              Gap(20.h),
              GestureDetector(
                onTap: () {},
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.camera_alt_outlined),
                    Text(
                      'Upload images/Video',
                      style: getBodyStyle(context,
                          fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
              ),
              Gap(20.h),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  text: 'Sell Your Car',
                  color: AppColors.whiteColor,
                  onTap: () {},
                ),
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
