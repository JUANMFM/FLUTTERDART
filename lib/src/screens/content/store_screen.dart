import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/src/screens/content/products_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:myapp/src/utils/app_colors.dart';
import 'dart:convert';
import 'package:myapp/src/utils/dimensions.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  List<dynamic> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final response =
        await http.get(Uri.parse('https://servicios.campus.pe/categorias.php'));
    final List<dynamic> data = json.decode(response.body);
    setState(() {
      // ignore: avoid_print
      print(data);
      data.sort((a, b) =>
          int.parse(a["idcategoria"]).compareTo(int.parse(b["idcategoria"])));
      _categories = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Categorías'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
            child: _categories.isEmpty
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return GestureDetector(
                          onTap: () {
                            // ignore: avoid_print
                            print('ID: ${category["idcategoria"]}');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductsScreen(
                                          categoryId: category["idcategoria"],
                                        )));
                          },
                          child: Stack(children: [
                            Positioned.fill(
                              child: Image.network(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  'https://servicios.campus.pe/' +
                                      category['foto'],
                                  fit: BoxFit.cover),
                            ),
                            Positioned.fill(
                                child: Container(
                              color: AppColors.onSurface.withOpacity(0.6),
                            )),
                            Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.mediumPadding),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Text(category["idcategoria"],
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge
                                              ?.copyWith(
                                                  color: AppColors.onPrimary)),
                                    ),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Text(category["nombre"],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge
                                                  ?.copyWith(
                                                      color:
                                                          AppColors.onPrimary)),
                                          Text(category["descripcion"],
                                              style: const TextStyle(
                                                  color: AppColors.onPrimary))
                                        ]))
                                  ],
                                ))
                          ]));
                    },
                  )),
      ),
    );
  }
}
