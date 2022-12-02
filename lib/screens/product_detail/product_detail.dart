import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/screens/product_detail/widgets/bottom_bar.dart';
import 'package:flutterdemo/screens/product_detail/widgets/product_body.dart';
import '../../models/product_model.dart';
import '../widgets/custom_app_bar2.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({required this.product, super.key});

  final ProductJson product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            ProductBody(product: product),
            BottomBar(product: product),
            const CustomAppBar2(),
          ],
        ),
      ),
    );
  }
}

