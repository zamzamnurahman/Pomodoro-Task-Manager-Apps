import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodoApi {
  Future<void> uploadingData({String? title, User? user}) async {
    FirebaseFirestore.instance.collection("todo").add({
      "user_id": user!.uid,
      "title": title,
      "status": false,
      "created_at": DateTime.now(),
    });
  }

  Future<void> editProduct(bool status, String id) async {
    await FirebaseFirestore.instance
        .collection("todo")
        .doc(id)
        .update({"status": status});
  }

  Future<void> deleteProduct(DocumentSnapshot doc) async {
    await FirebaseFirestore.instance.collection("todo").doc(doc.id).delete();
  }
}
