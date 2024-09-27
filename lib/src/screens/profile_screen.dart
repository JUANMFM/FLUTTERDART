import 'package:flutter/material.dart';
import 'package:myapp/src/screens/splash_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _eliminarDato(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("datos");
        Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SplashScreen()));

  }

  void _mostrarAlerta(BuildContext context) async {
    showDialog(context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Cerrar sesión"),
        content: Text("¿Está seguro que desea cerrar la sesión?"),
        actions: [
          TextButton(onPressed: () {
            _eliminarDato(context);
          }, child: Text("Sí")),
          TextButton(onPressed: () {
            Navigator.of(context).pop(false);
          }, child: Text("No"))
          
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: Center(
            child: Column(
              children: [
                const Text("Perfil"),
                ElevatedButton(onPressed: (){
                  _mostrarAlerta(context);
                }, child: const Text("Cerrar sesión"))
              ],
            )
            )));
  }
}
