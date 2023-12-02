import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/ui/bloc/home_cubit.dart';
import 'package:order_app/ui/views/basket.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var tf = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Basket()));
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Food & Drinks",
          style: TextStyle(fontSize: 26, fontFamily: 'SansPro', fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 316,
                  height: 50,
                  child: TextField(
                    controller: tf,
                    onChanged: (value) {
                      context.read<HomeCubit>().search();
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF4F6F9),
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      suffixIcon: Icon(Icons.search),
                      hintText: "Search",
                      hintStyle: TextStyle(color: Color(0xFF09101D), fontSize: 18, fontFamily: 'SansPro'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(37),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF4F6F9)),
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF43F5E).withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  width: 50,
                  height: 50,
                  child: Icon(Icons.filter_list_outlined, color: Color(0xFFF43F5E)),
                ),
              ],
            ),
            BlocBuilder<HomeCubit, List<ProductModel>>(
              builder: (context, productList) {
                if (productList.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      var product = productList[index];
                      var amount = 0;
                      return Padding(
                        padding: const EdgeInsets.only(right: 24,left: 24),
                        child: SizedBox(
                          height: 88,
                          child: Card(
                            child:  Padding(
                              padding: const EdgeInsets.only(right: 12, left: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 64,
                                    width: 64,
                                    child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${product.product_image}"),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(product.product_name,style: TextStyle(fontSize: 18,fontFamily: 'SansPro',fontWeight: FontWeight.w500),),
                                      Text("Loovy food",style: TextStyle(fontSize: 14,fontFamily: 'SansPro',color: Colors.black54),),
                                    ],
                                  ),
                                  Text("₺ ${product.product_price}",style: TextStyle(fontSize: 29,fontFamily: 'SansPro',fontWeight: FontWeight.w500,color: ColorConstants.priceColor),),

                                ],
                              ),
                            ),
                          ),
                        ),
                      );


                      /* Card(
                        child: SizedBox(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.product_name, style: const TextStyle(fontSize: 20)),
                                    Text(product.product_price),
                                    Image.network(
                                        "http://kasimadalan.pe.hu/yemekler/resimler/${product.product_image}"),
                                    TextButton(
                                      onPressed: () {
                                        amount++;
                                        context.read<HomeCubit>().addToBasket(
                                            product.product_name,
                                            product.product_image,
                                            product.product_price,
                                            amount.toString(),
                                            "hakan_baysal");
                                      },
                                      child: Text("Sepete ekle"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );*/
                    },
                  );
                } else {
                  return Center(
                    child: Text("No results found."),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
