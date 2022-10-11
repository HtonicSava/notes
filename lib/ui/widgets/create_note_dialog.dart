import 'package:flutter/material.dart';

class CreateNoteDialog extends StatefulWidget {
  const CreateNoteDialog({Key? key, required this.submitCallback})
      : super(key: key);

  final void Function(String title, String description) submitCallback;

  @override
  _CreateNoteDialogState createState() => _CreateNoteDialogState();
}

class _CreateNoteDialogState extends State<CreateNoteDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: Colors.transparent,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        height: MediaQuery.of(context).size.height / 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Column(
            children: [
              const Text('Создать заметку'),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Название'),
              ),
              TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(hintText: 'Описание')),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Отмена')),
                      TextButton(
                        onPressed: () {
                          if (_descriptionController.text.isEmpty ||
                              _titleController.text.isEmpty) {
                            return;
                          }
                          widget.submitCallback(_titleController.text,
                              _descriptionController.text);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Готово'),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
