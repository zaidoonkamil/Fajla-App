import 'package:fajla/features/admin/view/details/add_admin.dart';
import 'package:fajla/features/admin/view/details/add_user.dart';
import 'package:fajla/features/admin/view/details/all_user_chat_admin.dart';
import 'package:fajla/features/admin/view/details/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ navigation/navigation.dart';
import '../../../../core/styles/themes.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import 'add_agent.dart';
import 'all_agent.dart';
import 'all_person.dart';


class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) =>
          AdminCubit(),
      child: BlocConsumer<AdminCubit,AdminStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = AdminCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  CustomAppBar(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                        navigateTo(context, AddUser());
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('اضافة مستخدم',
                                            style: TextStyle(color: Colors.white,fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: (){
                                        navigateTo(context, AddAgent());
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('اضافة تاجر',
                                            style: TextStyle(color: Colors.white,fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: (){
                                        navigateTo(context, AddAdmin());
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('اضافة ادمن',
                                            style: TextStyle(color: Colors.white,fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: (){
                                        navigateTo(context, AllPerson());
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('رؤية المستخدمين',
                                            style: TextStyle(color: Colors.white,fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: (){
                                       navigateTo(context, AllAgent());
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('رؤية التجار',
                                            style: TextStyle(color: Colors.white,fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: (){
                                       navigateTo(context, AllUserChatAdmin());
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('الدردشات',
                                            style: TextStyle(color: Colors.white,fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: (){
                                       navigateTo(context, Stats());
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('الاحصائيات',
                                            style: TextStyle(color: Colors.white,fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),),
          );
        },
      ),
    );
  }
}
