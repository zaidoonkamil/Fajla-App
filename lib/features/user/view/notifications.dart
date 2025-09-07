import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/styles/themes.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class NotificationsUser extends StatelessWidget {
  const NotificationsUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit()..getNotifications(context: context),
      child: BlocConsumer<UserCubit,UserStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=UserCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/notif.png'),
                        const Text(
                          textAlign: TextAlign.right,
                          'الاشعارات',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                            onTap: (){
                              navigateBack(context);
                            },
                            child: Icon(Icons.keyboard_arrow_right_outlined,size: 32,)),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Expanded(
                        child: ConditionalBuilder(
                            condition: state is! GetNotificationsLoadingState,
                            builder: (c){
                              return ConditionalBuilder(
                                  condition: cubit.getNotificationsModel!.logs.isNotEmpty,
                                  builder: (c){
                                    return ListView.builder(
                                        itemCount: cubit.getNotificationsModel!.logs.length,
                                        itemBuilder: (context,index){
                                          DateTime dateTime = DateTime.parse(cubit.getNotificationsModel!.logs[index].createdAt.toString());
                                          String formattedDate = DateFormat('yyyy/M/d').format(dateTime);
                                          return Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: borderColor,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(12),
                                                    color: containerColor
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            cubit.getNotificationsModel!.logs[index].title,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black87,
                                                            ),
                                                            textAlign: TextAlign.end,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            cubit.getNotificationsModel!.logs[index].message,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black54,
                                                            ),
                                                            textAlign: TextAlign.end,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 6,),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            formattedDate,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold,
                                                              color: primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 12,),
                                            ],
                                          );
                                        });
                                  },
                                  fallback: (c)=>Center(child: Text('لا يوجد بيانات ليتم عرضها')));
                            },
                            fallback: (c)=>Center(child: CircularProgressIndicator()))
                    )
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
