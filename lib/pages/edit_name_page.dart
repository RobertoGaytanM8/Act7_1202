import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditNamePage extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> data;

  const EditNamePage({super.key, required this.docId, required this.data});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  final CollectionReference perrosCollection =
      FirebaseFirestore.instance.collection('Perros');

  late TextEditingController _fieldNameController;
  late TextEditingController _fieldValueController;
  late String originalField;
  bool _isValid = true;

  @override
  void initState() {
    super.initState();

    // Excluir createdAt al buscar campo para editar
    final filtered = widget.data.entries
        .where((entry) => entry.key != 'createdAt')
        .toList();

    if (filtered.isNotEmpty) {
      final entry = filtered.first;
      originalField = entry.key;
      _fieldNameController = TextEditingController(text: entry.key);
      _fieldValueController = TextEditingController(text: entry.value.toString());
    } else {
      _isValid = false;
      _fieldNameController = TextEditingController();
      _fieldValueController = TextEditingController();
    }
  }

  Future<void> _updateField() async {
    final newField = _fieldNameController.text.trim();
    final newValue = _fieldValueController.text.trim();

    if (newField.isNotEmpty && newValue.isNotEmpty) {
      final docRef = perrosCollection.doc(widget.docId);

      if (newField != originalField) {
        await docRef.update({originalField: FieldValue.delete()});
      }

      await docRef.update({newField: newValue});
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nombre y valor no pueden estar vacíos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Campo'),
        backgroundColor: const Color.fromARGB(255, 101, 255, 234),
      ),
      body: _isValid
          ? Padding(
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
                    decoration: const InputDecoration(labelText: 'Nuevo Valor'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateField,
                    child: const Text('Guardar Cambios'),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text(
                'No hay campos editables en este documento.',
                style: TextStyle(fontSize: 16),
              ),
            ),
    );
  }
}
