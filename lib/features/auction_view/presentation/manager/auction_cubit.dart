import 'package:car_store/features/profile_view/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auction_state.dart';

class AuctionCubit extends Cubit<AuctionState> {
  AuctionCubit() : super(AuctionInitial());

  static AuctionCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  Stream<DatabaseEvent>? getAuctionData() {
    // emit(HomeLoading());
    Stream<DatabaseEvent> onValue =
        FirebaseDatabase.instance.ref("auctions").onValue;
    // emit(HomeSuccess());
    return onValue;
  }

  void updateAuctionData({
    required String key,
    required String price,
    required String highestPrice,
    required List<String> subscribers,

  }) {
    emit(UpdateAuctionLoading());
    DatabaseReference ref = FirebaseDatabase.instance.ref("auctions").child(key);
    ref.update({
      "price": price,
      'subscribers':subscribers,
      'highestPrice': highestPrice,
    }).then((value) {
      emit(UpdateAuctionSuccess());
    }).catchError((onError) {
      emit(UpdateAuctionError(onError.toString()));
    });
  }

  void deleteAuctionData({required String key}) {
    emit(DeleteAuctionLoading());
    DatabaseReference ref = FirebaseDatabase.instance.ref("auctions").child(key);
    ref.remove().then((value) {
      emit(DeleteAuctionSuccess());
    }).catchError((onError) {
      emit(DeleteAuctionError(onError.toString()));
    });
  }

  getDataUserId({required String id}) {
    emit(GetUserDataLoading());
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(id).get().then((value) {
      userModel = UserModel.fromMap(value.data() as Map<String, dynamic>);
      emit(GetUserDataSuccess(userModel: userModel!));
    }).catchError((onError) {
      emit(GetUserDataError(onError.toString()));
    });
  }


}
