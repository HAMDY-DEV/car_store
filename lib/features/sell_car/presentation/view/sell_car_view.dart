import 'dart:io';
import 'package:car_store/core/function/routing.dart';
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
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SellCarView extends StatefulWidget {
  SellCarView({super.key, required this.Sell});
  String Sell;

  @override
  State<SellCarView> createState() => _SellCarViewState();
}

class _SellCarViewState extends State<SellCarView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String _selectedOption = 'new';
  bool? _alarm = false;
  bool? _cruiseControl = false;
  bool? _bluetooth = false;
  bool? _frontParkingSensor = false;
  DateTime? _selectedDate;
  SellCubit? cubit;
  String deta = 'select date';

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
        appBar: AppBar(
          forceMaterialTransparency: true,
        ),
        body: BlocConsumer<SellCubit, SellState>(
          listener: (context, state) {
            if (state is SellSuccess) {
              Navigator.pop(context);
              showSnackBar(context: context, text: S.of(context).success);
            } else if (state is SellError) {
              Navigator.pop(context);
              showToast(msg: S.of(context).error);
            } else {
              showLottieDialog(
                  context: context, lottieAsset: 'assets/json/loding.json');
            }
          },
          builder: (context, state) {
            cubit = SellCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).Title,
                      style: getTitleStyle(context,
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    CustomTextFormField(
                      hintText: S.of(context).EnterTitle,
                      hintFontSize: 12.sp,
                      controller: titleController,
                    ),
                    Gap(20.h),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          S.of(context).Condition,
                          style: getTitleStyle(context,
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(
                          flex: 5,
                        ),
                        Text(
                          S.of(context).Model,
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
                                    S.of(context).new1,
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
                                    S.of(context).used1,
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
                            hintText: S.of(context).EnterModel,
                            hintFontSize: 12.sp,
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
                          text: S.of(context).Alarm,
                          value: _alarm,
                          onChanged: (value) {
                            setState(() {
                              _alarm = value;
                            });
                          },
                        ),
                        const Spacer(),
                        CustomChacBox(
                          text: S.of(context).CruiseControl,
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
                          text: S.of(context).Bluetooth,
                          value: _bluetooth,
                          onChanged: (value) {
                            setState(() {
                              _bluetooth = value;
                            });
                          },
                        ),
                        const Spacer(),
                        CustomChacBox(
                          text: S.of(context).FrontParkingSensor,
                          value: _frontParkingSensor,
                          onChanged: (value) {
                            setState(() {
                              _frontParkingSensor = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Gap(15.h),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).price,
                              style: getBodyStyle(context,
                                  fontSize: 14.sp, fontWeight: FontWeight.w600),
                            ),
                            Gap(5.h),
                            CustomTextFormField(
                              width: 160.w,
                              hintText: S.of(context).EnterPrice,
                              hintFontSize: 12.sp,
                              keyboardType: TextInputType.number,
                              controller: priceController,
                            ),
                          ],
                        ),
                        const Spacer(),
                        //
                        widget.Sell == 'auction'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).AuctionEndDate,
                                    style: getBodyStyle(context,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Gap(5.h),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 170.w,
                                    height: 64.h,
                                    decoration: decoration,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              showDatePickerWidget(
                                                  context: context);
                                            },
                                            icon: Icon(
                                              Icons.date_range,
                                              color: AppColors.primaryColor,
                                            )),
                                        Text(
                                          deta,
                                          style: getBodyStyle(
                                            context,
                                            color: AppColors.blackColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).MobileNumber,
                                    style: getBodyStyle(context,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Gap(5.h),
                                  CustomTextFormField(
                                    width: 160.w,
                                    hintText: S.of(context).EnterMobileNumber,
                                    hintFontSize: 12.sp,
                                    keyboardType: TextInputType.number,
                                    controller: phoneController,
                                  ),
                                ],
                              ),
                      ],
                    ),
                    Gap(15.h),
                    Text(
                      S.of(context).Description,
                      style: getTitleStyle(context,
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      decoration: decoration,
                      child: TextFormField(
                        maxLines: 5,
                        minLines: 5,
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText:
                              S.of(context).Write_description_about_your_car,
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
                      onTap: () {
                        selectImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.camera_alt_outlined),
                          Text(
                            S.of(context).Upload3images,
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
                        text: S.of(context).Sell_Your_Car,
                        color: AppColors.whiteColor,
                        onTap: () {
                          sellCar(context);
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

  showDatePickerWidget({required context}) {
    return showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(
                DateTime.now().add(const Duration(days: 365)).year,
                DateTime.now().add(const Duration(days: 365)).month,
                DateTime.now().add(const Duration(days: 365)).day),
            initialDate: DateTime.now())
        .then((value) {
      setState(() {
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        deta = formatter.format(value!);
        _selectedDate = value;
      });
    });
  }

  void sellCar(context) {
    if (titleController.text.isNotEmpty &&
        modelController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      if (imageFileList!.isNotEmpty) {
        if (imageFileList!.length == 3) {
          if (widget.Sell == 'sell') {
            cubit!.sellYourCar(
              context: context,
                phone: phoneController.text,
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
            if (_selectedDate != null) {
              cubit!.sellYourCarInAuction(
                context: context,
                  fileList: imageFileList!,
                  title: titleController.text,
                  selectedOption: _selectedOption,
                  model: modelController.text,
                  alarm: _alarm!,
                  cruiseControl: _cruiseControl!,
                  price: priceController.text,
                  description: descriptionController.text,
                  bluetooth: _bluetooth!,
                  selectedDate: _selectedDate!,
                  frontParkingSensor: _frontParkingSensor!);
             
            } else {
              showToast(msg: S.of(context).Please_select_date);
            }
          }
        } else {
          showToast(msg: S.of(context).Please_select_3_images);
        }
      } else {
        showToast(msg: S.of(context).Please_select_3_images);
      }
    } else {
      showToast(msg: S.of(context).All_fields_are_required);
    }
  }
}
