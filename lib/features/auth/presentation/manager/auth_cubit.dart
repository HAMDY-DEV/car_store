import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/function/show_error_dialogs.dart';
import 'package:car_store/features/auth/presentation/manager/auth_state.dart';
import 'package:car_store/features/auth/presentation/view/complete_registration_view.dart';
import 'package:car_store/features/auth/presentation/view/welcome_view.dart';
import 'package:car_store/features/home/presentation/view/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  //chakUser
  void chakUser(context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
      } else {
        if (user.photoURL == 'false') {
          navigatorToAndRemoveUntil(context, const CompleteRegistrationView());
        } else {
          navigatorToAndRemoveUntil(context, const HomeView());
        }
      }
    });
  }

  //Login
  void login(
      {required context, required String email, required String password}) {
    User? user = FirebaseAuth.instance.currentUser;
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccess());
      if (user!.photoURL == 'false') {
        navigatorToAndRemoveUntil(context, const CompleteRegistrationView());
      } else {
        navigatorToAndRemoveUntil(context, const HomeView());
      }
    }).catchError((onError) {
      emit(LoginError());
    });
  }

  //Register
  void register(
      {required context,
      required bool company,
      required String name,
      required String email,
      required String password}) async {
    emit(RegisterLoading());
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((onValue) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      users.doc(user!.uid).set(
        {
          'name': name,
          'email': email,
          'company': company,
          'uid': user.uid,
          'photoURL': '',
          'phone': '',
          'password': password,
          'address': '',
          'latitude': '',
          'longitude': '',
          'isVerified': 'false',
        },
        SetOptions(merge: true),
      );
      user.updateDisplayName(company.toString());
      user.updatePhotoURL('false');
      navigatorToAndRemoveUntil(context, const CompleteRegistrationView());
      emit(RegisterSuccess());
    }).catchError((onError) {
      emit(RegisterError());
      showToast(msg: onError.toString());
    });
  }


  //Forget Password
  void forgetPassword({required context, required String email}) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      showToast(msg: 'Check your email');
    }).catchError((onError) {
      showToast(msg: onError.toString());
    });
  }



  //Logout
  void logout(context) {
    FirebaseAuth.instance.signOut();
    navigatorToAndRemoveUntil(context, const WelcomeView());
  }



  // complete registration
  void completeRegistration(context) {
    
  }

  
}
