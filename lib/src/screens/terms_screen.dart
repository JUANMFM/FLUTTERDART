import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:myapp/src/utils/app_colors.dart';
import 'package:myapp/src/utils/dimensions.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light
    ));
    return MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
            body: SafeArea(
                child: Padding(
          padding: const EdgeInsets.all(Dimensions.mediumPadding),
          child: Column(children: [
            Text(
              'Términos y condiciones',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: Dimensions.mediumPadding,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sollicitudin quam maximus nibh vehicula, non hendrerit massa venenatis. Sed quis imperdiet erat. Etiam vitae nibh consectetur, faucibus nisl non, egestas mi. Maecenas accumsan dui augue, at suscipit ipsum elementum sit amet. Sed tortor ex, consectetur a diam a, ornare condimentum ante. Quisque eu tellus turpis. Donec eleifend, urna facilisis efficitur laoreet, elit risus lobortis sem, sit amet hendrerit leo urna pulvinar lacus. Ut consequat enim metus, sed tincidunt mi aliquam a. Aliquam lectus dui, iaculis non enim at, luctus placerat leo. Vestibulum sit amet purus enim. Vestibulum luctus, metus ac condimentum laoreet, dolor nunc elementum eros, non sagittis felis leo non dui. Sed laoreet orci urna, in fringilla diam viverra sed. Nunc tincidunt ante ac vestibulum ullamcorper. In sagittis purus neque, a mattis nunc tincidunt ut. Vestibulum sit amet felis viverra, cursus neque sagittis, placerat massa.'
                      '\n\n'
                      'Maecenas ex mi, pulvinar et elementum quis, elementum at nisi. Vivamus fermentum feugiat erat non porta. Donec non porttitor dui. Etiam diam nisl, ultrices eu enim non, tempus vehicula magna. Cras porta sed dui in sollicitudin. Nulla cursus, turpis vitae facilisis faucibus, eros turpis tempor mauris, ut congue nisl diam eget sapien. Pellentesque eros erat, condimentum id urna sed, fermentum hendrerit neque. Nunc varius leo ut lacinia sodales. Quisque sed egestas odio, vel sollicitudin tortor. Maecenas ac sodales tortor. Suspendisse varius ipsum sit amet enim accumsan, ornare tincidunt orci accumsan. Ut sit amet mollis ligula, quis tincidunt massa. Ut nunc massa, tempus id orci vel, aliquet dignissim felis. Vivamus hendrerit ipsum facilisis lacus fermentum tristique.'
                      '\n\n'
                      'Donec dictum, libero nec volutpat semper, leo turpis vulputate ligula, id eleifend neque urna et mauris. Curabitur at sapien vestibulum, consequat tellus quis, congue lectus. Nam mattis interdum tincidunt. Praesent risus eros, pharetra at nisi a, interdum semper tortor. Sed dictum eros vel libero dignissim vulputate. Mauris in placerat nibh, vel scelerisque mi. Ut fermentum aliquet nisi quis tristique. In sit amet dignissim lacus. Aliquam sapien tellus, efficitur sit amet nibh sed, blandit euismod eros. Aenean et mi vehicula, tempor urna eget, mattis enim. Sed condimentum sit amet elit vitae pharetra. In ac ex porttitor, bibendum mi ut, ullamcorper mauris. Sed nec nibh condimentum, auctor quam ut, volutpat nisl. Vestibulum maximus sollicitudin nulla, sit amet pretium nulla sagittis ac.'
                      '\n\n'
                      'Integer arcu urna, viverra at congue in, ornare nec massa. Quisque vulputate ultrices orci, sed malesuada risus sodales ac. Pellentesque faucibus bibendum hendrerit. Nam tincidunt vel mi pulvinar ultricies. Fusce tempus scelerisque nunc, eu vehicula enim. Nullam euismod sodales eleifend. Sed iaculis ante metus, vel faucibus est pellentesque a. Sed fermentum purus ex, sit amet faucibus risus porta id. In ultricies turpis dolor, at pulvinar mi lacinia et. Ut at lacus a purus condimentum laoreet quis eu nunc. Mauris non tempus elit.'
                      '\n\n'
                      'Sed facilisis eros massa, non porta nisi iaculis eget. Integer pulvinar id risus ut mollis. Donec id magna iaculis, imperdiet sem a, scelerisque dui. Quisque eget laoreet ex. Sed non urna congue, rhoncus nulla vitae, blandit urna. Suspendisse nec diam mi. Fusce eu nulla lacus.'
                      '\n\n'
                      'Etiam eleifend nunc id libero feugiat molestie. Duis accumsan odio metus, at vestibulum massa viverra ut. Proin ex dui, tincidunt non nisl ut, eleifend cursus dui. Nulla vel libero sed urna posuere tincidunt eu non elit. Fusce at tellus quis turpis sagittis dictum. Integer vel magna posuere, pharetra massa convallis, lobortis est. Praesent maximus dui nec dolor imperdiet, sit amet fringilla erat facilisis. Integer quis purus elit. Aliquam sem velit, ornare eget sapien sed, venenatis fringilla mi. Nunc vitae lobortis turpis. Pellentesque condimentum est enim, nec consectetur nibh laoreet eget. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; In luctus odio eget rutrum pretium.'),
                  const SizedBox(
                    height: Dimensions.mediumPadding,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); //Cierra la ventana
                      },
                      child: const Text('Cerrar')),
                  const SizedBox(
                    height: Dimensions.xLargePadding,
                  ),
                ],
              ),
            )),
          ]),
        ))));
  }
}
