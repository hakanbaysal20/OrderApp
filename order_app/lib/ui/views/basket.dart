import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

                  /* ListTile(
                      subtitle: Text(kisi.kisi_tel),
                      title: Text(kisi.kisi_adi),
                      trailing: Icon(Icons.close),

                    ),*/
                );

              },);
          }else{
            print("aisdşasd");
            return Center();
          }

        },),
    );
  }
}
