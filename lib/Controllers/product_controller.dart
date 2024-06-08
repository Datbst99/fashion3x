import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Models/product_model.dart';

class ProductController {

  String? messageError;
  bool isLoading = false;
  Future<void> create(ProductModel product, File imageFile) async {
      isLoading= true;
      try{
        final storageRef = FirebaseStorage.instance.ref().child('product_images/${product.id}');
        await storageRef.putFile(imageFile);

        String imageUrl = await storageRef.getDownloadURL();
        product.image = imageUrl;

        await FirebaseFirestore.instance.collection('products').doc(product.id).set(product.toMap());
      } catch(e) {
        messageError = e.toString();
      }
      isLoading = false;
  }

  Future<void> update(ProductModel product, [File? imageFile]) async {
    isLoading = true;
    try{
      if(imageFile != null){
        final storageRef = FirebaseStorage.instance.ref().child('product_images/${product.id}');
        await storageRef.putFile(imageFile);
        String imageUrl = await storageRef.getDownloadURL();
        product.image = imageUrl;
      }
      await FirebaseFirestore.instance.collection('products').doc(product.id).update(product.toMap());
    }catch(e){
      messageError = e.toString();
    }
    isLoading = false;
  }

  Future<void> delete(ProductModel product) async {
    try {

      await FirebaseStorage.instance.ref('product_images/${product.id}').delete();
      await FirebaseFirestore.instance.collection('products').doc(product.id).delete();
    } catch (e) {
      messageError = e.toString();
    }
  }


}