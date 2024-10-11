import 'dart:developer';
import 'package:car_store/core/function/routing.dart';
import 'package:car_store/features/auth/presentation/view/welcome_view.dart';
import 'package:car_store/features/profile_view/model/user_model.dart';
import 'package:car_store/features/profile_view/presentation/manager/profile_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  List<dynamic>? mapCar;
  List<dynamic>? carList;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  UserModel? userModel;
  void getUserData({required String userId}) {
    emit(ProfileLoading());
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(userId).get().then((value) {
      userModel = UserModel.fromMap(value.data() as Map<String, dynamic>);
      emit(ProfileSuccess(userModel: userModel!));
    }).catchError((onError) {
      emit(ProfileError());
    });
  }

  void getData() async {
    
    try {
      final dataSnapshot = await FirebaseDatabase.instance.ref("cars").get();
      final dataf = (dataSnapshot.value as Map).cast<String, dynamic>();
      mapCar = dataf.values.toList();
    
      carList =
          mapCar!.where((car) => car['userUid'] == userId.toString()).toList();
      getUserData(userId: userId);
    } catch (error) {
      log('Error fetching data: $error');
    }
  }

  void deleteCar({required String carId}) {
    emit(DeleteCarLoading());
    FirebaseDatabase instance = FirebaseDatabase.instance;
    instance.ref("cars").child(carId).remove().then((value) {
      getData();
      emit(DeleteCarSuccess());
      // ignore: invalid_return_type_for_catch_error
    }).catchError((onError) => emit(DeleteCarError()));
  }

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((onValue) {
      navigatorToAndRemoveUntil(context, const WelcomeView());
    });
  }
}
