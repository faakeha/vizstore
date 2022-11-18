import 'package:flutterdemo/order/widgets/widgets_order_details/products_card.dart';
import 'package:flutterdemo/order/widgets/widgets_order_details/total_card.dart';
import 'package:flutterdemo/widgets/customAppBar.dart';
import 'package:flutterdemo/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/order/order_model.dart';
import 'package:flutterdemo/order/widgets/widgets_order_details/details_card.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Order Details', backButton: true),
        body: Layout(
          widget: SingleChildScrollView(
            child: Column(
              children: [
                Text('ORDER ID: ${this.order.id}',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center),
                Text('Placed on: ${order.placedOn}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                DetailsCard(order: order,),
                ProductsCard(order: order,),
                TotalCard(order: order,),
              ],
            ),
          ),
        ),
      ),
    );
  }


}



