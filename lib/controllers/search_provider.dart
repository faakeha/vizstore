import 'package:flutter/material.dart';
import 'package:flutterdemo/repositories/user_repository.dart';
import 'package:flutterdemo/models/product_json.dart';
import 'package:flutterdemo/models/user_json.dart';
import 'package:flutterdemo/models/wishlist_json.dart';
import 'package:flutterdemo/repositories/product_repository.dart';

class SearchProvider with ChangeNotifier {
  SearchProvider(this._productRepository, this._userRepository);

  ProductRepository _productRepository;
  UserRepository _userRepository;

  String _searchText = '';
  bool _isFetching = true;
  List<ProductJson> _products = [];
  List<ProductJson> _categoryProducts = [];
  List<ProductJson> _filteredProducts = [];
  List<ProductJson> _changedProducts = [];
  UserJson _user = UserJson.empty();

  List<ProductJson> get products => _products;
  List<ProductJson> get categoryProducts => _categoryProducts;
  List<ProductJson> get filteredProducts => _filteredProducts;
  List<ProductJson> get changedProducts => _changedProducts;
  bool get isFetching => _isFetching;
  String get searchText => _searchText;

  Future<void> getUser() async {
    _user = await _userRepository.getUser();
    notifyListeners();
    print('prov' + _user.firstName);
  }

  Future<void> getProductsList() async {
    print('in method');
    _products = await _productRepository.getProductList();
    notifyListeners();
    print('search' + products[0].category);
    //notifyListeners();
  }

  void setProducts(List<ProductJson> list){
    print('in set prods');
    _changedProducts = list;
    notifyListeners();
    _isFetching = false;

  }

  void getProds(List<String> ids){

    List<ProductJson> list = [];
    for (var element in ids) {
      list.add(getProduct(element));
    }

    _changedProducts = list;
  }

  ProductJson getProduct(String id) {
    ProductJson product = ProductJson.empty();
    for (var product in _products) {
      print("prod,, ${product.id}");
      if(id == product.id){
        return product;
      }
    }
    return product;
  }

  void getFilteredProducts() {
    _filteredProducts = products
        .where((element) =>
            element.title.toLowerCase().contains(_searchText.toLowerCase()) ||
            element.description
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
        .toList();
    _changedProducts = _filteredProducts;
    notifyListeners();
  }

  void setSearchItem(String text) {
    _searchText = text;
    notifyListeners();
  }

  bool getIsFavourite(String productId) {
    bool isFav = false;
    isFav  = _user.wishlist.any((element) => element.productId == productId);
    print('issfav ${isFav}');
    return isFav;
  }

  Future<void> updateWishlist(String productId) async {
    List<WishlistItemJson> newWishlist = [];
    var contain = _user.wishlist.any((element) => element.productId == productId);
    if (contain)
    {
      for (var item in _user.wishlist){
        if(item.productId != productId){
          newWishlist.add(item);
        }
      }
    }
    //value not exists
    else
    {
      for (var item in _user.wishlist){
        newWishlist.add(item);
      }
      newWishlist.add(WishlistItemJson(productId: productId));
    }
    UserJson updatedUser = _user.copyWith(wishlist: newWishlist);
    //print(updatedUser.cart[0].quantity);
    await _userRepository.updateUser(updatedUser);
    _user = await _userRepository.getUser();
    notifyListeners();
  }
}
