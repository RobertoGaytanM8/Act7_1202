import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart'; // Asegúrate que la ruta sea correcta

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD Roberto Gaytan 1202"),
        centerTitle: true,
         backgroundColor: const Color.fromARGB(255, 152, 255, 226),
      ),
      body: FutureBuilder(
        future: getPerros(), // Cambiado a getPerros()
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Map<String, dynamic>> perrosList =
                List<Map<String, dynamic>>.from(snapshot.data ?? []);

            if (perrosList.isEmpty) {
              return const Center(
                child: Text('No hay perros registrados. ¡Agrega uno!'),
              );
            }

            return ListView.builder(
              itemCount: perrosList.length,
              itemBuilder: (context, index) {
                final perro = perrosList[index];

                return Dismissible(
                  key: Key(perro['uid']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    bool? result = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("¿Eliminar al perro con código '${perro['Codigo']}'?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Sí, eliminar"),
                          ),
                        ],
                      ),
                    );
                    return result ?? false;
                  },
                  onDismissed: (direction) async {
                    await deletePerro(perro['uid']);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Perro con código "${perro['Codigo']}" eliminado correctamente')),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 4.0,
                    child: ListTile(
                      title: Text(
                        perro['Raza'] ?? 'Sin raza',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Código: ${perro['Codigo'] ?? 'N/A'}'),
                          Text('Edad: ${perro['Edad'] ?? 'N/A'}'),
                          Text('Comportamiento: ${perro['Comportamiento'] ?? 'N/A'}'),
                          Text('Vacunas: ${perro['Vacunas'] ?? 'N/A'}'),
                          Text('Sexo: ${perro['Sexo'] ?? 'N/A'}'),
                        ],
                      ),
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          '/edit',
                          arguments: perro,
                        );
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar datos: ${snapshot.error}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
