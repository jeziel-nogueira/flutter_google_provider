# Autenticação com Firebase e Google no Flutter
![Android Studio](https://img.shields.io/badge/android%20studio-346ac1?style=for-the-badge&logo=android%20studio&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-a08021?style=for-the-badge&logo=firebase&logoColor=ffcd34)
![Google](https://img.shields.io/badge/google-4285F4?style=for-the-badge&logo=google&logoColor=white)

# Objetivo do Projeto
Este projeto tem como objetivo implementar um aplicativo Flutter que realiza autenticação de usuários utilizando o provedor de autenticação Google via Firebase. O app oferece uma interface simples com login, exibição de informações do usuário autenticado e logout, alinhado aos requisitos técnicos e funcionais de uma atividade avaliativa acadêmica.

![app_2](https://github.com/user-attachments/assets/05bde36d-26cc-4fc1-8dad-c4e58c84e1fa)
![app_1](https://github.com/user-attachments/assets/b68663a3-17cc-4037-8241-b69fd12a6dba)

## Funcionalidades do Aplicativo
**Tela de Login**
   - Botão para autenticação via Google.
   - Tenta autenticar no banco através do UserCredential e redireciona para a tela Home.   
   - Persistência de login, permitindo que o usuário continue conectado mesmo ao reiniciar o app.

**Tela Home**
   - Exibição de informações do usuário autenticado (quando disponível):
     - Nome
     - E-mail
     - Foto de perfil
   - Botão para desconectar o usuário e retornar para a tela de login.

## Erros Tratados
   Em caso de erro de alguma funcionalidade, possui os seguintes tratamentos:
   - 'account-exists-with-different-credential': A conta já existe com outro método de autenticação.
   - 'invalid-credential': Credencial inválida ou expirada.
   - 'user-disabled': Conta desativada.
   - 'operation-not-allowed': O provedor Google não está habilitado no Firebase Console.
   - 'network-request-failed': Problema de conexão de rede.
   - default: para outros erros inesperados

## Dependências utilizadas
  - firebase_core: ^3.8.0
  - google_sign_in: ^6.2.2
  - firebase_auth: ^5.3.3
   
## Estrutura de Pastas
      
```lib/
│
├── main.dart               # Arquivo principal
├── services/
|    └── auth/
│       ├── auth_service.dart   # Lógica de autenticação
│
├── pages/
│   ├── login_screen.dart   # Tela de login
│   ├── home_screen.dart    # Tela home
│
├── widgets/
│   ├── snackbar_widget.dart # Componente reutilizável para feedback visual
│
└── assets/
    └── images/             # Recursos de imagem como ícones e backgrounds
```

## Instruções de Configuração do projeto
### Pré-requisitos:
  - Flutter SDK: versão 3.24.3 ou superior
  - Dart SDK: versão X.X.X

### Configuração Firebase:
  - Crie um novo projeto Android com Flutter.
  - Adicione o Firebase ao projeto para Android, [referência](https://firebase.google.com/docs/android).
  - Configure a autenticação Google do app, [referência](https://firebase.google.com/docs/auth/android/google-signin).
  - Lembre de baixar o arquivo google-services.json do seu provedor configurado e adicionar na pasta android/app.

### Executar o projeto:
  - Clone o repositório:
    ```
    git clone https://github.com/jeziel-nogueira/flutter_google_provider.git
    ```
  - Instale as dependências:
    ```
    flutter pub get
    ```
  - Execute o aplicativo:
    ```
    flutter run
    ```    
