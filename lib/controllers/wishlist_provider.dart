import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/core/user_repository.dart';
import 'package:flutterdemo/models/wishlist_model.dart';
import 'package:flutterdemo/models/product_model.dart';
import 'package:flutterdemo/repositories/product_repository.dart';
import '../models/store_model.dart';
import '../models/user_model.dart';
import '../repositories/store_repository.dart';
import 'package:get_it/get_it.dart';

class WishlistProvider with ChangeNotifier {
  WishlistProvider(
      this._storeRepository, this._productRepository, this._userRepository);

  ProductRepository _productRepository;
  UserRepository _userRepository;
  StoreRepository _storeRepository;

  final StoreJson _store = const StoreJson.empty();
  UserJson _user = UserJson.empty();
  List<ProductJson> _products = [];
  List<StoreJson> _stores = [];
  int _total = -1;

  StoreJson get store => _store;
  List<ProductJson> get products => _products;
  List<StoreJson> get stores => _stores;
  UserJson get user => _user;
  int get total => _total;

  Future<void> getUser() async {
    _user = await _userRepository.getUser();
    notifyListeners();
    //print('cart quantity ${_user.cart[0].quantity}');
  }

  ProductJson getProduct(String id) {
    ProductJson product = ProductJson.empty();
    for (var product in _products) {
      if (id == product.id) {
        return product;
      }
    }
    return product;
  }

  StoreJson getStore(String id) {
    StoreJson store = StoreJson.empty();
    for (var store in _stores) {
      if (id == store.id) {
        return store;
      }
    }
    return store;
  }

  Future<void> getProductsList() async {
    _products = await _productRepository.getProductList();
    notifyListeners();
    print(products);
  }

  Future<void> getStoresList() async {
    _stores = await _storeRepository.getStoresList();
    notifyListeners();
    print(stores);
    //notifyListeners();
  }

  Future<void> updateWishlist(String productId) async {
    List<WishlistItemJson> newWishlist = [];
    for (var item in user.wishlist) {
      if(item.productId == productId){
        print('skip this');
      }
      else{
        newWishlist.add(item);
      }
    }

    UserJson updatedUser = _user.copyWith(wishlist: newWishlist);
    await _userRepository.updateUser(updatedUser);
    _user = await _userRepository.getUser();
    notifyListeners();
  }

  bool getIsFavourite(String productId) {
    bool isFav = false;
    isFav = user.wishlist.any((element) => element.productId == productId);
    return isFav;
  }
}