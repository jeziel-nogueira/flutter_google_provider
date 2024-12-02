import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }

  Future<String?> setPersistence() async {
    try {
      // Garantir persistencia do Login, default: Persistence.LOCAL
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL); // Persistência padrão
      // Opcoes: Persistence.SESSION ou Persistence.NONE
      return null;
    } catch (e) {
      return 'Error Setting Persistence: $e';
    }
  }

  Future<String?> signInWithGoogle() async {


    try {
      // Tenta configurar a persistência antes do login
      final persistence = await setPersistence();
      // Em caso de erro, retorna o mesmo
      if(persistence != null){
        return persistence;
      }

      // iniciar processo de autenticação
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // se usuario cancelar o login
      if (googleUser == null) {
        return "Canceled by User";
      }

      // Obter detalhes da autenticação
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // validar tokens
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        return "Erro: Falha ao obter as credenciais do Google.";
      }

      // criar credencial para o Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // autenticar com o Firebase
      await _firebaseAuth.signInWithCredential(credential);
      return null;

    } on FirebaseAuthException catch (e) {
      // captura erros específicos do FirebaseAuth
      switch (e.code) {
        case 'account-exists-with-different-credential':
          return 'A conta já existe com outro método de autenticação.';
        case 'invalid-credential':
          return 'Credencial inválida ou expirada.';
        case 'user-disabled':
          return 'Conta desativada.';
        case 'operation-not-allowed':
          return 'O provedor Google não está habilitado no Firebase Console.';
        case 'network-request-failed':
          return 'Problema de conexão de rede.';
        default:
          return 'Erro Firebase: ${e.message}';
      }

    } on PlatformException catch (e) {
      // captura erros da plataforma
      if(e.code == 'network_error'){
        return 'Erro PlatformException: ${e.message}';
      }
      return e.message;
    } catch (e) {
      // erros desconhecidos,
      return 'Unexpected Error: $e';
    }
  }
}
