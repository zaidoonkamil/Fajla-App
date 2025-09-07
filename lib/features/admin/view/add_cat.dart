import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fajla/core/navigation_bar/navigation_bar_Admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ navigation/navigation.dart';
import '../../../../core/styles/themes.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/show_toast.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class AddCat extends StatelessWidget {
  const AddCat({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController tittleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AdminCubit(),
      child: BlocConsumer<AdminCubit,AdminStates>(
        listener: (context,state){
          if(state is AddCategoriesSuccessState){
            AdminCubit.get(context).selectedImagesCat=[];
            tittleController.text='';
            showToastSuccess(
              text: "تمت العملية بنجاح",
              context: context,
            );
            navigateAndFinish(context, BottomNavBarAdmin());
          }
        },
        builder: (context,state){
          var cubit=AdminCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body:SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: (){
                                      navigateBack(context);
                                    },
                                    child: Icon(Icons.arrow_back_ios_new)),
                                const Text(
                                  textAlign: TextAlign.right,
                                  'انشاء قسم',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),
                            GestureDetector(
                                onTap:(){
                                  cubit.pickImagesCat();
                                },
                                child:
                                cubit.selectedImagesCat.isEmpty?
                                Image.asset('assets/images/Group 1171275632 (1).png'):Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipOval(
                                    child: Image.file(
                                      File(cubit.selectedImagesCat[0].path),
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: tittleController,
                              hintText: 'العنوان',
                              prefixIcon: Icons.title,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'رجائا اخل العنوان';
                                }
                              },
                            ),
                            const SizedBox(height: 60),
                            ConditionalBuilder(
                              condition: state is !AddCategoriesLoadingState,
                              builder: (context){
                                return GestureDetector(
                                  onTap: (){
                                    if (formKey.currentState!.validate()) {
                                      cubit.addCat(
                                        tittle: tittleController.text.trim(),
                                        context: context,
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 48,
                                    decoration: BoxDecoration(
                                        borderRadius:  BorderRadius.circular(12),
                                        color: primaryColor,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.5,
                                        )
                                    ),
                                    child: Center(
                                      child: Text('انشاء قسم جديد',
                                        style: TextStyle(color: Colors.white,fontSize: 18 ),),
                                    ),
                                  ),
                                );
                              },
                              fallback: (c)=> CircularProgressIndicator(color: primaryColor,),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
