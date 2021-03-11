import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:projeto_tcc/screens/telabase/splashscreen/splash_screen.dart';
import 'package:projeto_tcc/stores/category_store.dart';
import 'package:projeto_tcc/stores/home_store.dart';
import 'package:projeto_tcc/stores/page_store.dart';
import 'package:projeto_tcc/stores/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocators();
  runApp(MyApp());
}

void setupLocators() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(HomeStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoryStore());
}

Future<void> initializeParse() async {
  await Parse().initialize(
    'M4mIqwuCaq5xv2ASVGBSZOUQVNHSOzpfoLdiZyBG',
    'https://parseapi.back4app.com/',
    clientKey: 'HSR8q4aRcql9x6XiEw06ysHbv4ifOtgcRaWjG2fw',
    autoSendSessionId: true,
    debug: true,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trabalho ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.teal,
          appBarTheme: AppBarTheme(elevation: 15),
          cursorColor: Colors.black),
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: MyAppi(),
    );
  }
}
