import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

/// Obtiene todos los documentos de la colección "Perros"
Future<List<Map<String, dynamic>>> getPerros() async {
  List<Map<String, dynamic>> perros = [];

  CollectionReference collectionReference = db.collection("Perros");
  QuerySnapshot query = await collectionReference.get();

  for (var doc in query.docs) {
    perros.add(doc.data() as Map<String, dynamic>);
  }

  return perros;
}
