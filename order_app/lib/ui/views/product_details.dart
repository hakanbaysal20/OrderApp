import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/data/entity/list_type.dart';
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
  void initState() {
    super.initState();
    context.read<ProductDetailsCubit>().decrease(0);
    context.read<ProductDetailsCubit>().increase(0);
    context.read<ProductDetailsCubit>().checkFavourite(widget.product.product_id);
  }

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
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: BlocBuilder<ProductDetailsCubit,ListType>(
                    builder: (context,state) {
                      var checkFavourite = state.checkFavourite;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: () {
                            Navigator.pop(context);
                          }, icon: const Icon(Icons.arrow_back_ios,color: ColorConstants.priceColor,size: 30,)),
                          IconButton(onPressed: () {
                            setState(() {
                            if(checkFavourite == false){
                              context.read<ProductDetailsCubit>().saveFavourite(widget.product.product_name, widget.product.product_image, widget.product.product_id);
                              Navigator.pop(context);
                            }else{
                              context.read<ProductDetailsCubit>().deleteFavourite(widget.product.product_id);
                              Navigator.pop(context);
                            }
                            });
                          }, icon:const Icon(Icons.favorite),color: checkFavourite ? ColorConstants.priceColor :  ColorConstants.grey),
                        ],
                      );
                    }
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
                  child: BlocBuilder<ProductDetailsCubit,ListType>(
                    builder: (context,state) {
                      var value = state.productAmount;

                      return Row(
                      children: [
                        IconButton(onPressed: () {

                            context.read<ProductDetailsCubit>().decrease(value);

                        }, icon:  Icon(CupertinoIcons.minus_square_fill,color: const Color(0xFFF43F5E).withOpacity(0.4),)),
                        Text(value.toString(),textAlign: TextAlign.center,style: const TextStyle(fontFamily: 'SansPro',color: Colors.grey)),
                        IconButton(onPressed: () {
                            context.read<ProductDetailsCubit>().increase(value);

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
            child: BlocBuilder<ProductDetailsCubit,ListType>(
              builder: (context,number) {
                var num = number.productAmount;

                var total = int.parse(widget.product.product_price) * num;
                var product= widget.product;
                return GestureDetector(
                  onTap: () {
                    context.read<ProductDetailsCubit>().addToBasket(product.product_name, product.product_image, product.product_price, num.toString());
                    Navigator.pop(context);
                    num = 1;
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(color: ColorConstants.priceColor,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(37),bottomRight: Radius.circular(37))),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16,left: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("$num items",style: const TextStyle(color: ColorConstants.white,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: 'SansPro')),
                              Text("₺ $total",style: const TextStyle(color: ColorConstants.white,fontSize: 24,fontFamily: 'SansPro',fontWeight: FontWeight.w500)),

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
