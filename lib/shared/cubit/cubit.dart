
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/models/categories_model.dart';
import 'package:matgar/models/change_favourites_model.dart';
import 'package:matgar/models/favourites_model.dart';
import 'package:matgar/models/home_model.dart';
import 'package:matgar/models/login_model.dart';
import 'package:matgar/models/search_model.dart';
import 'package:matgar/modules/categories/categories_screen.dart';
import 'package:matgar/modules/favourites/favourites_screen.dart';
import 'package:matgar/modules/products/product_screen.dart';
import 'package:matgar/shared/cubit/states.dart';
import 'package:matgar/shared/network/end_points/end_points.dart';
import 'package:matgar/shared/network/remote/dio_helper.dart';

import '../../models/user_model.dart';
import '../../modules/User/User_screen.dart';
import '../components/constants.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens=[
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
     UserScreen(),
  ];

  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int ,bool> favourites={};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      // print(homeModel?.data?.products);

      homeModel!.data!.products!.forEach((element) {
        favourites.addAll({
          element.id! :element.inFavorites!
        });
      });
      print(favourites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories(){
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      // print(homeModel?.data?.products);
      emit(ShopCategoriesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopCategoriesErrorState(error.toString()));
    });
  }
  FavouritesModel? favouritesModel;
  void getFavourites(){
    emit(ShopGetFavouritesLoadingState());
    DioHelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value) {
      favouritesModel=FavouritesModel.fromJson(value.data);
      // print(homeModel?.data?.products);
      emit(ShopGetFavouritesSuccessState(favouritesModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopGetFavouritesErrorState(error.toString()));
    });
  }

  ChangeFavModel? changeFavModel;
  void changeFav(int productId){
    favourites[productId]=!favourites[productId]!;
    emit(ShopFavouritesChangeState());
    DioHelper.postData(
        url: FAVOURITES,
        data: {
          'product_id':productId
        },
        token: token
    ).then((value)  {
      changeFavModel=ChangeFavModel.fromJson(value.data);
      emit(ShopFavouritesSuccessState(changeFavModel!));
      if(!changeFavModel!.status!){
        favourites[productId]=!favourites[productId]!;
      }else{
        getFavourites();
      }
    }).catchError((error){
      print(error.toString());
      emit(ShopFavouritesErrorState(error.toString()));
    });
  }

  ShopLoginModel? userModel;
  void getUserData(){
    emit(ShopGetUserDataLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel=ShopLoginModel.fromJson(value.data);
      print(userModel?.data?.name);
      emit(ShopGetUserDataSuccessState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopGetUserDataErrorState(error.toString()));
    });
  }

  UserModel? user;
  void updateUserData({
  required String name,
  required String email,
  required String phone,
}){
    emit(ShopGetUpdateLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone
      },
    ).then((value) {
      getUserData();
      user=UserModel.fromJson(value.data);
      print(user?.data?.name);
      emit(ShopGetUpdateSuccessState(user!));
    }).catchError((error){
      print(error.toString());
      emit(ShopGetUpdateErrorState(error.toString()));
    });
  }


  SearchModel? searchModel;
  void search(String text){
    emit(ShopGetSearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        data: {
          'text':text
        },
        token: token,
    ).then((value)  {
      searchModel=SearchModel.fromJson(value.data);
      emit(ShopGetSearchSuccessState(searchModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopGetSearchErrorState(error.toString()));
    });
  }
}
