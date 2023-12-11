import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/constants/string_constants.dart';
import 'package:order_app/data/entity/basket_cubit_types.dart';
import 'package:order_app/data/entity/basket_model.dart';
import 'package:order_app/ui/bloc/basket_cubit.dart';

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
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: productList.basketModel.length,
                          itemBuilder: (context, index) {
                            var product = productList.basketModel[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 16.0,left: 16.0),
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
                                      padding: const EdgeInsets.only(right: 12, left: 12),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              height: 64,
                                              width: 64,
                                              child: Image.network("${StringConstants.getImage}${product.product_image_name}")),
                                          const SizedBox(width: 10),
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
                          },),
                      ],
                    ),
                  );
                }else{
                  return const Center();
                }
              },),
          ),
          BlocBuilder<BasketCubit,BasketCubitTypes>(
            builder: (context,state) {
              var total = state.totalPrice;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    gradient: LinearGradient(colors: ColorConstants.linearColorLight,begin: AlignmentDirectional.bottomEnd,end: AlignmentDirectional.topStart),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
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
                        padding: const EdgeInsets.only(right: 32,left: 32,bottom: 16),
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
