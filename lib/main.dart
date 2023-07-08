import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/layout/shop_layout.dart';
import 'package:matgar/modules/login/login_screen.dart';
import 'package:matgar/modules/on_boarding/on_boarding_screen.dart';
import 'package:matgar/shared/components/constants.dart';
import 'package:matgar/shared/cubit/cubit.dart';
import 'package:matgar/shared/network/bloc_observer/bloc_observer.dart';
import 'package:matgar/shared/network/local/cache_helper.dart';
import 'package:matgar/shared/network/remote/dio_helper.dart';
import 'package:matgar/shared/styles/themes.dart';

import 'modules/login/cubit/cubit.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  // bool isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  late bool? onBoarding =CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  // print(onBoarding);
  print(token);
  if(onBoarding!=null){
    if(token!=null) {
      widget=const ShopLayout();
    } else {
      widget=const ShopLoginScreen();
    }
  }else{
    widget=OnBoardingScreen();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget
{
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategories()..getFavourites()..getUserData(),
        ),
        BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        )
    ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          home:  startWidget
      ),
    );
  }

}