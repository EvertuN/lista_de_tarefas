import 'package:aplicativo_de_lista/utilis/customColor.dart';
import 'package:flutter/material.dart';

import '../database/databaseOperations.dart';
import 'AppRoutes.dart';
import 'loginPage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
          'Cadastro',
          style: TextStyle(
            color: CustomColors.appbartextcolor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.appbartextcolor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.loginPage);
          },
        ),
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
                  await DatabaseOperationFirebase().createUserWithEmailPass(
                    context,
                    controllerEmail.text,
                    controllerPassword.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Criar conta',
                  style: TextStyle(color: CustomColors.appbartextcolor),
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
