import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/models/categories_model.dart';
import 'package:matgar/shared/components/components.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state) {
        var cubit= ShopCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildCatItem(cubit.categoriesModel!.data!.data[index]),
          separatorBuilder: (context, index) => mySeparator(),
          itemCount: cubit.categoriesModel!.data!.data.length,
        );
      },
    );
  }
}
Widget buildCatItem(DataModel model)=>Padding(
  padding: const EdgeInsets.all(15.0),
  child: GestureDetector(
    onTap: (){},
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Image(
          image: NetworkImage(model.image!),
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
        const SizedBox(

          width: 20,
        ),
        Text(
          model.name!,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(
            Icons.arrow_forward_ios
        )
      ],
    ),
  ),
);