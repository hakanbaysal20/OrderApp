
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/ui/bloc/home_cubit.dart';

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
