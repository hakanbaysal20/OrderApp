import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/constants/color_constants.dart';
import 'package:order_app/data/constants/string_constants.dart';
import 'package:order_app/data/entity/basket_cubit_types.dart';
import 'package:order_app/ui/cubit/basket_cubit.dart';

class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  State<Basket> createState() => _BasketState();
}
class _BasketState extends State<Basket> {
  @override
  void initState() {
    super.initState();
    context.read<BasketCubit>().getBasket();
    context.read<BasketCubit>().getTotalPrice();
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          StringConstants.basket,
          style: TextStyle(fontSize: 26, fontFamily: StringConstants.primaryFontFamily, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<BasketCubit,BasketCubitTypes>(
              builder: (context, productList) {
                if(productList.basketModel.isNotEmpty){
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: productList.basketModel.length,
                    itemBuilder: (context, index) {
                      var product = productList.basketModel[index];
                      return Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.04,left: screenWidth * 0.04),
                        child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                color: ColorConstants.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: ColorConstants.black.withOpacity(0.05), blurRadius: 1),
                                ],
                              ),
                              child:  Padding(
                                padding: EdgeInsets.only(right: screenWidth * 0.03, left: screenWidth * 0.03),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: screenHeight * 0.15,
                                        width: screenWidth * 0.15,
                                        child: Image.network("${StringConstants.getImage}${product.product_image_name}")),
                                    SizedBox(width: screenWidth * 0.02),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(product.product_name,style: const TextStyle(fontSize: 18,fontFamily: StringConstants.primaryFontFamily,fontWeight: FontWeight.w500),),
                                        Text("${product.product_order_amount} ${StringConstants.amount}",style: const TextStyle(fontSize: 14,fontFamily: StringConstants.primaryFontFamily,color: ColorConstants.black54),),
                                        Text(
                                          "₺${int.parse(product.product_price) * int.parse(product.product_order_amount)}",
                                          style: const TextStyle(fontSize: 18,fontFamily: StringConstants.primaryFontFamily,
                                              fontWeight: FontWeight.w500,color: ColorConstants.priceColor),),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(onPressed: () {
                                      context.read<BasketCubit>().deleteProduct(int.parse(product.basket_product_id));
                                    }, icon: const Icon(Icons.delete),color: ColorConstants.priceColor,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                      );
                    },);
                }else{
                  return const Center();
                }
              },),
          ),
          BlocBuilder<BasketCubit,BasketCubitTypes>(
            builder: (context,state) {
              var total = state.totalPrice;
              return Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    gradient: LinearGradient(colors: ColorConstants.linearColorLight,begin: AlignmentDirectional.bottomEnd,end: AlignmentDirectional.topStart),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(StringConstants.total,style: TextStyle(color: ColorConstants.white,fontFamily: StringConstants.primaryFontFamily,fontSize: 14),),
                            Text("₺$total",style: const TextStyle(fontFamily: StringConstants.primaryFontFamily,color: ColorConstants.white,fontSize: 16),),
                          ],
                        ),
                      ),
                      // TextButton
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.08,left: screenWidth * 0.08,bottom: screenWidth * 0.04),
                        child: SizedBox(
                          height: 50,
                          width: 300,
                          child: TextButton(
                              style: TextButton.styleFrom(backgroundColor: ColorConstants.white,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24)))),
                              onPressed: () {

                              }, child: const Text(StringConstants.placeOrder,style: TextStyle(fontSize: 18,fontFamily: StringConstants.primaryFontFamily,color: ColorConstants.priceColor),)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),

        ],
      ),
    );
  }
}
