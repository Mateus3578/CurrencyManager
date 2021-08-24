import 'package:flutter/material.dart';
// Customizações de sistema, como orientação da tela e cor da barra de notificações
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:currency_manager/controllers/money_provider.dart';
import 'package:currency_manager/controllers/theme_provider.dart';
import 'package:currency_manager/views/custom/default_theme.dart';
import 'package:currency_manager/views/splash/my_splash.dart';

//TODO: Testar editar/deletar contas/transações e conferir o reflexo nos saldos.
//TODO: Transferência entre contas
//TODO: Cartões de crédito

//TODO: Tema Nubank
//TODO: Trocar ícone launcher

//TODO <Bug>: no delay da animação do ícone

//TODO: Opção para sempre mostrar o saldo
//TODO: Opções para customizar os gráficos
//TODO: Opção de aumentar e reduzir tamanho do texto
//TODO: Animação no botão de salvar ao salvar
//TODO: Ao criar conta, fornecer opção de ícone com base em contas comuns
// Caixa, BB, Nubank etc
//TODO: Opção para fazer backup do app

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
