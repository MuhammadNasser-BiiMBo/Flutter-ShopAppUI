import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/models/login_model.dart';
import 'package:matgar/modules/register/cubit/states.dart';
import 'package:matgar/shared/network/end_points/end_points.dart';
import 'package:matgar/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit():super(ShopRegisterInitialState());

  ShopLoginModel? registerModel;
  static ShopRegisterCubit get(context) =>BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){

    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data:
      {
        'email':email,
        'password': password,
        'phone': phone,
        'name': name,
      },
      lang: 'ar'
    ).then((value) {
      registerModel=ShopLoginModel.fromJson(value.data);
      print(value.data);

      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }


  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangeVisibilityState());
  }
}