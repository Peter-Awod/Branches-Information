
import 'package:branches_information/layouts/home_layout.dart';
import 'package:branches_information/shared/components/constants.dart';
import 'package:branches_information/shared/cubit/app_cubit.dart';
import 'package:branches_information/shared/network/local/app_cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../register/register_screen.dart';
import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginErrorState){
           showToast(msg: state.error, status: MsgState.ERROR) ;
          }
          if (state is LoginSuccessState){
           CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
             uId=state.uId;

              // AppCubit.get(context).getCategories();
              AppCubit.get(context).getUserInfo();
             pushAndRemoveNavigateTo(context, HomeLayoutScreen());
           });
          }
        },
        builder: (context, state) {
          return Scaffold(

            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            label: const Text('Email address'),
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                            ),
                          ),
                            validator: (value){
                              if(value!.isEmpty){
                                return '';
                              }
                              else{
                                return null;
                              }
                            },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: LoginCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            label: const Text('Password'),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                LoginCubit.get(context).changeIcon();
                              },
                              icon: Icon(LoginCubit.get(context).suffix),
                            ),
                          ),

                            validator: (value){
                              if(value!.isEmpty){
                                return '';
                              }
                              else{
                                return null;
                              }
                            },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultMaterialButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login'),
                          fallback: (context) => LinearProgressIndicator(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text('Don\'t have an account?'),
                            defaultTextButton(
                              function: () {
                                return Navigator.push(
                                    context ,
                                    MaterialPageRoute(builder: (context)=>RegisterScreen()));
                              },
                              text: 'Register now',
                              textColor: Colors.black54,
                            ),
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
      ),
    );
  }
}
