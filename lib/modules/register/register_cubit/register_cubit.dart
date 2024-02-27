import 'package:branches_information/models/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changeIcon() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePassIconState());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          createUser(name: name, email: email, uID: value.user!.uid);
  //    emit(RegisterSuccessState());
    }).catchError((error) {
      print('Register error state ${error.toString()}');
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String uID,
  }) {
    UserModel userModel =
        UserModel(name: name, email: email, uId: uID, isAdmin: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .set(userModel.toMap())
        .then((value) {
          emit(CreateUserSuccessState());
    })
        .catchError((error) {
          print('Create User error state ${error.toString()}');
          emit(CreateUserErrorState(error.toString()));
    });
  }
}
