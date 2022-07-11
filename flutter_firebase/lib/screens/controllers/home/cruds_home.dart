import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CrudHome extends StatefulWidget {
  const CrudHome({Key? key}) : super(key: key);

  @override
  State<CrudHome> createState() => _CrudHomeState();
}

class _CrudHomeState extends State<CrudHome> {
  final User _currentUser = FirebaseAuth.instance.currentUser!;
  final CollectionReference _vehiculos =
      FirebaseFirestore.instance.collection("vehiculos");

  ///////////////////////////////////////////////////////////////////////
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _anioController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  ///////////////////////////////////////////////////////////////////////
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _marcaController.text = documentSnapshot["marca"];
      _modeloController.text = documentSnapshot["modelo"];
      _colorController.text = documentSnapshot["color"];
      _anioController.text = documentSnapshot["anio"].toString();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _marcaController,
                decoration: const InputDecoration(labelText: "Marca"),
              ),
              TextField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: "Modelo"),
              ),
              TextField(
                controller: _colorController,
                decoration: const InputDecoration(labelText: "Color"),
              ),
              TextField(
                controller: _anioController,
                decoration: const InputDecoration(labelText: "Año"),
              ),
              const SizedBox(height: 20),
              //////////////////////////////////////////////////////////////////
              Center(
                child: ElevatedButton(
                  // ignore: sort_child_properties_last
                  child: const Text("Update"),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff3C6DA5),
                  ),
                  onPressed: () async {
                    final String marca = _marcaController.text;
                    final String modelo = _modeloController.text;
                    final String color = _colorController.text;
                    final String anio = _anioController.text;

                    await _vehiculos.doc(documentSnapshot!.id).update(
                      {
                        "marca": marca,
                        "modelo": modelo,
                        "color": color,
                        "anio": anio,
                      },
                    );
                    _marcaController.text = "";
                    _modeloController.text = "";
                    _colorController.text = "";
                    _anioController.text = "";
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///////////////////////////////////////////////////////////////////////

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _marcaController.text = documentSnapshot["marca"];
      _modeloController.text = documentSnapshot["modelo"];
      _colorController.text = documentSnapshot["color"];
      _anioController.text = documentSnapshot["anio"].toString();
      _idController.text = documentSnapshot["id"];
    }
    _marcaController.text = "";
    _modeloController.text = "";
    _anioController.text = "";
    _colorController.text = "";

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _marcaController,
                decoration: const InputDecoration(labelText: "Marca"),
              ),
              TextField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: "Modelo"),
              ),
              TextField(
                controller: _colorController,
                decoration: const InputDecoration(labelText: "Color"),
              ),
              TextField(
                controller: _anioController,
                decoration: const InputDecoration(labelText: "Año"),
              ),
              //TextField(
              //enabled: true,
              //controller: _idController,
              //decoration: const InputDecoration(labelText: "Id"),
              //),
              const SizedBox(height: 20),
              //////////////////////////////////////////////////////////////////
              Center(
                child: ElevatedButton(
                  // ignore: sort_child_properties_last
                  child: const Text("Create"),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff3C6DA5),
                  ),
                  onPressed: () async {
                    final String marca = _marcaController.text;
                    final String modelo = _modeloController.text;
                    final String color = _colorController.text;
                    final String anio = _anioController.text;
                    final String id = FirebaseAuth.instance.currentUser!.uid;

                    await _vehiculos.add(
                      {
                        "marca": marca,
                        "modelo": modelo,
                        "color": color,
                        "anio": anio,
                        "id": id,
                      },
                    );
                    _marcaController.text = "";
                    _modeloController.text = "";
                    _colorController.text = "";
                    _anioController.text = "";
                    //_idController.text = "";
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///////////////////////////////////////////////////////////////////////

  Future<void> _delete(String vehiculosId) async {
    await _vehiculos.doc(vehiculosId).delete();

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Successfully Deleted"),
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ////////////////////////////////////////////
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff3C6DA5),
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),
      ////////////////////////////////////////////
      body: StreamBuilder(
        //stream: _vehiculos.snapshots(),
        stream: _vehiculos.where("id", isEqualTo: _currentUser.uid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length, //Numero de filas
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  //MediaQuery.of(context).size.width;
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: ListTile(
                    title: Text(documentSnapshot["marca"]),
                    subtitle: Text(documentSnapshot["modelo"]),
                    leading: Text(documentSnapshot["anio"].toString()),
                    //trailing: Text(documentSnapshot["color"]),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => {_update(documentSnapshot)},
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => {_delete(documentSnapshot.id)},
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
