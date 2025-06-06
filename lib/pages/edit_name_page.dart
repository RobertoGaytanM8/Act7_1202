import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditNamePage extends StatefulWidget {
  final String docId;
  final String currentName;

  const EditNamePage({super.key, required this.docId, required this.currentName});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  late TextEditingController _nameController;
  final CollectionReference peopleCollection =
      FirebaseFirestore.instance.collection('people');

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  Future<void> _updateName() async {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      await peopleCollection.doc(widget.docId).update({'name': name});
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
        title: const Text('Editar Nombre'),
        backgroundColor: const Color.fromARGB(255, 255, 234, 49),
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
              onPressed: _updateName,
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
