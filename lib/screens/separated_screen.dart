import 'package:flutter/material.dart';
import 'package:pr4/models/list_item.dart';

class SeparatedScreen extends StatefulWidget {
  const SeparatedScreen({super.key});

  @override
  State<SeparatedScreen> createState() => _SeparatedScreenState();
}

class _SeparatedScreenState extends State<SeparatedScreen> {
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
      appBar: AppBar(title: const Text('Расходы - ListView.separated')),
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
                : ListView.separated(
              itemCount: _tasks.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_tasks[index].title),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeTask(index),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}