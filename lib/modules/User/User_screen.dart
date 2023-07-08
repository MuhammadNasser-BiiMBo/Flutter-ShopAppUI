import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/shared/components/components.dart';
import 'package:matgar/shared/cubit/cubit.dart';
import 'package:matgar/shared/cubit/states.dart';

class UserScreen extends StatelessWidget {
   UserScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopGetUserDataSuccessState ){}
      },
      builder:(context,state){

        var cubit = ShopCubit.get(context);
        nameController.text= cubit.userModel!.data!.name!;
        phoneController.text= cubit.userModel!.data!.phone!;
        emailController.text= cubit.userModel!.data!.email!;
        return ConditionalBuilder(
          condition: cubit.userModel!=null,
          fallback: (context)=>const Center(child: CircularProgressIndicator(),),
          builder:(context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopGetUpdateLoadingState)
                      const LinearProgressIndicator(),

                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'Name',
                      prefix: Icons.person,
                      validate: (String value){
                        if(value.isEmpty){
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email',
                      prefix: Icons.email_outlined,
                      validate: (String value){
                        if(value.isEmpty){
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone',
                      prefix: Icons.phone,
                      validate: (String value){
                        if(value.isEmpty){
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: (){
                          if(formKey.currentState!.validate()){
                            cubit.updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text
                            );
                          }
                        },
                        text: 'update',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: (){
                          signOut(context);
                        },
                        text: 'logout',
                    )

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
