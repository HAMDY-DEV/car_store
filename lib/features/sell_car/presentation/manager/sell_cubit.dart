import 'dart:io';
import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/function/show_error_dialogs.dart';
import 'package:car_store/features/sell_car/presentation/manager/sell_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class SellCubit extends Cubit<SellState> {
  SellCubit() : super(SellInitial());

  static SellCubit get(context) => BlocProvider.of<SellCubit>(context);

  Future<String> uploadPhoto(
      {required File image, required String ket, required String path}) async {
    Reference ref = FirebaseStorage.instanceFor(
            bucket: 'gs://car-store-2024.appspot.com') //
        .ref()
        .child('cars/$path/$ket');

    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    await ref.putFile(image, metadata);

    String url;
    try {
      url = await ref.getDownloadURL();

      return url;
    } catch (e) {
      showToast(msg: e.toString());
    }
    return 'url';
  }

  Future<void> sellYourCar({
    required context,
    required String title,
    required String selectedOption,
    required String model,
    required String price,
    required String description,
    required bool alarm,
    required bool cruiseControl,
    required bool bluetooth,
    required String phone,
    required bool frontParkingSensor,
    required List<XFile> fileList,
  }) async {
    emit(SellLoading());
    DatabaseReference ref = FirebaseDatabase.instance.ref("cars").push();
    ref.set({
      "userUid": FirebaseAuth.instance.currentUser!.uid,
      "title": title,
      'photoUrl': [
        await uploadPhoto(
            image: File(fileList[0].path), path: ref.key!, ket: '${ref.key!}1'),
        await uploadPhoto(
            image: File(fileList[1].path), path: ref.key!, ket: '${ref.key!}2'),
        await uploadPhoto(
            image: File(fileList[2].path), path: ref.key!, ket: '${ref.key!}3'),
      ],
      "condition": selectedOption,
      "favorite": false,
      "model": model,
      "alarm": alarm,
      "phone": "+2$phone",
      "cruiseControl": cruiseControl,
      "bluetooth": bluetooth,
      "frontParkingSensor": frontParkingSensor,
      "description": description,
      "price": price,
      "key": ref.key,
    }).then((value) {

      emit(SellSuccess());
       navigatorPop(context);
    }).catchError((onError) {
      emit(SellError());
    });
  }

  Future<void> sellYourCarInAuction({
    required context,
    required String title,
    required String selectedOption,
    required String model,
    required String price,
    required String description,
    required bool alarm,
    required bool cruiseControl,
    required bool bluetooth,
    required bool frontParkingSensor,
    required DateTime selectedDate,
    required List<XFile> fileList,
  }) async {
    emit(SellLoading());
    DatabaseReference ref = FirebaseDatabase.instance.ref("auctions").push();
    ref.set({
      "creatorUid": FirebaseAuth.instance.currentUser!.uid,
      "title": title,
      'photoUrl': [
        await uploadPhoto(
            image: File(fileList[0].path), path: ref.key!, ket: '${ref.key!}1'),
        await uploadPhoto(
            image: File(fileList[1].path), path: ref.key!, ket: '${ref.key!}2'),
        await uploadPhoto(
            image: File(fileList[2].path), path: ref.key!, ket: '${ref.key!}3'),
      ],
      "subscribers": [],
      "condition": selectedOption,
      "model": model,
      "alarm": alarm,
      "cruiseControl": cruiseControl,
      "bluetooth": bluetooth,
      "frontParkingSensor": frontParkingSensor,
      "description": description,
      "price": price,
      "key": ref.key,
      "selectedDate": selectedDate.toString(),
    }).then((value) {
       
      emit(SellSuccess());
      navigatorPop(context);
    }).catchError((onError) {
      emit(SellError());
    });
  }
}
