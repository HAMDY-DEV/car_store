import 'package:car_store/features/sell_car/presentation/manager/sell_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellCubit extends Cubit<SellState> {
  SellCubit() : super(SellInitial());

  static SellCubit get(context) => BlocProvider.of<SellCubit>(context);

  void sellYourCar({
    required String title,
    required String selectedOption,
    required String year,
    required String brand,
    required String model,
    required String price,
    required String description,
    required bool alarm,
    required bool cruiseControl,
    required bool bluetooth,
    required bool frontParkingSensor,
  }) {
    emit(SellLoading());
    DatabaseReference ref = FirebaseDatabase.instance.ref("cars").push();
    ref.set({
      "userUid": FirebaseAuth.instance.currentUser!.uid,
      "title": title,
      'photoUrl':
          "https://firebasestorage.googleapis.com/v0/b/car-store-2024.appspot.com/o/users%2FNyaSwq5w7UYxioQbEAfuIa4jCH82%2Fimage?alt=media&token=6a8dbf56-2482-4794-bd86-3561e20e9c60",
      "selectedOption": selectedOption,
      "year": year,
      "brand": brand,
      "model": model,
      "alarm": alarm,
      "cruiseControl": cruiseControl,
      "bluetooth": bluetooth,
      "frontParkingSensor": frontParkingSensor,
      "description": description,
      "price": price,
      "key": ref.key,
    }).then((value) {
      emit(SellSuccess());
    }).catchError((onError) {
      emit(SellError());
    });
  }

   


}
