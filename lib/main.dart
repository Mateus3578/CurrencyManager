import 'package:flutter/material.dart';
// Customizações de sistema, como orientação da tela e cor da barra de notificações
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tc/controllers/money_provider.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/custom/default_theme.dart';
import 'package:tc/views/splash/my_splash.dart';

//TODO: Considerar transformar os saldos em consumers de um provider, para atualizar tudo ao mudar.
//TODO: Opção para sempre mostrar o saldo
//TODO<Bug>: Se a cor de fundo for muito clara, o texto de notificações some
//TODO: Opção de aumentar e reduzir tamanho do texto
//TODO: Arrastar pra baixo pra recarregar dados
// RefreshIndicator() faz isso (provavelmente)
//TODO: confirmação de que algo foi salvo com um toast ou sei la
// https://pub.dev/packages/cherry_toast
//TODO: Ao criar conta, fornecer opção de ícone com base em contas comuns
// Caixa, BB, Nubank etc
//TODO: gerar gráficos das transações
//(https://medium.com/flutter/beautiful-animated-charts-for-flutter-164940780b8c)

void main() => runApp(StartApp());

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

    // https://pub.dev/packages/provider.
    // Basicamente, o widget pai de todos é o provedor do tema, que o envia para
    // os filhos. Quando uma coisa mudar é só notificar da mudança.
    // A main é um consumer porque o splash carrega os dados.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<MoneyProvider>(
          create: (_) => MoneyProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, __) {
          return Consumer<MoneyProvider>(
            builder: (context, money, __) {
              return MaterialApp(
                home: MySplash(theme: theme, money: money),
                // Sim, falta um nome
                title: "{insert_name}",
                // Tira a marca d´agua de debug
                debugShowCheckedModeBanner: false,
                // Definição do tema.
                // Facilita para não ter que definir algumas cores.
                theme: getDefaultTheme(theme),
              );
            },
          );
        },
      ),
    );
  }
}
