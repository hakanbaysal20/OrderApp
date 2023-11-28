
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/ui/bloc/home_cubit.dart';
import 'package:order_app/ui/views/basket.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Basket(),));
      },),
      appBar: AppBar(title: Text("Products"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<HomeCubit,List<ProductModel>>(
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
                                 Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${product.product_image}"),
                                 TextButton(onPressed: () {
                                   amount++;
                                   context.read<HomeCubit>().addToBasket(product.product_name, product.product_image, product.product_price, amount.toString(), "hakan_baysal");
                                 }, child: Text("Sepete ekle")),
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
          ],
        ),
      ),
    );
  }
}
