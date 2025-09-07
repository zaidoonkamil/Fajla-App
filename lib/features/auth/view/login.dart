import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fajla/core/widgets/show_toast.dart';
import 'package:fajla/features/auth/view/loginCode.dart';
import 'package:fajla/features/auth/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/navigation_bar/navigation_bar.dart';
import '../../../core/navigation_bar/navigation_bar_Admin.dart';
import '../../../core/navigation_bar/navigation_bar_agent.dart';
import '../../../core/network/local/cache_helper.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/constant.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static bool isValidationPassed = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            if(LoginCubit.get(context).isVerified == true){
            CacheHelper.saveData(
              key: 'token',
              value: LoginCubit.get(context).token,
            ).then((value) {
              CacheHelper.saveData(
                key: 'id',
                value: LoginCubit.get(context).id,
              ).then((value) {
                CacheHelper.saveData(
                  key: 'role',
                  value: LoginCubit.get(context).role,
                ).then((value) {
                  token = LoginCubit.get(context).token.toString();
                  id = LoginCubit.get(context).id.toString();
                  adminOrUser = LoginCubit.get(context).role.toString();
                  if (adminOrUser == 'admin') {
                     navigateAndFinish(context, BottomNavBarAdmin());
                     LoginCubit.get(context).registerDevice(LoginCubit.get(context).id.toString());
                  } else if(adminOrUser == 'agent'){
                     navigateAndFinish(context, BottomNavBarAgent());
                     LoginCubit.get(context).registerDevice(LoginCubit.get(context).id.toString());
                  } else{
                    LoginCubit.get(context).registerDevice(LoginCubit.get(context).id.toString());
                    navigateAndFinish(context, BottomNavBar());
                  }

                });
              });
            });
            }else if(LoginCubit.get(context).isVerified == false){
              navigateTo(context, LoginCode(phone: LoginCubit.get(context).phonee!));
            }else{
              showToastError(text: 'حدث خطأ', context: context);
            }
          }
        },
          builder: (context,state){
          var cubit=LoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 60,),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 2000),
                          curve: Curves.easeOutBack,
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: child,
                            );
                          },
                          child: Image.asset('assets/images/logo.jpeg',width: 200,height: 200,),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          hintText: 'رقم الهاتف',
                          controller: userNameController,
                          keyboardType: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اخل رقم الهاتف';
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hintText: 'كلمة السر',
                          controller: passwordController,
                          obscureText: cubit.isPasswordHidden,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              cubit.togglePasswordVisibility();
                            },
                            child: Icon(
                              cubit.isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اخل الرمز السري';
                            }
                          },
                        ),
                        const SizedBox(height: 60),
                        ConditionalBuilder(
                          condition: state is !LoginLoadingState,
                            builder: (c){
                              return GestureDetector(
                                onTap: (){
                                  if (formKey.currentState!.validate()) {
                                    cubit.signIn(
                                        phone: userNameController.text.trim(),
                                        password: passwordController.text.trim(),
                                        context: context
                                    );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      borderRadius:  BorderRadius.circular(12),
                                      color: primaryColor
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('تسجيل الدخول',
                                        style: TextStyle(color: Colors.white,fontSize: 16 ),),
                                    ],
                                  ),
                                ),
                              );
                            },
                          fallback: (c)=> CircularProgressIndicator(color: primaryColor,),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateTo(context, Register());
                              },
                              child: const Text(
                                'انشاء حساب ',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text("لا تمتلك حساب ؟ ",style: TextStyle(color: secondTextColor),),
                          ],
                        )
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
