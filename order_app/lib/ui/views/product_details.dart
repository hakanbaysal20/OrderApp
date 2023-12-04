import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/ui/bloc/product_details_cubit.dart';

class ProductDetails extends StatefulWidget {
  ProductModel product;

  ProductDetails({required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var amountController = TextEditingController();
  var number = 0;

  @override
  void initState() {
    super.initState();
    number = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.product_name,
          style: TextStyle(fontSize: 26, fontFamily: 'SansPro', fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 300,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black12,blurRadius: 1,offset: Offset(1, 2)),
                ],
                color: ColorConstants.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(37),
                  bottomRight: Radius.circular(37),
                  ),
              ),
              child: Column(
                children: [
                  Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.product.product_image}"),
                  const Padding(
                    padding: EdgeInsets.only(right: 32.0,bottom: 20.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                        child: Icon(Icons.favorite,color: Colors.grey,),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32,left: 32,top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.product_name,style: TextStyle(fontFamily: 'SansPro',fontSize: 24,color: Colors.grey),),
                SizedBox(
                  child: Row(
                  children: [
                    IconButton(onPressed: () {
                      context.read<ProductDetailsCubit>().decrease(number);
                    }, icon: Icon(CupertinoIcons.minus_square_fill,color: Colors.grey,)),
                    Container(
                      width: 50,
                      color: Color(0xFFC4C4C4).withOpacity(0.6),
                      child: BlocBuilder<ProductDetailsCubit,int>(
                        builder: (context, state) {
                        return Text(state.toString(),textAlign: TextAlign.center,style: TextStyle(fontFamily: 'SansPro',color: Colors.grey));
                        },
                      ),
                    ),
                    IconButton(onPressed: () {
                      context.read<ProductDetailsCubit>().increase(number);
                    }, icon: Icon(CupertinoIcons.plus_square_fill,color: Colors.red,)),
                   ],
                  ),
                ),
              ],
            ),
          ),
          Text("₺ ${widget.product.product_price}",textAlign: TextAlign.start,style: TextStyle(color: ColorConstants.priceColor,fontSize: 24),),
          Padding(
            padding: const EdgeInsets.only(right: 32.0,left: 32.0),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 45,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black12,width: 2),borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Icon(Icons.location_on,color: ColorConstants.priceColor,),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Location",style: TextStyle(fontFamily: 'SansPro',fontSize: 18,color: Colors.black.withOpacity(0.7))),
                    Text("Charbhuja Chawk , Makrana",style: TextStyle(fontFamily: 'SansPro',fontSize: 14,color: Colors.black.withOpacity(0.6)),),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32.0,left: 32.0),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 45,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black12,width: 2),borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Icon(Icons.watch_later,color: ColorConstants.priceColor,),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivery Time",style: TextStyle(fontFamily: 'SansPro',fontSize: 18,color: Colors.black.withOpacity(0.7))),
                    Text("30 Times",style: TextStyle(fontFamily: 'SansPro',fontSize: 14,color: Colors.black.withOpacity(0.6)),),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16,left: 16),
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
                        Text("2 items",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: 'SansPro')),
                        Text("₺ ${widget.product.product_price}",style: TextStyle(color: Colors.white,fontSize: 24,fontFamily: 'SansPro',fontWeight: FontWeight.w500)),

                      ],
                    ),
                    Text("Add to Card",style: TextStyle(color: Colors.white,fontFamily: 'SansPro',fontWeight: FontWeight.w500,fontSize: 16)),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),


    );
  }
}
