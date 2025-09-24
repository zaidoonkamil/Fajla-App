import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fajla/core/%20navigation/navigation.dart';
import 'package:fajla/core/widgets/show_toast.dart';
import 'package:fajla/features/user/view/chat.dart';
import 'package:fajla/features/user/view/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/styles/themes.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/circular_progress.dart';
import '../../../core/widgets/constant.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit()
        ..getProfile(context: context),
      child: BlocConsumer<UserCubit,UserStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: ConditionalBuilder(
                  condition: true,
                  builder: (context)=>SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        CustomAppBar(),
                        SizedBox(height: 18,),
                        cubit.profileModel != null? Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
                              width: 1.0,
                            ),
                              borderRadius: BorderRadius.circular(12),
                              color: containerColor,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                               //   Image.asset('assets/images/Frame 758531381.png'),
                               //    SizedBox(width: 12,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(cubit.profileModel!.name),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(cubit.profileModel!.phone,style: TextStyle(color: Colors.grey),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12,),
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(6.0),
                                      child: Image.asset(
                                        'assets/images/Frame 758531368.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ):CircularProgress(),
                        SizedBox(height: 16,),
                        GestureDetector(
                          onTap: () async {
                            final url =
                                'https://wa.me/+9647712442505?text=';
                            await launch(
                              url,
                              enableJavaScript: true,
                            ).catchError((e) {
                              showToastError(
                                text: e.toString(),
                                context: context,
                              );
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: containerColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('إتصل بنا',style: TextStyle(fontSize: 14),),
                                SizedBox(width: 12,),
                                Image.asset('assets/images/Icon.png'),

                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final url =
                             'https://www.facebook.com/profile.php?id=61560846641307';
                            await launch(
                              url,
                              enableJavaScript: true,
                            ).catchError((e) {
                              showToastError(
                                text: e.toString(),
                                context: context,
                              );
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: containerColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('فيسبوك',style: TextStyle(fontSize: 14),),
                                SizedBox(width: 12,),
                                Image.asset('assets/images/Icon (1).png'),

                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final url =
                                'https://www.instagram.com/napol_tg/';
                            await launch(
                              url,
                              enableJavaScript: true,
                            ).catchError((e) {
                              showToastError(
                                text: e.toString(),
                                context: context,
                              );
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: containerColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('انستجرام',style: TextStyle(fontSize: 14),),
                                SizedBox(width: 12,),
                                Image.asset('assets/images/Icon (2).png'),

                              ],
                            ),
                          ),
                        ),
                        adminOrUser == 'user'?Column(
                          children: [
                            GestureDetector(
                              onTap: ()  {
                                navigateTo(context, Favorites());
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: borderColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color: containerColor
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('المفضلة',style: TextStyle(fontSize: 14),),
                                    SizedBox(width: 12,),
                                    Image.asset('assets/images/Icon (6).png'),

                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: ()  {
                                navigateTo(context, Chat(userId: int.parse(id)));
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: borderColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color: containerColor
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('دردش معنا',style: TextStyle(fontSize: 14),),
                                    SizedBox(width: 12,),
                                    Image.asset('assets/images/Icon (3).png'),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ):Container(),
                        GestureDetector(
                          onTap: () async {
                           signOut(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: containerColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('تسجيل الخروج',style: TextStyle(fontSize: 14),),
                                SizedBox(width: 12,),
                                Image.asset('assets/images/Icon (4).png'),

                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            showToastInfo(text: 'تم تقديم طلب حذف الحساب', context: context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: containerColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('حذف الحساب',style: TextStyle(fontSize: 14),),
                                SizedBox(width: 12,),
                                Image.asset('assets/images/Icon (5).png'),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  fallback: (context){
                    return Column(
                      children: [
                        Container(
                          height: 62,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Image.asset('assets/images/shopping-cart-02.png',
                                    height: 34,
                                    width: 34,
                                  ),
                                ),
                                Image.asset('assets/images/Logo.png',
                                  height: 34,
                                  width: 34,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgress(),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
              ),
            ),
          );
        },
      ),
    );
  }
}
