import 'dart:developer';

import 'package:car_store/features/chat_view/presentation/manager/chat_state.dart';
import 'package:car_store/features/profile_view/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);
  UserModel? senderModel;
  UserModel? receiverModel;
  Stream<DatabaseEvent> streamDatat() {
    return FirebaseDatabase.instance.ref("chats").orderByChild("time").onValue;
  }

  getDataUserId({required String id}) {
    emit(DataUserLoading());
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(id).get().then((value) {
      senderModel = UserModel.fromMap(value.data() as Map<String, dynamic>);
      emit(DataUserSuccess(userModel: senderModel!));
    }).catchError((onError) {
      emit(DataUserError());
    });
  }

  void sendMessage({required String message, required String idChat}) {
    // Map<String, dynamic>? receiver;
    final idUser = FirebaseAuth.instance.currentUser!.uid;
    final timestamp = DateTime.now().toIso8601String(); // ISO format for time

    final DatabaseReference send =
        FirebaseDatabase.instance.ref("chats").child(idChat).push();
    send.set({
      'key': send.parent!.key,
      'idCompany': idChat,
      'idBuyer': idUser,
      'time': timestamp,
      'message': message,
      'Sender': idUser,
      'seen': false,
      'sent': false,
    });
  }

  void getUserData({required String userId}) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(userId).get().then((value) {
      receiverModel = UserModel.fromMap(value.data() as Map<String, dynamic>);
    }).catchError((onError) {});
  }
}




/*






final idUser = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference send = FirebaseFirestore.instance.collection('chats');
    send.doc("$idCompany&$idUser").set({
      'key': send.id,
      'idCompany': idCompany,
      'idBuyer': idUser,
      'time': DateTime.now().toIso8601String(),
      'message': message,
      'Sender': idUser,
      'seen': false,
      'sent': false,
    }, SetOptions(merge: false)).then((value) {});







 

*/