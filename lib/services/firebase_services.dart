import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// Obtener todos los perros
Future<List> getPerros() async {
  List perros = [];
  CollectionReference collectionReferencePerros = db.collection("Perros");
  QuerySnapshot queryPerros = await collectionReferencePerros.get();

  for (var doc in queryPerros.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final perro = {
      "Codigo": data['Codigo'],
      "Raza": data['Raza'],
      "Edad": data['Edad'],
      "Comportamiento": data['Comportamiento'],
      "Vacunas": data['Vacunas'],
      "Sexo": data['Sexo'],
      "uid": doc.id,
    };
    perros.add(perro);
  }
  return perros;
}

// Agregar un nuevo perro
Future<void> addPerro(
  String codigo,
  String raza,
  String edad,
  String comportamiento,
  String vacunas,
  String sexo,
) async {
  await db.collection("Perros").add({
    "Codigo": codigo,
    "Raza": raza,
    "Edad": edad,
    "Comportamiento": comportamiento,
    "Vacunas": vacunas,
    "Sexo": sexo,
  });
}

// Actualizar un perro existente
Future<void> updatePerro(
  String uid,
  String codigo,
  String raza,
  String edad,
  String comportamiento,
  String vacunas,
  String sexo,
) async {
  await db.collection("Perros").doc(uid).set({
    "Codigo": codigo,
    "Raza": raza,
    "Edad": edad,
    "Comportamiento": comportamiento,
    "Vacunas": vacunas,
    "Sexo": sexo,
  });
}

// Eliminar un perro
Future<void> deletePerro(String uid) async {
  await db.collection("Perros").doc(uid).delete();
}
