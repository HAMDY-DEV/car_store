import 'package:car_store/features/home/presentation/manager/home_state.dart';
import 'package:car_store/features/profile_view/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void getUserData({required String userId}) {
    emit(HomeLoading());
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(userId).get().then((value) {
      userModel = UserModel.fromMap(value.data() as Map<String, dynamic>);
      emit(HomeSuccess());
    }).catchError((onError) {
      emit(HomeError());
    });
  }

  //
  Stream<DatabaseEvent>? getHomeData() {
    // emit(HomeLoading());
    Stream<DatabaseEvent> onValue =
        FirebaseDatabase.instance.ref("cars").onValue;
    // emit(HomeSuccess());
    return onValue;
  }

  void updateToken() {
    FirebaseMessaging.instance.getToken();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseMessaging.instance.getToken().then((onValue) {
      users.doc(FirebaseAuth.instance.currentUser!.uid).set({
        'token': onValue,
      }, SetOptions(merge: true));
    });
  }

  List<dynamic> filter(
      {required Map<dynamic, dynamic> data,
      required TextEditingController minPriceController,
      required TextEditingController maxPriceController,
      required TextEditingController namePriceController,
      required String opshnCor,
      required TextEditingController modelController}) {
    final List<dynamic> cars;
    int minPrice = int.parse(
        minPriceController.text.isEmpty ? "0" : minPriceController.text);
    int maxPrice = int.parse(maxPriceController.text.isEmpty
        ? "99999999999999999"
        : maxPriceController.text);

    if (opshnCor == 'all') {
      cars = data.values
          .where((car) => car['title']
              .toLowerCase()
              .contains(namePriceController.text.toLowerCase()))
          .where((car) =>
              car['model']
                  .toLowerCase()
                  .contains(modelController.text.toLowerCase()) &&
              int.parse(car['price']) >= minPrice &&
              int.parse(car['price']) <= maxPrice)
          .toList();
    } else {
      cars = data.values
          .where((car) => car['title']
              .toLowerCase()
              .contains(namePriceController.text.toLowerCase()))
          .where((car) =>
              car['condition'] == opshnCor &&
              car['model']
                  .toLowerCase()
                  .contains(modelController.text.toLowerCase()) &&
              int.parse(car['price']) >= minPrice &&
              int.parse(car['price']) <= maxPrice)
          .toList();
    }
    return cars;
  }

  void removeFavorite({required String carId}) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'favorites': FieldValue.arrayRemove([carId])
    });
  }

  void addFavorite({required String carId}) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
          'favorites': FieldValue.arrayUnion([carId])
        })
        .then((value) {})
        .catchError((onError) {});
  }
}
