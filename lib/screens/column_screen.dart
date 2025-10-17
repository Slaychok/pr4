import 'package:flutter/material.dart';
import 'package:pr4/models/list_item.dart';

class ColumnScreen extends StatefulWidget {
  const ColumnScreen({super.key});

  @override
  State<ColumnScreen> createState() => _ColumnScreenState();
}

class _ColumnScreenState extends State<ColumnScreen> {
  final List<ListItem> _tasks = [];
  final _textController = TextEditingController();

  void _addTask() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _tasks.add(ListItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: text,
      ));
      _textController.clear();
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Расходы - Column')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Введите расход',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Добавить'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _tasks.isEmpty
                ? const Center(child: Text('Нет расходов'))
                : SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < _tasks.length; i++)
                    ListTile(
                      title: Text(_tasks[i].title),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeTask(i),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}