import 'package:flutter/material.dart';
import 'package:aplicativo_de_lista/homePage.dart';
import 'package:aplicativo_de_lista/utilis/customColor.dart';
import '../database/databaseOperations.dart';
import 'AppRoutes.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TextEditingController _taskController = TextEditingController();
  List<String> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final tasks = await DatabaseOperationFirebase().listTasksFirebase();
      setState(() {
        _tasks = tasks.cast<String>();
        _isLoading = false;
      });
    } catch (e) {
      print("Erro ao carregar tarefas: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addTask() async {
    try {
      if (_taskController.text.isNotEmpty) {
        await DatabaseOperationFirebase().addNewTaskFirebase(_taskController.text);
        setState(() {
          _tasks.add(_taskController.text);
        });
        _taskController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarefa adicionada!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Digite uma tarefa')),
        );
      }
    } catch (e) {
      print("Erro ao adicionar tarefa: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao adicionar tarefa')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Adicionar Tarefa',
          style: TextStyle(color: CustomColors.appbartextcolor),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.appbartextcolor,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.homePage);
          },
        ),
        elevation: 5,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
              TextFormField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'Digite aqui',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Column(
                children: [
                  ElevatedButton(
                    // onPressed: _addTask,
                    onPressed: () async {
                      await _addTask();
                      Navigator.pushReplacementNamed(context, AppRoutes.homePage);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Adicionar', style: TextStyle(color: CustomColors.appbartextcolor),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // if (_tasks.isNotEmpty)
                  //   ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: _tasks.length,
                  //     itemBuilder: (context, index) {
                  //       return ListTile(
                  //         title: Text(_tasks[index]),
                  //         trailing: IconButton(
                  //           icon: const Icon(Icons.delete),
                  //           onPressed: () async {
                  //             // await DatabaseOperationFirebase().deleteTaskFirebase(_tasks[index]);
                  //             // setState(() {
                  //             //   _tasks.removeAt(index);
                  //             // });
                  //             // ScaffoldMessenger.of(context).showSnackBar(
                  //             //   const SnackBar(content: Text('Tarefa removida!')),
                  //             // );
                  //           },
                  //         ),
                  //       );
                  //     },
                  //   )
                  // else
                  //   const Text('Nenhuma tarefa encontrada.'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
