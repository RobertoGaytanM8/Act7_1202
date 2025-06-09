import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNamePage extends StatefulWidget {
  const AddNamePage({super.key});

  @override
  State<AddNamePage> createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddNamePage> {
  final TextEditingController _fieldNameController = TextEditingController();
  final TextEditingController _fieldValueController = TextEditingController();

  final CollectionReference perrosCollection =
      FirebaseFirestore.instance.collection('Perros');

  Future<void> _addField() async {
    final field = _fieldNameController.text.trim();
    final value = _fieldValueController.text.trim();

    if (field.isNotEmpty && value.isNotEmpty) {
      await perrosCollection.add({
        field: value,
        'createdAt': FieldValue.serverTimestamp(), // ← Agregado para orden
      });
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa un nombre de campo y su valor')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Campo'),
        backgroundColor: const Color.fromARGB(255, 101, 255, 234),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fieldNameController,
              decoration: const InputDecoration(labelText: 'Nombre del Campo'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _fieldValueController,
              decoration: const InputDecoration(labelText: 'Valor del Campo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addField,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
