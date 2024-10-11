import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/function/show_error_dialogs.dart';
import 'package:car_store/core/widget/bottom_navigation_bar.dart';
import 'package:car_store/features/auth/presentation/manager/auth_state.dart';
import 'package:car_store/features/auth/presentation/view/complete_registration_view.dart';
import 'package:car_store/features/auth/presentation/view/welcome_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

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
        } else if (user.photoURL == 'true') {
          navigatorToAndRemoveUntil(context, const BottomNavigationView());
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
      emit(LoginSuccess(user: user));
    }).catchError((onError) {
      emit(LoginError(msg: onError.toString()));
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

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((onValue) {
      User? user = FirebaseAuth.instance.currentUser;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(user!.uid).set(
        {
          'name': name,
          'email': email,
          'company': company,
          'uid': user.uid,
          'password': password,
          'latitude': '',
          'longitude': '',
          'isVerified': 'false',
        },
        SetOptions(merge: true),
      ).then((onValue) {
        user.updateDisplayName(company.toString());
        user.updatePhotoURL('false');
        emit(RegisterSuccess());
      }).catchError((onError) {
        showToast(msg: onError.toString());
      });
    }).catchError((onError) {
      emit(RegisterError(msg: onError.toString()));
    });
  }

  //Forget Password
  void forgetPassword({required context, required String email}) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      showToast(msg: 'Check your email');
      navigatorPop(context);
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
  void completeRegistration({
    required String photoURL,
    required String phone1,
    required String phone2,
    required String address,
    required String latitude,
    required String longitude,
  }) {
    emit(CompleteRegistrationLoading());
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User? user = FirebaseAuth.instance.currentUser;

    users.doc(user!.uid).set(
      {
        'photoURL': photoURL,
        'phone1': phone1,
        'phone2': phone2,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'favorites': []
      },
      SetOptions(merge: true),
    ).then((onValue) {
     
      user.updatePhotoURL('true');
      emit(CompleteRegistrationSuccess());
    }).catchError((onError) {
      showToast(msg: onError.toString());
      emit(CompleteRegistrationError());
    });
  }

  

   Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition();
  }



}
