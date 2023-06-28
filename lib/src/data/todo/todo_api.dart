import 'package:cloud_firestore/cloud_firestore.dart';

class TodoApi {
  Future<void> uploadingData({String? title}) async {
    FirebaseFirestore.instance.collection("todo").add({
      "title": title,
      "status": false,
      "created_at": DateTime.now(),
    }).then((value) => print(value));
  }
}
