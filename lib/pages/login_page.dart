import 'dart:ui';

import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../widgets/snackbar_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // variável para estado de carregamento do login
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  width: 350,
                  height: 250,
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5,
                          sigmaY: 5,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/google.png",
                                height: 50,
                                width: 130,
                                fit: BoxFit.cover,
                              ),
                              const Text(
                                'Google Auth Demo',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2,),
                              const Text(
                                'To continue, use a Google account.',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
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
                                  leading: Image.asset(
                                    "assets/icons/google_icon.png",
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  title: (!isLoading)
                                      ? const Center(
                                          child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Continue With Google',
                                              style: const TextStyle(
                                                color: Colors.black38,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ))
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                  onTap: isLoading ? null : () async {
                                    setState(() {
                                      isLoading = true; // Ativa o carregamento
                                    });
                                    try {
                                      final response = await AuthService().signInWithGoogle();
                                      print(response);
                                      if(response != null){
                                        ShowSnackBar(context: context, message: response);
                                      }

                                    }
                                    catch (e){
                                      ShowSnackBar(context: context, message: e.toString());
                                    }
                                    finally {
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
      ),
    );
  }
}
