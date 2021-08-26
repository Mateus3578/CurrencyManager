import 'package:flutter/material.dart';
// Customizações de sistema, como orientação da tela e cor da barra de notificações
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:currency_manager/controllers/money_provider.dart';
import 'package:currency_manager/controllers/theme_provider.dart';
import 'package:currency_manager/views/custom/default_theme.dart';
import 'package:currency_manager/views/splash/my_splash.dart';

//TODO: Testar editar/deletar contas/transações e conferir o reflexo nos saldos.
//TODO: Transferência entre contas
//TODO: Cartões de crédito
//TODO: Trocar ícone launcher
//TODO: Opção para sempre mostrar o saldo
//TODO: Opção para mostar/esconder/customizar cards
//TODO: Opção de aumentar e reduzir tamanho do texto
//TODO: Opção de ícone com base em contas comuns
// Caixa, BB, Nubank etc
//TODO: Opção para fazer backup dos dados
//TODO: Dar funcionalidade para despesa fixa e repetível
//TODO: Notificação no dia da despesa fixa
//TODO: Tags
//TODO: Filtro para tags
//TODO: Exportar gráficos/dados
//TODO: Tutorial de uso do app
//TODO: Guia na primeira vez que o app for aberto

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
    return MultiProvider(
      // Os providers são inicializados aqui
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<MoneyProvider>(
          create: (_) => MoneyProvider(),
        ),
      ],
      // O widget pai (MaterialApp) é um consumidor, que passa para os filhos.
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
                // Suporte melhor para português, principalmente em datas
                supportedLocales: [Locale("pt", "BR"), Locale("en", "")],
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
              );
            },
          );
        },
      ),
    );
  }
}
