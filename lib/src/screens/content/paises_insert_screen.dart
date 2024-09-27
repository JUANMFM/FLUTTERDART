import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/src/screens/content/paises_screen.dart';

class PaisesInsertScreen extends StatefulWidget {
  const PaisesInsertScreen({super.key});

  @override
  _PaisesInsertScreenState createState() => _PaisesInsertScreenState();
}

class _PaisesInsertScreenState extends State<PaisesInsertScreen> {
  final TextEditingController codpaisController = TextEditingController();
  final TextEditingController paisController = TextEditingController();
  final TextEditingController capitalController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController poblacionController = TextEditingController();
  final TextEditingController continenteController = TextEditingController();

  Future<void> insertPaises(String pais, String continente, String codpais,
      String capital, String area, String poblacion) async {
    await http.post(Uri.parse('https://servicios.campus.pe/paises.php'), body: {
      'pais': pais,
      'continente': continente,
      'codpais': codpais,
      'capital': capital,
      'area': area,
      'poblacion': poblacion
    });
    Fluttertoast.showToast(
        msg: "Se ha registrado un nuevo país",
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  TextField(
                    controller: capitalController,
                    decoration: const InputDecoration(
                        labelText: 'Capital', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: codpaisController,
                    decoration: const InputDecoration(
                        labelText: 'CodigoPais', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: areaController,
                    decoration: const InputDecoration(
                        labelText: 'Area', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: poblacionController,
                    decoration: const InputDecoration(
                        labelText: 'Población', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String pais = paisController.text;
                      String continente = continenteController.text;
                      String capital = capitalController.text;
                      String codpais = codpaisController.text;
                      String area = areaController.text;
                      String poblacion = poblacionController.text;

                      insertPaises(
                          pais, continente, codpais, capital, area, poblacion);
                    },
                    child: const Text("Guardar"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
