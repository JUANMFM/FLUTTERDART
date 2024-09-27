import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PedidosDetailScreen extends StatefulWidget {
  final String pedidoId;
  const PedidosDetailScreen({super.key, required this.pedidoId});

  @override
  _PedidosDetailScreenState createState() => _PedidosDetailScreenState();
}

class _PedidosDetailScreenState extends State<PedidosDetailScreen> {
  List<dynamic> _productos = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(
          'https://servicios.campus.pe/pedidosdetalle.php?idpedido=${widget.pedidoId}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List && data.isNotEmpty) {
          setState(() {
            _productos = data;
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'No se encontraron productos para este pedido.';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage =
              'Error al obtener los detalles del pedido: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener los detalles del pedido: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de pedido'),
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
              : _buildProductosList(),
    );
  }

  Widget _buildProductosList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal, // Permitir desplazamiento horizontal
      itemCount: _productos.length,
      itemBuilder: (context, index) {
        final producto = _productos[index];
        final imageUrl =
            'https://servicios.campus.pe/${producto['imagenchica']}';

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: SizedBox(
            width:
                250, // Ancho fijo para cada producto en el carrusel horizontal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        producto['nombre'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text('Cantidad: ${producto['cantidad']}'),
                      Text('Precio: S/ ${producto['precio']}'),
                      Text('Detalle: ${producto['detalle']}'),
                      Text('Idpedido: ${producto['idpedido']}'),
                      Text('Idproducto: ${producto['idproducto']}'),
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
