import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/modules/search/search_screen.dart';
import 'package:matgar/shared/components/components.dart';
import 'package:matgar/shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit= ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Matgar',
              style: TextStyle(
                letterSpacing: 1.2,
                fontSize: 22
              ),
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search
                  )
              )
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                      Icons.home,
                  ),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(
                      Icons.apps,
                  ),
                label: 'Categories'
              ),
              BottomNavigationBarItem(
                icon: Icon(
                      Icons.favorite_outlined,
                  ),
                label: 'Favourites'
              ),
              BottomNavigationBarItem(
                icon: Icon(
                      Icons.person,
                  ),
                label: 'User'
              ),
            ],
          ),
        );
      },
    );
  }
}
