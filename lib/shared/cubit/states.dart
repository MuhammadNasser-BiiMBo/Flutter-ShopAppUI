import 'package:matgar/models/change_favourites_model.dart';
import 'package:matgar/models/favourites_model.dart';
import 'package:matgar/models/search_model.dart';
import 'package:matgar/models/user_model.dart';

import '../../models/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopCategoriesSuccessState extends ShopStates{}
class ShopCategoriesErrorState extends ShopStates{
  final String error;

  ShopCategoriesErrorState(this.error);
}

class ShopFavouritesChangeState extends ShopStates{}
class ShopFavouritesSuccessState extends ShopStates{
  final ChangeFavModel changeFavModel;

  ShopFavouritesSuccessState(this.changeFavModel);
}
class ShopFavouritesErrorState extends ShopStates{
  final String error;

  ShopFavouritesErrorState(this.error);
}

class ShopGetFavouritesLoadingState extends ShopStates{}
class ShopGetFavouritesSuccessState extends ShopStates{
  final FavouritesModel favouritesModel;

  ShopGetFavouritesSuccessState(this.favouritesModel);
}
class ShopGetFavouritesErrorState extends ShopStates{
  final String error;

  ShopGetFavouritesErrorState(this.error);
}

class ShopGetUserDataLoadingState extends ShopStates{}
class ShopGetUserDataSuccessState extends ShopStates{
  final ShopLoginModel userModel;

  ShopGetUserDataSuccessState(this.userModel);
}
class ShopGetUserDataErrorState extends ShopStates{
  final String error;

  ShopGetUserDataErrorState(this.error);
}

class ShopGetUpdateLoadingState extends ShopStates{}
class ShopGetUpdateSuccessState extends ShopStates{
  final UserModel user;

  ShopGetUpdateSuccessState(this.user);
}
class ShopGetUpdateErrorState extends ShopStates{
  final String error;

  ShopGetUpdateErrorState(this.error);
}


class ShopGetSearchLoadingState extends ShopStates{}
class ShopGetSearchSuccessState extends ShopStates{
  final SearchModel searchModel;

  ShopGetSearchSuccessState(this.searchModel);
}
class ShopGetSearchErrorState extends ShopStates{
  final String error;

  ShopGetSearchErrorState(this.error);
}
