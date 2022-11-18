import 'package:camera/camera.dart';
import 'package:flutterdemo/home/home_model.dart';
import 'package:flutterdemo/product_detail/product_detail.dart';
import 'package:flutterdemo/widgets/product.dart';
import 'package:flutter/material.dart';

class PopularProducts extends StatelessWidget {
  final CameraDescription camera;
  const PopularProducts({required this.camera,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 210,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: demoProducts
                  .map((product) => Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetail(camera: camera)));
                          },
                          child: ProductCard(product: product)
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
