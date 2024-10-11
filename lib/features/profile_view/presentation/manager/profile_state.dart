import 'package:car_store/features/profile_view/model/user_model.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}



final class ProfileSuccess extends ProfileState {
  UserModel userModel;
  ProfileSuccess({required this.userModel});
}

final class ProfileError extends ProfileState {}

final class DeleteCarLoading extends ProfileState {}

final class DeleteCarSuccess extends ProfileState {}

final class DeleteCarError extends ProfileState {}


