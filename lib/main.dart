import 'package:flutter/material.dart';
// Customizações de sistema, como orientação da tela e cor da barra de notificações
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/splash/my_splash.dart';

//TODO<Bug>: Se a cor de fundo for muito clara, o texto de notificações some
//TODO: Opção de aumentar e reduzir tamanho do texto
//TODO: Arrasta pra baixo pra recarregar dados
// RefreshIndicator faz isso
//TODO: confirmação de que algo foi salvo com um toast ou sei la
// https://pub.dev/packages/cherry_toast
// cherry cherry toast
//TODO: Ao criar conta, fornecer opção de ícone com base em contas comuns
// Caixa, BB, Nubank
//TODO: gerar gráficos das transações
//(https://medium.com/flutter/beautiful-animated-charts-for-flutter-164940780b8c)

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
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    // Para não usar o app com o smartphone na horizontal
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Ver sobre provider.
    // Basicamente, o widget pai de todos é o provedor do tema, que envia para
    // os filhos. Quando um muda, todos são notificados da mudança.
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
            // Definição do tema.
            // Facilita para não ter que definir cores de vários widgets.
            // As cores são importadas do ThemeProvider
            theme: ThemeData(
              // Cores principais
              primaryColor: theme.primaryColor,
              accentColor: theme.alterColor,
              highlightColor: theme.alterColor,
              hoverColor: theme.alterColor,
              // Cores de fundo
              backgroundColor: theme.backgroundColor,
              scaffoldBackgroundColor: theme.backgroundColor,
              // Cores do texto
              hintColor: theme.textColor,
              inputDecorationTheme: InputDecorationTheme(
                counterStyle: TextStyle(color: theme.textColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.alterColor, width: 1),
                ),
              ),
              textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: theme.textColor,
                    displayColor: theme.textColor,
                  ),
              // Cores de pop-ups
              dialogTheme: DialogTheme(
                backgroundColor: theme.backgroundColor,
                titleTextStyle: TextStyle(color: theme.textColor),
                contentTextStyle: TextStyle(color: theme.textColor),
              ),
              colorScheme: ColorScheme.light(
                primary: theme.primaryColor,
                onPrimary: theme.textColor,
                onSurface: theme.textColor,
                secondary: theme.alterColor,
              ),
              // Cores de outros itens
              scrollbarTheme: ScrollbarThemeData(
                trackColor: MaterialStateProperty.all(theme.backgroundColor),
                thumbColor: MaterialStateProperty.all(theme.alterColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
