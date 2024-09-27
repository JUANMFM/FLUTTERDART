import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/src/screens/content/pedidos_detail_screen.dart'; // Asegúrate de que la ruta sea correcta
import 'package:myapp/src/theme/app_theme.dart';

class PedidosScreen extends StatefulWidget {
  final String
      pedidoId; // Puedes obtener el pedidoId de alguna fuente externa si es necesario
  const PedidosScreen({super.key, required this.pedidoId});

  @override
  _PedidosScreenState createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  List<dynamic> _pedidos = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchPedidos();
  }

  Future<void> _fetchPedidos() async {
    try {
      final response = await http.get(Uri.parse(
          'https://servicios.campus.pe/pedidos.php?idpedido=${widget.pedidoId}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List && data.isNotEmpty) {
          setState(() {
            _pedidos = data;
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'No se encontraron pedidos.';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage =
              'Error al obtener los pedidos: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener los pedidos: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Pedidos'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage))
                : _buildPedidosList(),
      ),
    );
  }

  Widget _buildPedidosList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _pedidos.length,
      itemBuilder: (context, index) {
        final pedido = _pedidos[index];
        /*final imageUrl = pedido['imagenchica'] != null
            ? 'https://servicios.campus.pe/${pedido['imagenchica']}'
            : 'https://servicios.campus.pe/imagenes/nofoto.jpg';*/

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PedidosDetailScreen(
                  pedidoId: pedido["idpedido"],
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Image.network(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),*/
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nombre: ${pedido["nombres"]}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text('Usuario: ${pedido["usuario"]}'),
                      Text('Fecha Pedido: ${pedido["fechapedido"]}'),
                      Text('ID Pedido: ${pedido["idpedido"]}'),
                      Text('Total: S/ ${pedido["total"]}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
