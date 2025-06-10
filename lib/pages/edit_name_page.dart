import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class EditPerroPage extends StatefulWidget {
  const EditPerroPage({super.key});

  @override
  State<EditPerroPage> createState() => _EditPerroPageState();
}

class _EditPerroPageState extends State<EditPerroPage> {
  TextEditingController codigoController = TextEditingController();
  TextEditingController razaController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController comportamientoController = TextEditingController();
  TextEditingController vacunasController = TextEditingController();
  TextEditingController sexoController = TextEditingController();

  String? _uid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    _uid = arguments['uid'];
    codigoController.text = arguments['Codigo'] ?? '';
    razaController.text = arguments['Raza'] ?? '';
    edadController.text = arguments['Edad'] ?? '';
    comportamientoController.text = arguments['Comportamiento'] ?? '';
    vacunasController.text = arguments['Vacunas'] ?? '';
    sexoController.text = arguments['Sexo'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perro"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 152, 255, 226),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: codigoController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el código',
                labelText: 'Código',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: razaController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la raza',
                labelText: 'Raza',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: edadController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la edad',
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: comportamientoController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el comportamiento',
                labelText: 'Comportamiento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: vacunasController,
              decoration: const InputDecoration(
                hintText: 'Ingrese las vacunas',
                labelText: 'Vacunas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: sexoController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el sexo',
                labelText: 'Sexo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (_uid != null) {
                  await updatePerro(
                    _uid!,
                    codigoController.text,
                    razaController.text,
                    edadController.text,
                    comportamientoController.text,
                    vacunasController.text,
                    sexoController.text,
                  ).then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error: No se pudo obtener el UID del documento.")),
                  );
                }
              },
              child: const Text("Actualizar"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    codigoController.dispose();
    razaController.dispose();
    edadController.dispose();
    comportamientoController.dispose();
    vacunasController.dispose();
    sexoController.dispose();
    super.dispose();
  }
}
