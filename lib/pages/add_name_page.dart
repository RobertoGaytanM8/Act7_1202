import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class AddPerroPage extends StatefulWidget {
  const AddPerroPage({super.key});

  @override
  State<AddPerroPage> createState() => _AddPerroPageState();
}

class _AddPerroPageState extends State<AddPerroPage> {
  TextEditingController codigoController = TextEditingController();
  TextEditingController razaController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController comportamientoController = TextEditingController();
  TextEditingController vacunasController = TextEditingController();
  TextEditingController sexoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Perro"),
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
                hintText: 'Ingrese el código del perro',
                labelText: 'Código',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: razaController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la raza del perro',
                labelText: 'Raza',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: edadController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la edad del perro',
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: comportamientoController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el comportamiento del perro',
                labelText: 'Comportamiento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: vacunasController,
              decoration: const InputDecoration(
                hintText: 'Ingrese las vacunas del perro',
                labelText: 'Vacunas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: sexoController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el sexo del perro',
                labelText: 'Sexo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await addPerro(
                  codigoController.text,
                  razaController.text,
                  edadController.text,
                  comportamientoController.text,
                  vacunasController.text,
                  sexoController.text,
                ).then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text("Guardar"),
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
