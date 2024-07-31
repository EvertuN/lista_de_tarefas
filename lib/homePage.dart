import 'package:aplicativo_de_lista/pages/AppRoutes.dart';
import 'package:aplicativo_de_lista/utilis/customColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'database/databaseOperations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tarefas = [];
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    verificarAutenticacao();
  }

  Future<void> verificarAutenticacao() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await buscarTarefas();
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
    }
  }

  Future<void> buscarTarefas() async {
    try {
      List<String>? listarTarefas = [];
      listarTarefas =
          (await DatabaseOperationFirebase().listTasksFirebase()).cast<String>();
      setState(() {
        tarefas = listarTarefas!;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Erro ao buscar tarefas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Lista de Tarefas',
          style: TextStyle(
            color: CustomColors.appbartextcolor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
                onTap: () async {
                  DatabaseOperationFirebase().logoutEmailPass(context);
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
                },
                child: const Icon(Icons.logout, color: CustomColors.appbartextcolor,)),
          ),
        ],
        elevation: 5,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
      //     : tarefas.isEmpty
      //     ? const Center(
      //   child: Text('Nenhuma tarefa encontrada.'),
      // )
          : Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.secondarytextColor,
                minimumSize: const Size(400, 50),
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(15))),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.taskList);
              },
              child: const Text(
                'Adicionar Tarefa',
                style: TextStyle(
                    color: CustomColors.appbartextcolor, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: ListTile(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                      tileColor: CustomColors.primaryColor,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: CustomColors.appbartextcolor,
                        ),
                        onPressed: () {
                          // _editarNomeDialog(pessoas[index], index);
                        },
                      ),
                      title: Text(
                        tarefas[index],
                        style: const TextStyle(
                            color: CustomColors.appbartextcolor, fontSize: 20),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: CustomColors.appbartextcolor,
                        ),
                        onPressed: () {
                          // excluirUsuario(pessoas[index]);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
