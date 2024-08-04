import 'package:car_store/features/profile_view/presentation/manager/profile_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  void getUserData({required String userId}) {
    emit(ProfileLoading());
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(userId).get().then((value) {
      emit(ProfileSuccess(data: value.data() as Map<String, dynamic>));
    }).catchError((onError) {
      emit(ProfileError());
    });
  }
}
