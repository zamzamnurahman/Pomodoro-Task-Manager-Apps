import 'package:cloud_firestore/cloud_firestore.dart';

class TodoApi {
  Future<void> uploadingData({String? title}) async {
    FirebaseFirestore.instance.collection("todo").add({
      "title": title,
      "status": false,
      "created_at": DateTime.now(),
    }).then((value) => print(value));
  }

  Future<void> editProduct(bool status,String id) async {
    await FirebaseFirestore.instance
        .collection("todo")
        .doc(id)
        .update({"status": status});
  }

  Future<void> deleteProduct(DocumentSnapshot doc) async {
    await FirebaseFirestore.instance
        .collection("todo")
        .doc(doc.id)
        .delete();
  }
}
