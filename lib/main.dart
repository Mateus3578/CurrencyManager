import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/splash/my_splash.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(),
          ),
        ],
        child: StartApp(),
      ),
    );

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Barra de notificações transparente
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        //statusBarIconBrightness: Brightness.dark,
        //systemNavigationBarColor: Theme.of(context).primaryColor,
        //systemNavigationBarDividerColor: Theme.of(context).primaryColor,
      ),
    );
    // Para não usar o app com o smartphone na horizontal
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider<ThemeProvider>(
      create: (BuildContext context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, theme, __) {
          return MaterialApp(
            home: MySplash(theme),
            // Sim, falta um nome
            title: "{insert_name}",
            // Tira a marca d´agua de debug
            debugShowCheckedModeBanner: false,
            // Definição do tema
            theme: ThemeData(
              primaryColor: theme.primaryColor,
              accentColor: theme.alterColor,
              backgroundColor: theme.backgroundColor,
              scaffoldBackgroundColor: theme.backgroundColor,
              hintColor: theme.textColor,
              inputDecorationTheme: InputDecorationTheme(
                counterStyle: TextStyle(color: theme.textColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.alterColor, width: 1),
                ),
              ),
              dialogTheme: DialogTheme(
                backgroundColor: theme.backgroundColor,
                titleTextStyle: TextStyle(color: theme.textColor),
                contentTextStyle: TextStyle(color: theme.textColor),
              ),
              colorScheme: ColorScheme.light(
                primary: theme.primaryColor,
                onPrimary: theme.textColor,
                onSurface: theme.textColor,
              ),
              textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: theme.textColor,
                    displayColor: theme.textColor,
                  ),
            ),
          );
        },
      ),
    );
  }
}

//TODO: Impedir/remediar o usuário que colocar a cor do texto e fundo iguais
//TODO<Bug>: Se a cor de fundo for muito clara, o texto de notificações some
//TODO: confirmação de que algo foi salvo com um toast ou sei la
//TODO: gerar gráficos das transações 
//(https://medium.com/flutter/beautiful-animated-charts-for-flutter-164940780b8c)