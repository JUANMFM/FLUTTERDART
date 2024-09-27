import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/src/screens/content/directores_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DirectoresUpdateScreen extends StatefulWidget {
  final String iddirector;
  final String nombres;
  final String peliculas;

  const DirectoresUpdateScreen({
    super.key,
    required this.iddirector,
    required this.nombres,
    required this.peliculas,
  });

  @override
  _DirectoresUpdateScreenState createState() => _DirectoresUpdateScreenState();
}

class _DirectoresUpdateScreenState extends State<DirectoresUpdateScreen> {
  late TextEditingController iddirectorController;
  late TextEditingController nombresController;
  late TextEditingController peliculasController;

  @override
  void initState() {
    super.initState();
    iddirectorController = TextEditingController(text: widget.iddirector);
    nombresController = TextEditingController(text: widget.nombres);
    peliculasController = TextEditingController(text: widget.peliculas);
  }

  Future<void> updateDirector(
      String iddirector, String nombres, String peliculas) async {
    await http.post(
      Uri.parse('https://servicios.campus.pe/directoresupdate.php'),
      body: {
        'iddirector': iddirector,
        'nombres': nombres,
        'peliculas': peliculas,
      },
    );
    Fluttertoast.showToast(
      msg: "Se ha actualizado los datos del director de código $iddirector",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DirectoresScreen(),
      ),
    );
  }

  Future<void> deleteDirector(String iddirector) async {
    final response = await http.post(
      Uri.parse('https://servicios.campus.pe/directoresdelete.php'),
      body: {
        'iddirector': iddirector,
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Se ha eliminado el director de código $iddirector",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DirectoresScreen(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg:
            "Error al eliminar el director. Código de estado: ${response.statusCode}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              readOnly: true,
              controller: iddirectorController,
              decoration: const InputDecoration(
                labelText: 'Código',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: nombresController,
              decoration: const InputDecoration(
                labelText: 'Nombres',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: peliculasController,
              decoration: const InputDecoration(
                labelText: 'Películas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  String nombres = nombresController.text;
                  String peliculas = peliculasController.text;
                  String iddirector = iddirectorController.text;
                  //print(nombres + '---------' + peliculas);
                  updateDirector(iddirector, nombres, peliculas);
                },
                child: const Text("Actualizar")),
            ElevatedButton(
                onPressed: () {
                  String iddirector = iddirectorController.text;
                  //print(nombres + '---------' + peliculas);
                  deleteDirector(iddirector);
                },
                child: const Text("Eliminar"))
          ],
        )),
      )),
    );
  }
}
