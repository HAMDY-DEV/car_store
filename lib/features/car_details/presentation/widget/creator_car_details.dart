import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/car_details/presentation/manager/car_details_cubit.dart';
import 'package:car_store/features/car_details/presentation/manager/car_details_state.dart';
import 'package:car_store/features/profile_view/model/user_model.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CreatorCarDetails extends StatelessWidget {
  const CreatorCarDetails({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarDetailsCubit()..getDataUserId(id: userId),
      child: BlocBuilder<CarDetailsCubit, CarDetailsState>(
        builder: (context, state) {
          UserModel? userModel = CarDetailsCubit.get(context).userModel;
          return userModel == null
              ? const Center(child: CircularProgressIndicator())
              : Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userModel.photoURL),
                      radius: 30.r, // Adjust radius as needed
                    ),
                    Gap(10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).Creator,
                            style: getBodyStyle(context,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.greyColor)),
                        Text(userModel.name,
                            style: getBodyStyle(context,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w900,
                                color: AppColors.blackColor)),
                      ],
                    ),
                  ],
                );
        },
      ),
    );
  }
}
