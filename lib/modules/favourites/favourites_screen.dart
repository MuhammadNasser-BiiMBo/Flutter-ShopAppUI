import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/models/favourites_model.dart';
import 'package:matgar/shared/components/components.dart';
import 'package:matgar/shared/cubit/cubit.dart';
import 'package:matgar/shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state) {
        var cubit=ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is !ShopGetFavouritesLoadingState,
          fallback: (context)=>const Center(child: CircularProgressIndicator(),),
          builder:(context)=> ListView.separated(
            itemBuilder: (context, index)=>buildFavItem(cubit.favouritesModel!.data!.data![index],context),
            separatorBuilder:(context,index)=> mySeparator(),
            itemCount: cubit.favouritesModel!.data!.data!.length,
          ),
        );
      } ,
    );
  }
}
Widget buildFavItem(FavouritesData model,context)=>Padding(
  padding: const EdgeInsets.all(5.0),
  child: SizedBox(
    height: 150,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(model.product!.image!),
              width: 150,
              height: 150,
            ),
            if(model.product!.discount!=0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: Colors.red,
              child: const Text(
                'Discount',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Text(
                model.product!.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 15, height: 1.3, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    model.product!.price.toString(),
                    style: const TextStyle(fontSize: 13, color: defaultColor),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if(model.product!.discount !=0)
                  Text(
                    model.product!.oldPrice.toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      print(model.id);
                      ShopCubit.get(context).changeFav(model.product!.id!);
                    },
                    icon: CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favourites[model.product!.id]!?Colors.red:Colors.blue[400],
                      radius: 14,
                      child: const Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);