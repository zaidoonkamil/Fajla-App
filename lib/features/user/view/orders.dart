import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/styles/themes.dart';
import '../../../core/widgets/circular_progress.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';


class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          UserCubit()..getOrdersUser(context: context, page: '1'),
      child: BlocConsumer<UserCubit,UserStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          textAlign: TextAlign.right,
                          'طلباتي',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                    ),
                  ),
                  SizedBox(height: 12,),
                  ConditionalBuilder(
                    condition: state is! GetOrdersUserLoadingState,
                    builder: (context){
                      return ConditionalBuilder(
                        condition: cubit.ordersUser.isNotEmpty,
                        builder: (c){
                          return Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: cubit.ordersUserModel!.orders.length,
                                      itemBuilder:(context,index){
                                        if (index == cubit.ordersUserModel!.orders.length - 1 && !cubit.isLastPageOrdersUser) {
                                          cubit.getOrdersUser(page: (cubit.currentPageOrdersUser + 1).toString(), context: context);
                                        }
                                        DateTime dateTime = DateTime.parse(cubit.ordersUserModel!.orders[index].createdAt.toString());
                                        String formattedDate = DateFormat('yyyy/M/d').format(dateTime);
                                        return Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                          margin: EdgeInsets.symmetric(horizontal: 22,vertical: 4),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: borderColor,
                                                width: 1.0,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                              color: containerColor
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: cubit.ordersUserModel!.orders[index].status == "قيد الانتضار"
                                                          ? Colors.yellow.withOpacity(0.5)
                                                          : cubit.ordersUserModel!.orders[index].status == "مكتمل"
                                                          ? Colors.lightGreenAccent.withOpacity(0.5)
                                                          : cubit.ordersUserModel!.orders[index].status == "قيد التوصيل"
                                                          ? Colors.deepOrange.withOpacity(0.5)
                                                          : Colors.redAccent.withOpacity(0.5),
                                                    ),
                                                    child: RotatedBox(
                                                      quarterTurns: 3,
                                                      child: Text(
                                                        cubit.ordersUserModel!.orders[index].status,
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text('${cubit.ordersUserModel!.orders[index].id}#',
                                                              overflow: TextOverflow.ellipsis,),
                                                            Text(' : طلب رقم',
                                                              overflow: TextOverflow.ellipsis,),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(formattedDate,style: TextStyle(color: secondTextColor,fontSize: 12),),
                                                            SizedBox(width: 4,),
                                                            Text(' : تم الطلب',style: TextStyle(color: secondTextColor,fontSize: 12),),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(cubit.ordersUserModel!.orders[index].totalItems.toString(),style: TextStyle(color: Colors.black,fontSize: 13),),
                                                            SizedBox(width: 4,),
                                                            Text(' : عدد الطلبات',style: TextStyle(color: secondTextColor,fontSize: 13),),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text('د.ع ',style: TextStyle(color: secondPrimaryColor,fontSize: 13),),
                                                            Text(NumberFormat('#,###').format(cubit.ordersUserModel!.orders[index].totalPrice).toString(),style: TextStyle(color: secondPrimaryColor,fontSize: 13),),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 12,),
                                                  Image.asset(
                                                    'assets/images/Group 142.png',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                  SizedBox(height: 20,),
                                ],
                              ),
                            ),
                          );
                        },
                        fallback: (context)=>
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('لا يوجد منتجات ليتم عرضها'),
                                ],
                              ),
                            ),
                      );
                    },
                    fallback: (context)=>
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgress(),
                            ],
                          ),
                        ),
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
