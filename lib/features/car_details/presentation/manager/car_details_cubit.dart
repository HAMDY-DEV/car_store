
import 'dart:developer';

import 'package:car_store/features/car_details/presentation/manager/car_details_state.dart';
import 'package:car_store/features/profile_view/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CarDetailsCubit extends Cubit<CarDetailsState> {
  CarDetailsCubit() : super(CarDetailsInitial());

  static CarDetailsCubit get(context) => BlocProvider.of(context);

    UserModel? userModel;

    getDataUserId({required String id}) {
    emit(GetUserDataLoading());
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(id).get().then((value) {
      userModel = UserModel.fromMap(value.data() as Map<String, dynamic>);
      emit(GetUserDataSuccess(userModel: userModel!));
    }).catchError((onError) {
      emit(GetUserDataError(error: onError.toString()));
    });
  }

   void openMap({required double latitude, required double longitude}) async {
    final String url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(url)) {
      await launch(url);
      log('latitude: $latitude, longitude: $longitude');
    } else {
      log('Could not launch $url');
    }
  }

  void openWhatsApp(
      BuildContext context, String phoneNumber, String message) async {
    String url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يمكن فتح واتساب. تأكد من تثبيته.'),
        ),
      );
    }
  }

}
