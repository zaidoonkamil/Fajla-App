import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fajla/core/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/navigation_bar/navigation_bar.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class CompleteShopping extends StatelessWidget {
  const CompleteShopping({super.key, required this.items});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController locationController = TextEditingController();
  static bool isValidationPassed = false;
  final List<Map<String, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit(),
      child: BlocConsumer<UserCubit,UserStates>(
        listener: (context,state){
          if(state is AddOrderSuccessState){
            phoneController.text='';
            locationController.text='';
            showToastSuccess(
              text: "تمت عملية الطلب بنجاح",
              context: context,
            );
            navigateAndFinish(context, BottomNavBar());
          }
        },
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            height: 62,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 84,height: 20,),
                                  Text('انشاء الطلب',style: TextStyle(fontSize: 18),),
                                  SizedBox(width: 4,),
                                  GestureDetector(
                                      onTap: (){
                                        navigateBack(context);
                                      },
                                      child: Icon(Icons.arrow_forward_ios_outlined)),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('الدفع',style: TextStyle(fontSize: 20,color: Colors.grey),),
                              ],
                            ),
                          ),
                          SizedBox(height: 12,),
                          Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: primaryColor.withOpacity(0.2)
                            ),
                            child: Container(
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color(0XFFF0F0F0)
                                ),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: primaryColor
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(': الدفـــــــــــــــــع'),
                                        Text('نقدا عند الاستلام',style: TextStyle(color: Colors.grey),),
                                      ],
                                    ),
                                  ],
                                ),
                            ),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 16,),
                                CustomTextField(
                                  hintText: 'ادخل رقم الهاتف',
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'رجائا ادخل رقم الهاتف';
                                    }
                                  },
                                ),
                                SizedBox(height: 16,),
                                CustomTextField(
                                  hintText: 'ادخل العنوان بالتفصيل',
                                  controller: locationController,
                                  keyboardType: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'رجائا ادخل العنوان بالتفصيل';
                                    }
                                  },
                                ),
                                SizedBox(height: 12,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical:18 ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                if (formKey.currentState!.validate()) {
                                  cubit.addOrder(
                                    context: context,
                                      phone: phoneController.text.trim(),
                                      location: locationController.text.trim(),
                                      products: items,
                                  );
                                }
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ConditionalBuilder(
                                        condition: state is !AddOrderLoadingState,
                                        builder: (c)=>Text('التاكيد',
                                          style: TextStyle(color: Colors.white,fontSize: 16),
                                        ),
                                        fallback: (c)=>CircularProgressIndicator(color: Colors.white,)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
