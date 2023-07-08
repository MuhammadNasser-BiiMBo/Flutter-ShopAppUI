import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/models/login_model.dart';
import 'package:matgar/modules/login/cubit/states.dart';
import 'package:matgar/shared/network/end_points/end_points.dart';
import 'package:matgar/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit():super(ShopLoginInitialState());

  ShopLoginModel? loginModel;
  static ShopLoginCubit get(context) =>BlocProvider.of(context);

  void userLogin({required String email,required String password}){

    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email':email,
        'password': password,
      },
      lang: 'ar'
    ).then((value) {
      loginModel=ShopLoginModel.fromJson(value.data);
      print(value.data);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }


  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}