import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/features/car_details/presentation/manager/car_details_cubit.dart';
import 'package:car_store/features/car_details/presentation/manager/car_details_state.dart';
import 'package:car_store/features/car_details/presentation/widget/body_car_details.dart';
import 'package:car_store/features/home/model/home_model.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key, required this.cars});
  final HomeModel cars;

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  int currentSlide = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CarDetailsCubit()..getDataUserId(id: widget.cars.userUid),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: Text(
            widget.cars.title.toUpperCase(),
            style: getBodyStyle(
              context,
              color: AppColors.primaryColor,
              fontSize: 20.sp, // تكبير حجم الخط
              fontWeight: FontWeight.bold, // جعل الخط عريضًا
            ),
          ),
        ),
        body: BodyCarDetails(cars: widget.cars),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<CarDetailsCubit, CarDetailsState>(
            builder: (context, state) {
              CarDetailsCubit cubit = CarDetailsCubit.get(context);
              if (state is GetUserDataSuccess) {
                return Row(
                  children: [
                    CustomButton(
                      width: 290.w,
                      text: S.of(context).GoToMap,
                      onTap: () {
                        cubit.openMap(
                          latitude: double.parse(state.userModel.latitude),
                          longitude: double.parse(state.userModel.longitude),
                        );
                      },
                      color: AppColors.whiteColor,
                    ),
                    const Gap(8),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          String phoneNumber = widget.cars.phone;
                          String message = 'Hello, how are you?';
                          cubit.openWhatsApp(context, phoneNumber, message);
                        },
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.message_rounded,
                            color: AppColors.whiteColor,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is GetUserDataError) {
                return Text(state.error);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
