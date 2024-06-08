import 'dart:io';

import 'package:fashion_3x/Controllers/product_controller.dart';
import 'package:fashion_3x/Models/product_model.dart';
import 'package:fashion_3x/Views/Components/button_component.dart';
import 'package:fashion_3x/Views/Components/input_text_component.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Configs/constant.dart';
import '../Components/popup_notification.dart';

class ProductEditScreen extends StatefulWidget {
  final ProductModel product;

  const ProductEditScreen({super.key, required this.product});

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final ProductController productController = ProductController();

  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController typeController;
  late TextEditingController priceController;

  File? imageFile;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.product.name ?? '');
    typeController = TextEditingController(text: widget.product.type ?? '');
    priceController = TextEditingController(text: widget.product.price.toString() ?? '');
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    typeController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _editProduct() async {
    widget.product.name = nameController.text;
    widget.product.type = typeController.text;
    widget.product.price = double.parse(priceController.text);

    setState(() {});
    await productController.update(widget.product, imageFile);

    if(productController.messageError != null){
      await showErrorDiaLog(context, "Thông báo", productController.messageError!);
    }else{
      await showErrorDiaLog(context, "Thông báo", 'Sửa sản phẩm mới thành công', navigateHome: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sửa sản phẩm'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputTextComponent(
                  labelText: "Tên sản phẩm",
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên sản phẩm';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputTextComponent(
                  labelText: "Loại sản phẩm",
                  controller: typeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập loại sản phẩm';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputTextComponent(
                  labelText: "Giá sản phẩm",
                  controller: priceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập giá sản phẩm';
                    }

                    if (double.tryParse(value) == null) {
                      return 'Giá phải là chữ số';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(border: Border.all(width: 2.0, color: borderColor)),
                    child: imageFile != null
                        ? Image.file(
                            imageFile!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Image.network(
                              widget.product.image,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Center(
                    child: ButtonComponent(
                        borderRadius: BorderRadius.circular(20),
                        onPressed: productController.isLoading ? null : () async {
                          if (_formKey.currentState!.validate()) {
                              await _editProduct();
                              setState(() {});
                          }
                        },
                        child: productController.isLoading
                            ? const SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2.0,
                          ),
                        )
                            : const Text('Sửa sản phẩm')),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
