import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/src/components/heading_image.dart';
import 'package:myapp/src/screens/content/paises_screen.dart';
import 'package:myapp/src/screens/content/pedidos_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:myapp/src/utils/dimensions.dart';

class OpcionesScreen extends StatelessWidget {
  const OpcionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              const HeadingImage(
                  imagePath: 'assets/images/logo_opciones.png',
                  title: 'Iniciar'),
              Text(
                'Opciones',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Padding(
                padding: EdgeInsets.all(Dimensions.largePadding),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut molestie nisl nec elit vestibulum efficitur. Mauris a tincidunt turpis, vitae sagittis neque. Integer porttitor, dolor eu tristique porttitor, arcu est semper sapien, et pellentesque nisl mi a magna.',
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PedidosScreen(pedidoId: '',)));
                      },
                      child: const Text("Pedidos")),
                  const SizedBox(
                    width: Dimensions.smallPadding,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PaisesScreen()));
                      },
                      child: const Text("Países")),
                ],
              )
            ])),
      ),
    );
  }
}
