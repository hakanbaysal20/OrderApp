import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/ui/bloc/product_details_cubit.dart';

class ProductDetails extends StatefulWidget {
  ProductModel product;

  ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //rectangle
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(color: ColorConstants.blackLight,blurRadius: 1,offset: Offset(1, 2)),
              ],
              color: ColorConstants.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(37),
                bottomRight: Radius.circular(37),
                ),
            ),
            child: Column(
              children: [
                 Padding(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {
                        Navigator.pop(context);
                      }, icon: Icon(Icons.arrow_back_ios,color: ColorConstants.priceColor,size: 30,)),
                      Icon(Icons.favorite,color: ColorConstants.grey),
                    ],
                  ),
                ),
                Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.product.product_image}"),
              ],
            ),
          ),
          // bottom widgets
          Padding(
            padding: const EdgeInsets.only(right: 32,left: 32,top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.product_name,style: const TextStyle(fontFamily: 'SansPro',fontSize: 24,color: ColorConstants.grey),),
                SizedBox(
                  child: BlocBuilder<ProductDetailsCubit,int>(
                    builder: (context,state) {
                      return Row(
                      children: [
                        IconButton(onPressed: () {
                          setState(() {
                            context.read<ProductDetailsCubit>().decrease(state);

                          });
                        }, icon: const Icon(CupertinoIcons.minus_square_fill,color: ColorConstants.grey,)),
                        Container(
                          width: 50,
                          color: const Color(0xFFC4C4C4).withOpacity(0.6),
                          child: Text(state.toString(),textAlign: TextAlign.center,style: const TextStyle(fontFamily: 'SansPro',color: Colors.grey)),
                        ),
                        IconButton(onPressed: () {
                          setState(() {
                            context.read<ProductDetailsCubit>().increase(state);

                          });
                        }, icon: const Icon(CupertinoIcons.plus_square_fill,color: Colors.red,)),
                       ],
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
          Text("₺ ${widget.product.product_price}",textAlign: TextAlign.start,style: const TextStyle(color: ColorConstants.priceColor,fontSize: 24),),
          Padding(
            padding: const EdgeInsets.only(right: 16,left: 16),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 45,
                  decoration: BoxDecoration(border: Border.all(color: ColorConstants.blackLight,width: 2),borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: const Icon(Icons.location_on,color: ColorConstants.priceColor,),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Location",style: TextStyle(fontFamily: 'SansPro',fontSize: 18,color: ColorConstants.black.withOpacity(0.7))),
                    Text("Charbhuja Chawk , Makrana",style: TextStyle(fontFamily: 'SansPro',fontSize: 14,color: ColorConstants.black.withOpacity(0.6)),),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16,left: 16),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 45,
                  decoration: BoxDecoration(border: Border.all(color: ColorConstants.blackLight,width: 2),borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: const Icon(Icons.watch_later,color: ColorConstants.priceColor,),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivery Time",style: TextStyle(fontFamily: 'SansPro',fontSize: 18,color: ColorConstants.black.withOpacity(0.7))),
                    Text("30 Times",style: TextStyle(fontFamily: 'SansPro',fontSize: 14,color: ColorConstants.black.withOpacity(0.6)),),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16,left: 16),
            child: BlocBuilder<ProductDetailsCubit,int>(
              builder: (context,number) {
                var total = int.parse(widget.product.product_price) * number;
                var product= widget.product;
                return GestureDetector(
                  onTap: () {
                    context.read<ProductDetailsCubit>().addToBasket(product.product_name, product.product_image, product.product_price, number.toString(), "hakan_baysal");
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: ColorConstants.priceColor,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(37),bottomRight: Radius.circular(37))),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16,left: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("$number items",style: TextStyle(color: ColorConstants.white,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: 'SansPro')),
                              Text("₺ $total",style: TextStyle(color: ColorConstants.white,fontSize: 24,fontFamily: 'SansPro',fontWeight: FontWeight.w500)),

                                  ],
                                ),
                            const Text("Add to Card",style: TextStyle(color: ColorConstants.white,fontFamily: 'SansPro',fontWeight: FontWeight.w500,fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                );
              }
            ),
            ),
        ],
      ),


    );
  }
}