import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/screens/wishlist/widgets/wishlist_cards.dart';
import '../widgets/bottom_nav_bar/bottom_nav_bar.dart';
import '../widgets/custom_app_bar/custom_app_bar.dart';
import '../widgets/layout.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

bool fav = true;

class _WishlistState extends State<Wishlist> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Wishlist",
          backButton: false,
        ),
        body: Stack(
          children: [
            Layout(
                widget: SingleChildScrollView(
                  child: Column(
                    children: const [
                      SizedBox(height: 10,),
                      WishlistCards(),
                      SizedBox(height: 100,),
                    ],
                  ),
                )),
            BottomNavBar(),
          ],
        ),
      ),
    );
  }
}





