import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,title: Text("Basket"),),
      body: BlocBuilder<BasketCubit,List<BasketModel>>(
        builder: (context, productList) {
          if(productList.isNotEmpty){
            print("as");
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                var product = productList[index];
                var amount = 0;
                return Card(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05), blurRadius: 1),
                        ],
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.only(right: 12, left: 12),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 64,
                                width: 64,
                                child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${product.product_image_name}")),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.product_name,style: const TextStyle(fontSize: 18,fontFamily: 'SansPro',fontWeight: FontWeight.w500),),
                                const Text("Loovy food",style: TextStyle(fontSize: 14,fontFamily: 'SansPro',color: Colors.black54),),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              "₺${product.product_price}",
                              style: const TextStyle(fontSize: 29,fontFamily: 'SansPro',
                                  fontWeight: FontWeight.w500,color: ColorConstants.priceColor),),
                          ],
                        ),
                      ),
                    ),
                  );/*Card(
                  child:SizedBox(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.product_name,style: const TextStyle(fontSize: 20),),
                              Text(product.product_price),
                              Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${product.product_image_name}"),
                              Text(product.product_order_amount),
                              TextButton(onPressed: () {
                                context.read<BasketCubit>().deleteProduct(int.parse(product.basket_product_id),"hakan_baysal");
                              }, child: Text("Sepetten sil")),

                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                );*/

              },);
          }else{
            print("aisdşasd");
            return Center();
          }

        },),
    );
  }
}
