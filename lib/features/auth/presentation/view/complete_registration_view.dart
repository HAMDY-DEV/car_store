import 'dart:io';
import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/function/show_error_dialogs.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/bottom_navigation_bar.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/core/widget/show_loading_and_error.dart';
import 'package:car_store/features/auth/presentation/manager/auth_cubit.dart';
import 'package:car_store/features/auth/presentation/manager/auth_state.dart';
import 'package:car_store/features/auth/presentation/widget/costom_text_form_field.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class CompleteRegistrationView extends StatefulWidget {
  const CompleteRegistrationView({super.key});

  @override
  State<CompleteRegistrationView> createState() =>
      _CompleteRegistrationViewState();
}

class _CompleteRegistrationViewState extends State<CompleteRegistrationView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController adressController = TextEditingController();

  TextEditingController phone1Controller = TextEditingController();

  TextEditingController phone2Controller = TextEditingController();

  String? profileUrl;
  File? file;
  bool? pickerImageLodeing;

  double? latitude;
  double? longitude;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _pickImage() async {
    final ImagePicker pickerImage = ImagePicker();
    XFile? path = await pickerImage.pickImage(source: ImageSource.gallery);
    if (path != null) {
      setState(() {
        file = File(path.path);
      });
    }

    profileUrl = await uploadPhoto(image: file!);
  }

  Future<String> uploadPhoto({required File image}) async {
    showLottieDialog(context: context, lottieAsset: 'assets/json/loding.json');
    final FirebaseAuth auth = FirebaseAuth.instance;
    Reference ref = FirebaseStorage.instanceFor(
            bucket: 'gs://car-store-2024.appspot.com') //
        .ref()
        .child('users/${auth.currentUser!.uid}');

    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    await ref.putFile(image, metadata);
    String url;
    try {
      navigatorPop(context);
      url = await ref.getDownloadURL();
      setState(() {});
      return url;
    } catch (e) {
      showToast(msg: e.toString());
    }
    return 'url';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is CompleteRegistrationSuccess) {
              navigatorToAndRemoveUntil(context, const BottomNavigationView());
            } else if (state is CompleteRegistrationLoading) {
              showLottieDialog(
                  context: context, lottieAsset: 'assets/json/loding.json');
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Padding(
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
                          borderRadius:
                              BorderRadius.circular(60.r), // حواف مستديرة
                        ),
                        child: CircleAvatar(
                          radius: 50.r,
                          backgroundImage: profileUrl == null
                              ? const AssetImage('assets/images/man.png')
                              : NetworkImage(profileUrl!),
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
                            onPressed: () {
                              _pickImage();
                            },
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
                          onPressed: () {
                            _determinePosition().then((onValue) {
                              latitude = onValue.latitude;
                              longitude = onValue.longitude;
                              
                            });
                          },
                          icon: const Icon(Icons.location_on),
                        ),
                        Text(
                          'Hamdy Fathy',
                          style: getTitleStyle(context,
                              fontWeight: FontWeight.bold),
                        ),
                        Gap(50.h),
                      ],
                    ),
                    Gap(20.h),
                    //adress
                    CustomTextFormField(
                      prefixIcon: Icons.location_on,
                      hintText: S.of(context).address,
                      controller: adressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).enter_your_address;
                        }
                        return null;
                      },
                    ),
                    Gap(20.h),
                    //Phone
                    CustomTextFormField(
                      prefixIcon: Icons.phone,
                      hintText: S.of(context).phone_number1,
                      controller: phone1Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).phone_number1;
                        }
                        return null;
                      },
                    ),
                    Gap(20.h),
                    //Phone2
                    CustomTextFormField(
                      prefixIcon: Icons.phone,
                      hintText: S.of(context).phone_number2,
                      controller: phone2Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).phone_number2;
                        }
                        return null;
                      },
                    ),
                    Gap(20.h),
                    CustomButton(
                      text: S.of(context).complete_registration,
                      color: AppColors.whiteColor,
                      onTap: () {

                        if (formKey.currentState!.validate()) {
                          if (profileUrl != null) {
                            if (latitude != null && longitude != null) {
                              AuthCubit.get(context).completeRegistration(
                                photoURL: profileUrl!,
                                phone1: phone1Controller.text,
                                phone2: phone2Controller.text,
                                address: adressController.text,
                                latitude: latitude.toString(),
                                longitude: longitude.toString(),
                              );
                            } else {
                              showToast(msg: 'Please select your location');
                            }
                          } else {
                            showToast(msg: 'Please upload your photo');
                          }
                        }
                      },
                    )
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
