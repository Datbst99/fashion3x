import 'dart:io';

import 'package:fashion_3x/Controllers/product_controller.dart';
import 'package:fashion_3x/Models/product_model.dart';
import 'package:fashion_3x/Views/Components/button_component.dart';
import 'package:fashion_3x/Views/Components/input_text_component.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Configs/constant.dart';
import '../Components/popup_notification.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final ProductController productController = ProductController();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  File? imageFile;
  String? errorMessage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _createProduct() async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    final newProduct = ProductModel(
      id: id,
      name: nameController.text,
      image: "",
      type: typeController.text,
      price: double.parse(priceController.text),
    );

    setState(() {});
    await productController.create(newProduct, imageFile!);

    if(productController.messageError != null){
      await showErrorDiaLog(context, "Thông báo", productController.messageError!);
    }else{
      await showErrorDiaLog(context, "Thông báo", 'Thêm sản phẩm mới thành công', navigateHome: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm sản phẩm'),
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
                        : const Center(
                            child: Text(
                              'Image',
                              style: TextStyle(color: textColor),
                            ),
                          ),
                  ),
                ),
                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Center(
                    child: ButtonComponent(
                        borderRadius: BorderRadius.circular(20),
                        onPressed: productController.isLoading ? null : () async {
                          if (imageFile == null) {
                            errorMessage = 'Vui lòng chọn hình ảnh';
                          } else {
                            errorMessage = null;
                          }

                          if (_formKey.currentState!.validate()) {
                            await _createProduct();
                          }

                          setState(() {});
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
                            : const Text('Thêm mới')),
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
