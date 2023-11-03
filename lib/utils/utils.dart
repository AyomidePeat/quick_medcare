import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference usersCollection =
    FirebaseFirestore.instance.collection("users");

CollectionReference callsCollection =
    FirebaseFirestore.instance.collection("calls");

Stream<DocumentSnapshot> userData({required String id}) async* {
  yield await usersCollection.doc(id).get();
}

Stream<List<DocumentSnapshot>> usersData() async* {
  List<DocumentSnapshot> users = [];
  await usersCollection.get().then((value) {
    if (value.docs.isNotEmpty) {
      for (var element in value.docs) {
        users.add(element);
      }
    }
  });

  yield users;
}
