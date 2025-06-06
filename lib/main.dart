import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages/add_name_page.dart';
import 'pages/edit_name_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crud Gaytan Roberto',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference peopleCollection =
      FirebaseFirestore.instance.collection('people');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud Gaytan Roberto'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 15, 173, 107),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: peopleCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final people = snapshot.data!.docs;

          return ListView.builder(
            itemCount: people.length,
            itemBuilder: (context, index) {
              final person = people[index];
              final data = person.data() as Map<String, dynamic>;

              return Dismissible(
                key: Key(person.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar eliminación'),
                      content: const Text('¿Estás seguro de eliminar este nombre?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Eliminar'),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (direction) async {
                  await peopleCollection.doc(person.id).delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nombre eliminado')),
                  );
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.entries.map((entry) {
                      return Text('${entry.key}: ${entry.value}',
                          style: const TextStyle(fontSize: 16));
                    }).toList(),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNamePage(
                          docId: person.id,
                          currentName: data['name'] ?? '',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 101, 255, 234),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNamePage()),
          );
        },
      ),
    );
  }
}
