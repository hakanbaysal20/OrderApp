import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/data/repo/basket_repo.dart';
import 'package:order_app/data/repo/product_repository.dart';

class HomeCubit extends Cubit<List<ProductModel>>{
  HomeCubit():super(<ProductModel>[]);

  var productRepo = ProductRepository();
  var basketRepo = BasketRepository();
  Future<void> getProducts() async {
    var list = await productRepo.getProduct();
    emit(list);
  }
  Future<void> sortAscByPriceProduct() async {
    var list = await productRepo.sortAscByPriceProduct();
    emit(list);
  }
  Future<void> sortDescByPriceProduct() async {
    var list = await productRepo.sortDescByPriceProduct();
    emit(list);
  }
  Future<void> filterProduct(int max , int min) async{
    var list = await productRepo.filterProduct(max, min);
    emit(list);
  }
  Future<void> sortByWordProduct() async{
    var list = await productRepo.sortByWordProduct();
    emit(list);
  }
  Future<void> getSearch(String searchedWord) async {
    var list = await productRepo.getSearch(searchedWord);
    emit(list);
  }
  Future<void> addToBasket(String product_name,String product_image_name,String product_price, String product_order_amount) async{
    await basketRepo.addToBasket(product_name, product_image_name, product_price, product_order_amount);
  }

}