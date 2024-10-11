import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/const_image.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/car_details/presentation/view/car_details.dart';
import 'package:car_store/features/favorite_view/presentation/manager/favorite_cubit.dart';
import 'package:car_store/features/favorite_view/presentation/manager/favorite_state.dart';
import 'package:car_store/features/favorite_view/presentation/widget/favorite_list_item.dart';
import 'package:car_store/features/home/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        centerTitle: true,
        title: Text(
          'CarStore',
          style: getTitleStyle(context, color: AppColors.primaryColor),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15.w),
            child: const Stack(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocProvider(
          create: (context) => FavoriteCubit()..getFavoriteData(),
          child: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              FavoriteCubit cubit = FavoriteCubit.get(context);

              if (state is GetUserFavoriteSuccess) {
                if (cubit.carList == null || cubit.carList!.isEmpty) {
                  return Center(
                    child: SvgPicture.asset(ConstImage.kNotFound),
                  );
                }

                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: cubit.carList!.length,
                    itemBuilder: (context, index) {
                      HomeModel car = HomeModel.fromJson(
                          Map<String, dynamic>.from(cubit.carList![index]));
                      return GestureDetector(
                        child: GestureDetector(
                          onTap: () {
                            navigatorTo(context, CarDetails(cars: car));
                          },
                          child: FavoriteListItem(
                            cars: car,
                            onTapFavorite: () {
                              cubit.removeFavorite(carId: car.key);
                            },
                          ),
                        ),
                      );
                    });
              } else if (state is FavoriteError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
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
