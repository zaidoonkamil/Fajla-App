import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fajla/core/network/remote/dio_helper.dart';
import 'package:fajla/core/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/styles/themes.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Details extends StatelessWidget {
  const Details({super.key,
    required this.id,
    required this.sellerId,
    required this.tittle,
    required this.description,
    required this.price,
    required this.images,
    required this.imageSeller,
    required this.locationSeller,
    required this.nameSeller,
    required this.isFavorite,
    });

  static CarouselController carouselController = CarouselController();

  static int currentIndex = 0;
  final String sellerId;
  final String id;
  final String tittle;
  final String description;
  final String price;
  final String imageSeller;
  final String nameSeller;
  final String locationSeller;
  final bool isFavorite;
  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      UserCubit()..isLiked=isFavorite..getProductsDetails(context: context, sellerId: sellerId),
      child: BlocConsumer<UserCubit, UserStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit=UserCubit.get(context);
            int number = int.parse(price);
            return SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    Column(
                        children: [
                          SizedBox(height: 20,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(width: 28,),
                                const Text(
                                  textAlign: TextAlign.right,
                                  'تفاصيل المنتج',
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
                          ),
                          SizedBox(height: 12,),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  Container(
                                    height: 373,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(borderRadius:
                                    BorderRadius.circular(16)),
                                    child: Stack(
                                      children: [
                                        CarouselSlider(
                                          items:images!.map((entry) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return SizedBox(
                                                  width: double.maxFinite,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(16.0),
                                                    child: Image.network(
                                                      "$url/uploads/$entry",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }).toList(),
                                          options: CarouselOptions(
                                            height: 343,
                                            viewportFraction: 0.94,
                                            enlargeCenterPage: true,
                                            initialPage: 0,
                                            enableInfiniteScroll: true,
                                            reverse: true,
                                            autoPlay: true,
                                            autoPlayInterval: const Duration(seconds: 6),
                                            autoPlayAnimationDuration:
                                            const Duration(seconds: 1),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            scrollDirection: Axis.horizontal,
                                            onPageChanged: (index, reason) {
                                              currentIndex=index;
                                              cubit.slid();

                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 16),
                                          width: double.maxFinite,
                                          height: double.maxFinite,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: images!.asMap().entries.map((entry) {
                                              return GestureDetector(
                                                onTap: () {
                                                  carouselController.animateTo(
                                                    entry.key.toDouble(),
                                                    duration: Duration(milliseconds: 500),
                                                    curve: Curves.easeInOut,
                                                  );
                                                },
                                                child: Container(
                                                  width: currentIndex == entry.key ? 8 : 8,
                                                  height: 7.0,
                                                  margin: const EdgeInsets.symmetric(
                                                    horizontal: 3.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: currentIndex == entry.key
                                                          ? primaryColor
                                                          : Colors.white),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                tittle,
                                                style: TextStyle( height: 0.6,fontSize: 20, color: Colors.black87),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    cubit.minus(context: context);
                                                  },
                                                  child:Image.asset('assets/images/Group 17839.png'),
                                                ),
                                                SizedBox(width: 8,),
                                                Text(cubit.quantity.toString(),style: TextStyle(fontSize: 20),),
                                                SizedBox(width: 8,),
                                                GestureDetector(
                                                  onTap: (){
                                                    cubit.add();
                                                  },
                                                  child: Image.asset('assets/images/Group 33998.png'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('د.ع',style: TextStyle(fontSize: 20,color: primaryColor),),
                                                Text(NumberFormat('#,###').format(number).toString(),style: TextStyle(fontSize: 20,color: primaryColor),),
                                              ],
                                            ),

                                          ],
                                        ),
                                        adminOrUser == 'user'? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                          Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              cubit.isLiked ? Icons.favorite : Icons.favorite_border,
                                              color: cubit.isLiked ? Colors.red : Colors.grey[700],
                                            ),
                                            onPressed: (){
                                              cubit.updateFavoritesDetails(idItem: id, context: context);
                                            },
                                          ),

                                          ),
                                            Row(
                                              children: [
                                                Text(': المفضلة',style: TextStyle(fontSize: 20,color: primaryColor),),
                                              ],
                                            ),

                                          ],
                                        ):Container(),
                                        SizedBox(height: 12,),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                          decoration: BoxDecoration(
                                            color: Color(0XFFEBF9F1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(nameSeller,style: TextStyle(fontSize: 13),),
                                                  Text(locationSeller,style: TextStyle(fontSize: 13,color: Colors.grey),),

                                                ],
                                              ),
                                              SizedBox(width: 4,),
                                              ClipOval(
                                                child: Image.network(
                                                  "$url/uploads/$imageSeller",
                                                  width: 40,
                                                  height: 40,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            ],
                                          )

                                        ),
                                        SizedBox(height: 12,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(':وصف المنتج',
                                              style: TextStyle(fontSize: 12,color: Colors.grey),
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Text(description,
                                                style: TextStyle(fontSize: 14,color: Colors.grey),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  cubit.getProductsDetailsModel != null? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(': منتجات من المتجر',style: TextStyle(fontSize: 20,color: primaryColor),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      SizedBox(
                                        height: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: ListView.builder(
                                              physics: AlwaysScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              reverse: true,
                                              itemCount: cubit.getProductsDetailsModel!.productsDetails.length,
                                              itemBuilder: (c,i){
                                                return GestureDetector(
                                                  onTap: () {
                                                    navigateTo(context, Details(
                                                      sellerId: cubit.getProductsDetailsModel!.productsDetails[i].seller.id.toString(),
                                                      id: cubit.getProductsDetailsModel!.productsDetails[i].id.toString(),
                                                      tittle: cubit.getProductsDetailsModel!.productsDetails[i].title.toString(),
                                                      description: cubit.getProductsDetailsModel!.productsDetails[i].description.toString(),
                                                      price: cubit.getProductsDetailsModel!.productsDetails[i].price.toString(),
                                                      images: cubit.getProductsDetailsModel!.productsDetails[i].images,
                                                      isFavorite: cubit.getProductsDetailsModel!.productsDetails[i].seller.isVerified,
                                                      imageSeller:  cubit.getProductsDetailsModel!.productsDetails[i].seller.image,
                                                      nameSeller: cubit.getProductsDetailsModel!.productsDetails[i].seller.name,
                                                      locationSeller: cubit.getProductsDetailsModel!.productsDetails[i].seller.location,

                                                    ));
                                                  },
                                                  child: Container(
                                                    width: 160,
                                                    height: 250,
                                                    margin: const EdgeInsets.symmetric(horizontal: 2,vertical: 4),
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: borderColor,
                                                        width: 1.0,
                                                      ),
                                                      color: containerColor,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(6),
                                                          child: Image.network(
                                                            '$url/uploads/${cubit.getProductsDetailsModel!.productsDetails[i].images[0]}',
                                                            width: double.maxFinite,
                                                            height: 143,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  SizedBox(width: 5,),
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                      children: [
                                                                        Text(
                                                                          cubit.getProductsDetailsModel!.productsDetails[i].title,
                                                                          style: TextStyle(fontSize: 14),
                                                                          textAlign: TextAlign.end,
                                                                          maxLines: 2,
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                        SizedBox(height: 6,),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          children: [
                                                                            Text(
                                                                              'د.ع',
                                                                              maxLines: 1,
                                                                              style: TextStyle(color: secondPrimaryColor,fontSize: 13),
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.end,
                                                                            ),
                                                                            Text(
                                                                              NumberFormat('#,###').format(cubit.getProductsDetailsModel!.productsDetails[i].price).toString(),
                                                                              maxLines: 1,
                                                                              style: TextStyle(color: secondPrimaryColor,fontSize: 13),
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.end,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ):CircularProgressIndicator(color: primaryColor,),
                                  SizedBox(height: 120,),
                                ],
                              ),
                            ),
                          ),
                        ]
                    ),
                    adminOrUser == 'user'? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical:16 ),
                          child: GestureDetector(
                            onTap: (){
                              cubit.addToBasket(
                                productId: id,
                                quantity: cubit.quantity.toString(),
                                context: context,
                              );
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
                                  Text('أضف للسلة',
                                    style: TextStyle(color: Colors.white,fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ):Container(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
