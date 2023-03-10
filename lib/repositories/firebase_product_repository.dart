import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdemo/models/product_json.dart';

class FirebaseProductRepository{
  final db = FirebaseFirestore.instance;

  Future<List<ProductJson>> getProductList() async {
    List<ProductJson> products = [];
    await db.collection("product").get().then((event) {
      products = event.docs.map((e) => ProductJson.fromJson(e.data(), e.id)).toList();
    }).catchError((error) => print("Failed to fetch products. Error : ${error}"));
    return products;
  }

  Future<ProductJson> getProductInfo(String id) async {

    ProductJson product = const ProductJson.empty();

    await db.collection("product").doc(id).get().then((event) {
      product = ProductJson.fromJson(event.data() as Map<String, dynamic>, event.id);
    }).catchError((error) => print("Failed to fetch store. Error : ${error}"));
    return product;
  }

  Future<void> updateProduct(ProductJson product) async {
    await db.collection("product").doc(product.id).update(product.toJson()).then((event) {
    }).catchError((error) => print("Failed to update product. Error : ${error}"));
  }
}