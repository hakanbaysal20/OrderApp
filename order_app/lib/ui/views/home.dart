import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/ui/bloc/home_cubit.dart';
import 'package:order_app/ui/views/basket.dart';
import 'package:order_app/ui/views/product_details.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
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
                      fillColor: const Color(0xFFF4F6F9),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      suffixIcon: const Icon(Icons.search),
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Color(0xFF09101D), fontSize: 18, fontFamily: 'SansPro'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(37),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFF4F6F9)),
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF43F5E).withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  width: 50,
                  height: 50,
                  child: const Icon(Icons.filter_list_outlined, color: Color(0xFFF43F5E)),
                ),
              ],
            ),
            BlocBuilder<HomeCubit, List<ProductModel>>(
              builder: (context, productList) {
                if (productList.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      var product = productList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 24,left: 24,bottom: 12,top: 12),
                        child: SizedBox(
                          height: 88,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(product: product),));
                            },
                            child: Card(
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
                                          child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${product.product_image}")),
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
                            ),
                          ),
                        ),
                      );

                    },
                  );
                } else {
                  return const Center(
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
