import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_app/models/stock_entry_model.dart';

class StockEntryRepository {
  final fireStore = FirebaseFirestore.instance;
  final collectionPath = 'stock-entry';

  Future<List<StockEntryModel>> getStockEntry(String docId) async {
    try {
      final response = await fireStore
          .collection(collectionPath)
          .where('doc_id', isEqualTo: docId)
          .get();
      final docs = response.docs;
      final stockEntry = docs.map((e) {
        final json = e.data();
        final docId = e.id;
        return StockEntryModel.fromMap(json, docId);
      }).toList();
      return stockEntry;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addStockEntry(Map<String, dynamic> body) async {
    try {
      await fireStore.collection(collectionPath).add(body);
      return true;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}
