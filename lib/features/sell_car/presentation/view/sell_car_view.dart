import 'dart:io';
import 'package:car_store/core/function/show_error_dialogs.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/core/widget/custom_chac_box.dart';
import 'package:car_store/core/widget/show_loading_and_error.dart';
import 'package:car_store/features/auth/presentation/widget/costom_text_form_field.dart';
import 'package:car_store/features/sell_car/presentation/manager/sell_cubit.dart';
import 'package:car_store/features/sell_car/presentation/manager/sell_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class SellCarView extends StatefulWidget {
  const SellCarView({super.key});

  @override
  State<SellCarView> createState() => _SellCarViewState();
}

class _SellCarViewState extends State<SellCarView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String _selectedOption = 'new';
  bool? _alarm = false;
  bool? _cruiseControl = false;
  bool? _bluetooth = false;
  bool? _frontParkingSensor = false;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  void selectImage() async {
    final List<XFile> selectdImage = await imagePicker.pickMultiImage();
    if (selectdImage.isNotEmpty) {
      imageFileList!.addAll(selectdImage);
    }
    setState(() {});
  }

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedOption = value ?? 'new';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SellCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<SellCubit, SellState>(
          listener: (context, state) {
            if (state is SellSuccess) {
              Navigator.pop(context);
              showSnackBar(context: context, text: 'success');
            } else if (state is SellError) {
              Navigator.pop(context);
              showToast(msg: 'error');
            } else {
              showLottieDialog(
                  context: context, lottieAsset: 'assets/json/loding.json');
            }
          },
          builder: (context, state) {
            SellCubit cubit = SellCubit.get(context);
            return SingleChildScrollView(
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
                    CustomTextFormField(
                      hintText: 'Enter title',
                      controller: titleController,
                    ),
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
                          'Model',
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
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
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
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
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
                            controller: modelController,
                          ),
                        ),
                      ],
                    ),
                    Gap(20.h),
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
                    Text(
                      'Price',
                      style: getBodyStyle(context,
                          fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                    CustomTextFormField(
                      width: 160.w,
                      hintText: 'Enter Price',
                      hintFontSize: 12.sp,
                      keyboardType: TextInputType.number,
                      controller: priceController,
                    ),
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
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write description about your car',
                        ),
                      ),
                    ),
                    Gap(20.h),
                    imageFileList!.isNotEmpty
                        ? SizedBox(
                            height: 150.h,
                            width: double.infinity,
                            child: GridView.builder(
                              itemCount: imageFileList!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Image.file(
                                      height: 150.h,
                                      File(imageFileList![index].path),
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                        top: 5.h,
                                        right: 5.w,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              imageFileList!.removeAt(index);
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                AppColors.whiteColor,
                                            radius: 10,
                                            child: Icon(
                                              Icons.close,
                                              size: 15.r,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        )),
                                  ],
                                );
                              },
                            ),
                          )
                        : const SizedBox(),
                    Gap(10.h),
                    InkWell(
                      onLongPress: () {
                        // uploadPhoto(image: File(imageFileList![0].path));
                      },
                      onTap: () {
                        selectImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.camera_alt_outlined),
                          Text(
                            'Upload images/Video',
                            style: getBodyStyle(context,
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Gap(20.h),
                    Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        text: 'Sell Your Car',
                        color: AppColors.whiteColor,
                        onTap: () {
                          if (titleController.text.isNotEmpty &&
                              modelController.text.isNotEmpty &&
                              priceController.text.isNotEmpty &&
                              descriptionController.text.isNotEmpty) {
                            if (imageFileList!.isNotEmpty) {
                              if (imageFileList!.length == 3) {
                                cubit.sellYourCar(
                                    fileList: imageFileList!,
                                    title: titleController.text,
                                    selectedOption: _selectedOption,
                                    model: modelController.text,
                                    alarm: _alarm!,
                                    cruiseControl: _cruiseControl!,
                                    price: priceController.text,
                                    description: descriptionController.text,
                                    bluetooth: _bluetooth!,
                                    frontParkingSensor: _frontParkingSensor!);
                              } else {
                                showToast(msg: 'Please select 3 images');
                              }
                            } else {
                              showToast(msg: 'Please select 3 image');
                            }
                          } else {
                            showToast(msg: 'All fields are required');
                          }
                        },
                      ),
                    ),
                    Gap(20.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
