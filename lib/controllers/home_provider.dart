import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/core/user_repository.dart';
import 'package:flutterdemo/models/notification_model.dart';
import 'package:flutterdemo/models/product_model.dart';
import 'package:flutterdemo/models/wishlist_model.dart';
import 'package:flutterdemo/repositories/product_repository.dart';
import '../models/store_model.dart';
import '../models/user_model.dart';
import '../repositories/store_repository.dart';
import 'package:get_it/get_it.dart';

class HomeProvider with ChangeNotifier {

  HomeProvider(this._storeRepository, this._productRepository,
      this._userRepository);

  StoreRepository _storeRepository;
  ProductRepository _productRepository;
  UserRepository _userRepository;

  StoreJson _store = const StoreJson.empty();
  UserJson _user = UserJson.empty();
  List<ProductJson> _products = [];
  List<ProductJson> _categoryProducts  = [];
  List<ProductJson> _filteredProducts = [];
  List<ProductJson> _popularProducts = [];
  int _notis = 0;
  String _searchText = '';

  StoreJson get store => _store;
  List<ProductJson> get products => _products;
  UserJson get user => _user;
  List<ProductJson> get categoryProducts => _categoryProducts;
  List<ProductJson> get popularProducts => _popularProducts;
  int get notis => _notis;



  void getStore(String id) async {
    _store = await _storeRepository.getStoreInfo(id);
    notifyListeners();
    print(_store);
  }

  Future<void> getUser() async {
    _user = await _userRepository.getUser();
    notifyListeners();
    print('prov' + _user.firstName);
    print("notsi ${_user.notifications}");

  }

  Future<void> getProductsList() async {
    print('in method');
    _products = await _productRepository.getProductList();
    notifyListeners();
    //print(products[0].category);
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
      print('already in wishlist');
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

  Future<void> sendNotifications() async{
    _user = await _userRepository.sendNotifications();
    notifyListeners();
  }


  int notifications(AsyncSnapshot<QuerySnapshot<Object?>> snapshot){
    UserJson newUser = UserJson.empty();
    int filteredList = 0;
    snapshot.data?.docs
        .forEach((DocumentSnapshot document) {
      //print("gg");
      if (document.id == _user.id) {
        newUser = UserJson.fromJson(
            document.data() as Map<String, dynamic>, document.id);
        filteredList = newUser.notifications.where((val) => val.read == false).length;

      }
    });
    return filteredList;
  }

  void markAsRead() async{
    _user = await _userRepository.getUser();
    notifyListeners();
    List<NotificationItemJson> newList = [];
    print("sa ${_user.notifications.length}");
    for (var item in _user.notifications){

      NotificationItemJson i = item.copyWith(orderId: item.orderId ,message: item.message,dateTime: item.dateTime ,read: true);
      newList.add(i);

    }
    print("sa ${newList.length}");
    UserJson updatedUser = _user.copyWith(notifications: newList);
    //print(updatedUser.cart[0].quantity);
    await _userRepository.updateUser(updatedUser);
    notifyListeners();
    _user = await _userRepository.getUser();
    notifyListeners();
  }

  Future<List<ProductJson>> getCategoryProducts(String category) async {
    //await getProductsList();
    print('ctg' + category);
    _categoryProducts =
        products.where((element) => element.category == category).toList();

    return _categoryProducts;
    //_changedProducts = _categoryProducts;
    //notifyListeners();
  }

  List<ProductJson> getFilteredProducts() {
    _filteredProducts = products
        .where((element) =>
    element.title.toLowerCase().contains(_searchText.toLowerCase()) ||
        element.description
            .toLowerCase()
            .contains(_searchText.toLowerCase()))
        .toList();

    return _filteredProducts;
    //_changedProducts = _filteredProducts;
    //notifyListeners();
  }

  void setSearchItem(String text) {
    _searchText = text;
    notifyListeners();
  }

  Future<void> getPopularProducts() async {

    if (products.isNotEmpty) {
      products.sort((b, a) => a.sold.compareTo(b.sold));
    }

    List<ProductJson> list = [];
    for (var i = 0; i < 6; i++) {
      list.add(products[i]);
    }

    _popularProducts = list;
    notifyListeners();
  }


}