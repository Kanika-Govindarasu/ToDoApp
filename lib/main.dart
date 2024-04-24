import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todos = [];
  final TextEditingController _textControl = TextEditingController();
  final TextEditingController _edittextControl = TextEditingController();

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: Container(
            height: 100,
            child: Column(
              children: [
                TextField(
                  controller: _textControl,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      todos.add(_textControl.text);
                    });
                    _textControl.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editTodo(String previous, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        _edittextControl.text = previous;
        return AlertDialog(
          title: Text('Edit Todo'),
          content: Container(
            height: 100,
            child: Column(
              children: [
                TextField(
                  controller: _edittextControl,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      todos[index] = _edittextControl.text;
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(50), // Circle corners
              ),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(50), // Circle corners
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(todos[index]),
                      IconButton(
                        onPressed: () {
                          _editTodo(todos[index], index);
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        todos.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.blue,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Add',
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
