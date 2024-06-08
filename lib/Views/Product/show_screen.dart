import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_3x/Configs/constant.dart';
import 'package:fashion_3x/Configs/router.dart';
import 'package:fashion_3x/Views/Components/card_shadow_component.dart';
import 'package:flutter/material.dart';

import '../../Controllers/product_controller.dart';
import '../../Models/product_model.dart';

class ProductShowScreen extends StatelessWidget {
  ProductShowScreen({super.key});

  final ProductController productController = ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteApp.productCreate);
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Có lỗi xảy ra'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(height: 300, child: Center(child: CircularProgressIndicator()),);
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((element) {
              final product = ProductModel.fromMap(element.data() as Map<String, dynamic>);
              return CardShadow(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Image.network(
                      height: 100,
                      width: 100,
                      product.image,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          RichText(
                            text: TextSpan(text: "Loại:", style: const TextStyle(color: textColor), children: [TextSpan(text: product.type)]),
                          ),
                          RichText(
                            text: TextSpan(text: "Giá: ", style: const TextStyle(color: textColor), children: [TextSpan(text: "${product.price.toString()} đ")]),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(RouteApp.productEdit, arguments: product);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            productController.delete(product);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
