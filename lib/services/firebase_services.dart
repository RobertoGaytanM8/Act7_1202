import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getPeople() async {
  List<Map<String, dynamic>> people = [];

  CollectionReference collectionReferencePeople = db.collection("people");
  QuerySnapshot queryPeople = await collectionReferencePeople.get();

  for (var doc in queryPeople.docs) {
    people.add(doc.data() as Map<String, dynamic>);
  }

  return people;
}
