import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNamePage extends StatefulWidget {
  const AddNamePage({super.key});

  @override
  State<AddNamePage> createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddNamePage> {
  final TextEditingController _nameController = TextEditingController();
  final CollectionReference peopleCollection =
      FirebaseFirestore.instance.collection('people');

  Future<void> _addName() async {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      await peopleCollection.add({'name': name});
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa un nombre')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nombre'),
        backgroundColor: const Color.fromARGB(255, 255, 133, 133),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addName,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
