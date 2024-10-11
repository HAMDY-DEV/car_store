
import 'package:car_store/features/profile_view/model/user_model.dart';

sealed class AuctionState {}

final class AuctionInitial extends AuctionState {}

//getDataUserId
class GetUserDataLoading extends AuctionState {}

class GetUserDataSuccess extends AuctionState {
  final UserModel userModel;
  GetUserDataSuccess({required this.userModel});
}

class GetUserDataError extends AuctionState {
  final String error;
  GetUserDataError(this.error);
}

//updateData
class UpdateAuctionLoading extends AuctionState {}

class UpdateAuctionSuccess extends AuctionState {}

class UpdateAuctionError extends AuctionState {
  final String error;
  UpdateAuctionError(this.error);
}


class DeleteAuctionLoading extends AuctionState {}

class DeleteAuctionSuccess extends AuctionState {}

class DeleteAuctionError extends AuctionState {
  final String error;
  DeleteAuctionError(this.error);
}
