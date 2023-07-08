import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/layout/shop_layout.dart';
import 'package:matgar/modules/login/cubit/cubit.dart';
import 'package:matgar/modules/register/register_screen.dart';
import 'package:matgar/shared/components/components.dart';
import 'package:matgar/shared/components/constants.dart';
import 'package:matgar/shared/network/local/cache_helper.dart';

import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status!){
              // print(state.loginModel.data?.token);
              CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) {
                token=state.loginModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
              showToast(text: state.loginModel.message!, state: ToastStates.success);
            }else{
              // print(state.loginModel.message);

              showToast(text: state.loginModel.message!, state: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          var loginCubit= ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'login now to browse our hot offers ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                            },
                            onSubmit: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock_outlined,
                          suffix: Icons.visibility_outlined,
                          suffixPressed:(){
                            loginCubit.changePasswordVisibility();
                          } ,
                          isPassword: loginCubit.isPassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            }
                          },
                          onSubmit: (value){
                            if (formKey.currentState!.validate()) {
                              loginCubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          }
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  loginCubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'Login'),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              'you don\'t have an account ? ',
                            ),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context,  RegisterScreen());
                                },
                                text: 'Register Now '),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
  }
}
