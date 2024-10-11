import 'dart:developer';
import 'package:car_store/features/favorite_view/presentation/manager/favorite_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  static FavoriteCubit get(context) => BlocProvider.of(context);
  
  String userId = FirebaseAuth.instance.currentUser!.uid;
  List<String>? idFavorite;
  List<dynamic>? mapCar;
  List<dynamic>? carList;

  Future<void> getFavoriteData() async {
    emit(GetUserFavoriteLoading());
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      final dataf = userDoc.data() as Map<String, dynamic>;
      idFavorite = List<String>.from(dataf['favorites'] ?? []);
      await getData();
      emit(GetUserFavoriteSuccess(listId: idFavorite!));
    } catch (error) {
      emit(GetUserFavoriteError());
    }
  }

  Future<void> getData() async {
    emit(FavoriteLoading());
    try {
      final dataSnapshot = await FirebaseDatabase.instance.ref("cars").get();
      final dataf = (dataSnapshot.value as Map).cast<String, dynamic>();
      mapCar = dataf.values.toList();
      carList = mapCar!.where((car) => idFavorite!.contains(car['key'])).toList();
      emit(FavoriteSuccess());
    } catch (error) {
      emit(FavoriteError());
      log('Error fetching data: $error');
    }
  }

  void removeFavorite({required String carId}) {
    FirebaseFirestore.instance.collection('users').doc(userId).update({
      'favorites': FieldValue.arrayRemove([carId])
    }).then((_) {
      getFavoriteData();
    });
  }
}
