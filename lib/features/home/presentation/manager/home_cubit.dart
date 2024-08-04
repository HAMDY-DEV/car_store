import 'dart:developer';

import 'package:car_store/features/home/presentation/manager/home_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  void getHomeData() {
    emit(HomeLoading());
    DatabaseReference ref = FirebaseDatabase.instance.ref("cars");
    ref.get().then((value) {
      log(value.value.toString());
    });
  }
}
