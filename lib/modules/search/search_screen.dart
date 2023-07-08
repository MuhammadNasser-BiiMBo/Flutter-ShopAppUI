import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/shared/components/components.dart';
import 'package:matgar/shared/cubit/cubit.dart';
import 'package:matgar/shared/cubit/states.dart';

import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      label: 'Search',
                      prefix: Icons.search,
                      validate: (String value){
                        if(value.isEmpty){
                          return 'Type your Product name ';
                        }
                      },
                    onSubmit: (String text){
                        cubit.search(text);
                    }
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if(state is ShopGetSearchLoadingState)
                  const LinearProgressIndicator(),
                  if(state is !ShopGetSearchLoadingState)
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>buildSearchItem(cubit.searchModel!.data!.data![index],context),
                        separatorBuilder: (context,index)=>mySeparator(),
                        itemCount: 10,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildSearchItem(model,context)=>Padding(
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
              image: NetworkImage(model.image!),
              width: 150,
              height: 150,
            ),
            // if(model.product!.discount!=0)
            //   Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 5),
            //     color: Colors.red,
            //     child: const Text(
            //       'Discount',
            //       style: TextStyle(
            //           color: Colors.white
            //       ),
            //     ),
            //   )
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 15, height: 1.3, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: const TextStyle(fontSize: 13, color: defaultColor),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // if(model.discount !=0)
                  //   Text(
                  //     model.product!.oldPrice.toString(),
                  //     style: const TextStyle(
                  //       fontSize: 11,
                  //       color: Colors.grey,
                  //       decoration: TextDecoration.lineThrough,
                  //     ),
                  //   ),
                  const Spacer(),
                  IconButton(
                    onPressed: (){
                      print(model.id);
                      ShopCubit.get(context).changeFav(model.id!);
                    },
                    icon: CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favourites[model.id]!?Colors.red:Colors.blue[400],
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