import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/model/task_model.dart';
import 'package:todo_app/shared/ui/app_color.dart';

class AddTaskSheet extends StatefulWidget {
  final TaskModel? taskModel;
  const AddTaskSheet({
    super.key,
    this.taskModel,
  });

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final titleController = TextEditingController();
  int? selectedDate;
  Future<void> addTask() async {
    Navigator.pop(
        context,
        TaskModel(
            title: titleController.text,
            dateEpoch: selectedDate,
            id: widget.taskModel?.id));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate == null
            ? DateTime.now()
            : DateTime.fromMillisecondsSinceEpoch(selectedDate!),
        firstDate: selectedDate == null
            ? DateTime.now()
            : DateTime.fromMillisecondsSinceEpoch(selectedDate!),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked.millisecondsSinceEpoch;
      });
    }
  }

  @override
  void initState() {
    final taskModel = widget.taskModel;
    if (taskModel != null) {
      titleController.text = widget.taskModel!.title;
      if (taskModel.dateEpoch != null) {
        selectedDate = taskModel.dateEpoch;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              autofocus: true,
              key: const Key('TextField'),
              controller: titleController,
              onChanged: (val) {
                setState(() {});
              },
              textInputAction: TextInputAction.send,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Task Name',
                  hintStyle:
                      textTheme.bodyText1?.copyWith(color: AppColors.shimmer)),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Chip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.border)),
                    label: Row(children: [
                      const Icon(
                        Icons.calendar_today_sharp,
                        size: 12,
                        color: AppColors.primaryMedium,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        selectedDate == null
                            ? 'Add date'
                            : DateFormat('MMM dd').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    selectedDate!)),
                        style: textTheme.subtitle2
                            ?.copyWith(color: AppColors.primaryMedium),
                      )
                    ]),
                  )),
              ElevatedButton(
                  key: const Key('SendButton'),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      elevation: 0,
                      shape: const CircleBorder(),
                      disabledBackgroundColor: AppColors.background,
                      backgroundColor: titleController.text.isEmpty
                          ? AppColors.background
                          : AppColors.primaryMedium),
                  onPressed: titleController.text.isEmpty
                      ? null
                      : () async {
                          addTask();
                        },
                  child: const Icon(
                    Icons.send,
                  ))
            ]),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ));
  }
}
