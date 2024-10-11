
import 'package:car_store/features/profile_view/model/user_model.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSuccess extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatError extends ChatState {}

final class DataUserSuccess extends ChatState {
  UserModel userModel;

  DataUserSuccess({required this.userModel});
}

final class DataUserLoading extends ChatState {}

final class DataUserError extends ChatState {}






