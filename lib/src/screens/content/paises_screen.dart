import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/src/screens/content/paises_insert_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'dart:convert';
import 'package:myapp/src/utils/dimensions.dart';

class PaisesScreen extends StatefulWidget {
  const PaisesScreen({super.key});

  @override
  _PaisesScreenState createState() => _PaisesScreenState();
}

class _PaisesScreenState extends State<PaisesScreen> {
  List<dynamic> _pais = [];

  @override
  void initState() {
    super.initState();
    _fetchPaises();
  }

  Future<void> _fetchPaises() async {
    final response =
        await http.get(Uri.parse('https://servicios.campus.pe/paises.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _pais = data;
      });
    } else {
      throw Exception("Error al leer los datos");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Paises'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
              child: _pais.isEmpty
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: _pais.length,
                      itemBuilder: (context, index) {
                        final country = _pais[index];
                        return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: Dimensions.tinyPadding,
                                horizontal: Dimensions.smallPadding),
                            child: ListTile(
                              title: Text(country["idpais"],
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(country["codpais"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(country["pais"]),
                                    Text(country["capital"]),
                                    Text(country["area"]),
                                    Text(country["poblacion"]),
                                    Text(country["continente"])
                                  ]),
                            ));
                      },
                    )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaisesInsertScreen()));
            },
            tooltip: 'Nuevo país',
            child: const Icon(Icons.add),
          )),
    );
  }
}
