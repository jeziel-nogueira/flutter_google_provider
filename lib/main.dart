import 'package:auth_sistem/pages/home_page.dart';
import 'package:auth_sistem/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  // Garantindo que os widgets estejam prontos para inicialização antes de chamar Firebase.initializeApp
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializando o Firebase com as configurações específicas da plataforma
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Executando o aplicativo
  runApp(
      const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // widget é a raiz do aplicativo
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Ocultando a faixa de debug
      home: ScreenRouter(),
    );
  }
}

// Widget ScreenRouter verifica o status de autenticação do usuário
class ScreenRouter extends StatelessWidget {
  const ScreenRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return const LoginPage();
          } else {
            return const HomePage();
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

