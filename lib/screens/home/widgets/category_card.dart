import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
    Key? key,
    required this.category,
    required this.onPress,
  }) : super(key: key);

  final VoidCallback onPress;
  final Map<String, dynamic> category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onPress,
        child: Container(
          height: 80,
          width: 80,
          //color: Colors.grey,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 240, 240),
            border: Border.all(
              color: Color.fromARGB(255, 240, 240, 240),
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(
            children: [
              Container(
                height: 50,
                width: 50,
                child: SvgPicture.asset(category["icon"]),
              ),
              const SizedBox(height: 5),
              Text(category["text"],style: TextStyle(fontSize: 13),),
            ],
          ),
        ),
      ),
    );
  }
}
