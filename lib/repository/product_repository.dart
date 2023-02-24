import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stock_app/models/new_product_model.dart';

class ProductRepository {
  final fireStore = FirebaseFirestore.instance;
  final collectionPath = 'products';
  final userId = FirebaseAuth.instance.currentUser?.uid;

// This function will get all product added by user by filtering only their product.
  Future<List<NewProductModel>> getProduct(String? userId) async {
    try {
      final response = await fireStore
          .collection(collectionPath)
          .where('user_id', isEqualTo: userId)
          .get();

      final docs = response.docs;
      final products = docs.map((e) {
        final json = e.data();
        final docId = e.id;
        return NewProductModel.fromMap(
          json,
          docId,
        );
      }).toList();

      return products;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  // This function will add product to products collection.
  Future<bool> addProduct(Map<String, dynamic> productData) async {
    try {
      await fireStore.collection(collectionPath).add(productData);
      return true;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

// This function will update the products by providing the docId and the new data.
  Future<bool> updateProduct({
    required String docId,
    required Map<String, dynamic> updatedBody,
  }) async {
    try {
      await fireStore.collection(collectionPath).doc(docId).update(updatedBody);
      return true;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

// This function will delete the product of user by providing the docId.
  Future<bool> deleteProduct({required String docId}) async {
    try {
      await fireStore.collection(collectionPath).doc(docId).delete();
      return true;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}
