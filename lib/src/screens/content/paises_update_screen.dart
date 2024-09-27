import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/src/screens/content/paises_screen.dart';

class PaisesUpdateScreen extends StatefulWidget {
  final String idpais;
  final String pais;
  final String continente;
  const PaisesUpdateScreen(
      {super.key,
      required this.idpais,
      required this.pais,
      required this.continente});
  @override
  _PaisesUpdateScreenState createState() => _PaisesUpdateScreenState();
}

class _PaisesUpdateScreenState extends State<PaisesUpdateScreen> {
  late TextEditingController idpaisController;
  late TextEditingController paisController;
  late TextEditingController continenteController;

  @override
  void initState() {
    super.initState();
    idpaisController = TextEditingController(text: widget.idpais);
    paisController = TextEditingController(text: widget.pais);
    continenteController = TextEditingController(text: widget.continente);
  }

  Future<void> updateDirector(
      String idpais, String pais, String continente) async {
    await http
        .post(Uri.parse('https://servicios.campus.pe/paisesinsert.php'), body: {
      'idpais': idpais,
      'pais': pais,
      'continente': continente,
    });
    Fluttertoast.showToast(
        msg: "Se ha actualizado los datos del pais de código $idpais",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const PaisesScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              readOnly: true,
              controller: idpaisController,
              decoration: const InputDecoration(
                  labelText: 'Código', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: paisController,
              decoration: const InputDecoration(
                  labelText: 'País', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: continenteController,
              decoration: const InputDecoration(
                  labelText: 'Continente', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  String nombres = paisController.text;
                  String peliculas = continenteController.text;
                  String iddirector = idpaisController.text;
                  //print(nombres + '---------' + peliculas);
                  updateDirector(iddirector, nombres, peliculas);
                },
                child: const Text("Guardar"))
          ],
        )),
      )),
    );
  }
}
