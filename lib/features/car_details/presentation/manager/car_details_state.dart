import 'package:car_store/features/profile_view/model/user_model.dart';

sealed class CarDetailsState {}

final class CarDetailsInitial extends CarDetailsState {}

final class GetUserDataLoading extends CarDetailsState {}

final class GetUserDataSuccess extends CarDetailsState {
  UserModel userModel;

  GetUserDataSuccess({required this.userModel});
}

final class GetUserDataError extends CarDetailsState {
  String error;

  GetUserDataError({required this.error});
}
