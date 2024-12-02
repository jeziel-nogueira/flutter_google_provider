import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../widgets/snackbar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading =
      false; // Variável para gerenciar o estado de carregamento do login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance
              .authStateChanges(), // Monitora o estado de autenticação
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Exibe um indicador de carregamento
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Erro ao carregar os dados. Tente novamente.',
                ),
              ); // Exibe uma mensagem de erro
            }
            return Body(snapshot.data);
          },
        ),
      ),
    );
  }

  Widget Body(User? user) {
    print(user);
    return Stack(
      children: [
        Image.asset(
          "assets/images/modernbg.jpg",
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                          //color: Colors.red,
                          ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.4),
                              Colors.white.withOpacity(0.1),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 2,
                            ),
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(1), // Border radius
                                child: ClipOval(
                                    child: Image.network(
                                        user!.photoURL.toString())),
                              ),
                            ),
                            Text(
                              user.displayName?.toUpperCase() ??
                                  'Nome não disponível',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              user.email ?? 'E-mail não disponível',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            SizedBox(
                              width: 250,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'I have a  ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset(
                                        "assets/images/google.png",
                                        height: 50,
                                        width: 70,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'account,',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        ' therefore ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        'I exist.',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white.withOpacity(0.4),
                                      Colors.white.withOpacity(0.1),
                                    ]),
                              ),
                              child: ListTile(
                                enabled: !isLoading,
                                leading: const Icon(
                                    Icons.login_rounded), // Ícone de logout
                                title: (!isLoading)
                                    ? const Center(
                                        child: Text(
                                          'Disconnect',
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                onTap: () async {
                                  setState(() {
                                    isLoading = true; // Ativa o carregamento
                                  });
                                  try {
                                    await AuthService()
                                        .signOut(); // Chama o serviço de logout
                                  } catch (e) {
                                    ShowSnackBar(
                                        context: context,
                                        message: e.toString());
                                  } finally {
                                    setState(() {
                                      isLoading =
                                          false; // Desativa o carregamento
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
