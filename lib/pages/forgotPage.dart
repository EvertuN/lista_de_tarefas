import 'package:flutter/material.dart';
import '../homePage.dart';
import '../utilis/customColor.dart';
import 'AppRoutes.dart';
import 'loginPage.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(73, 144, 252, 1),
        centerTitle: true,
        title: const Text(
          'Recuperar Senha',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
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
              const Text(
                "Informe seu e-mail para recuperar a senha:",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
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
              // TextButton(
              //   style: ButtonStyle(
              //       backgroundColor:
              //       MaterialStateProperty.all<Color>(Colors.blue),
              //       foregroundColor:
              //       MaterialStateProperty.all<Color>(Colors.white),
              //       minimumSize:
              //       MaterialStateProperty.all<Size>(const Size(500, 50)),
              //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //         RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(50.0),
              //         ),
              //       )),
              //   onPressed: () {
              //     // print('Botão Cadastrar pressionado!');
              //     // DatabaseOperationFirebase().insertRowSupabase(
              //     //     controllerEmail.text,
              //     // );
              //     Navigator.pushNamed(context, AppRoutes.homePage);
              //   },
              //   child: const Text(
              //     'Recuperar',
              //     style: TextStyle(fontSize: 17),
              //   ),
              // )
              ElevatedButton(
                onPressed: () async {
                  //     print('Botão Cadastrar pressionado!');
                  //     DatabaseOperationFirebase().insertRowSupabase(
                  //          controllerEmail.text,
                  //     );
                  Navigator.pushReplacementNamed(context, AppRoutes.homePage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Recuperar', style: TextStyle(color: CustomColors.textColor),
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
