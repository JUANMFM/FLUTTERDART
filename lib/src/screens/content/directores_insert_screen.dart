import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/src/screens/content/directores_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DirectoresInsertScreen extends StatefulWidget {
  const DirectoresInsertScreen({super.key});

  @override
  _DirectoresInsertScreenState createState() => _DirectoresInsertScreenState();
}

class _DirectoresInsertScreenState extends State<DirectoresInsertScreen> {

  final TextEditingController nombresController = TextEditingController();
  final TextEditingController peliculasController = TextEditingController();

  Future<void> insertDirector(String nombres, String peliculas) async {
    await http.post(
      Uri.parse('https://servicios.campus.pe/directoresinsert.php'),
      body:{
        'nombres': nombres,
        'peliculas': peliculas,
      }
    );
    Fluttertoast.showToast(
        msg: "Se ha registrado un nuevo director",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DirectoresScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Padding(padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nombresController,
                decoration: const InputDecoration(
                  labelText: 'Nombres',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: peliculasController,  
                decoration: const InputDecoration(
                  labelText: 'Películas',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () {
                String nombres = nombresController.text;
                String peliculas = peliculasController.text;
                //print(nombres + '---------' + peliculas);
                insertDirector(nombres, peliculas);
              }, child: const Text("Guardar"))
            ],
          )
        ),
      )
      ),
    );
  }
}