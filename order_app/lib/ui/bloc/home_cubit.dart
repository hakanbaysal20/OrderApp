import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/data/repo/order_dao_repository.dart';

class HomeCubit extends Cubit<List<ProductModel>>{
  HomeCubit():super(<ProductModel>[]);

  var pRepo = OrderDaoRepository();
  Future<void> getProducts() async {
    var list = await pRepo.getProduct();
    emit(list);
  }
  Future<void> sortAscByPriceProduct() async {
    var list = await pRepo.sortAscByPriceProduct();
    emit(list);
  }
  Future<void> sortDescByPriceProduct() async {
    var list = await pRepo.sortDescByPriceProduct();
    emit(list);
  }
  Future<void> filterProduct(int max , int min) async{
    var list = await pRepo.filterProduct(max, min);
    emit(list);
  }
  Future<void> sortByWordProduct() async{
    var list = await pRepo.sortByWordProduct();
    emit(list);
  }
  Future<void> getSearch(String searchedWord) async {
    var list = await pRepo.getSearch(searchedWord);
    emit(list);
  }
  Future<void> addToBasket(String product_name,String product_image_name,String product_price, String product_order_amount) async{
    await pRepo.addToBasket(product_name, product_image_name, product_price, product_order_amount);
  }

}