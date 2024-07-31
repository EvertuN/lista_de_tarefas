import 'package:aplicativo_de_lista/pages/signUpPage.dart';
import 'package:flutter/material.dart';
import '../database/databaseOperations.dart';
import '../utilis/customColor.dart';
import 'AppRoutes.dart';
import 'forgotPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        centerTitle: true,
        title: const Text(
          'Faça seu login',
          style: TextStyle(
            color: CustomColors.appbartextcolor,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              TextField(
                controller: controllerEmail,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controllerPassword,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  await DatabaseOperationFirebase().signInWithEmailPass(
                    context,
                    controllerEmail.text,
                    controllerPassword.text,
                  );
                  //  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //      content: Text('Logado com sucesso!')));
                  // Navigator.pushReplacementNamed(context, AppRoutes.homePage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Entrar', style: TextStyle(color: CustomColors.appbartextcolor),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                    )),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signUpPage);
                },
                child: const Text(
                  'Criar uma nova conta',
                  style: TextStyle(fontSize: 17, color: CustomColors.appbartextcolor),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                    )),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.forgotPage);
                },
                child: const Text(
                  'Esqueci minha senha',
                  style: TextStyle(fontSize: 17, color: CustomColors.appbartextcolor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  //final Icon icon;
  final String campo;
  final TextEditingController controlador;

  const CustomTextFormField({
    super.key,
    //required this.icon,
    required this.campo,
    required this.controlador,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      decoration: InputDecoration(
        labelText: campo,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
