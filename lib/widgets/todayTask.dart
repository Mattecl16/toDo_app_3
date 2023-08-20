import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/todo_tile.dart';

import '../todo/UpdateTask.dart';
import '../todo/todo_provider.dart';
import '../utils/constants.dart';

class TodayTasks extends ConsumerWidget {
  const TodayTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listData = ref.watch(todoStateProvider);
    var today = ref.read(todoStateProvider.notifier).getToday();
    var todayList = listData.where((element)
    => element.isCompleted == 0 && element.date!.contains(today)).toList();
    return ListView.builder(
        itemCount: todayList.length, itemBuilder: (context, index) {
      final data = todayList[index];
      //if isCompleted == 0 the boolean is set to false, otherwise it is set to true
      bool isCompleted = ref.read(todoStateProvider.notifier).getStatus(data);

      dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();

      return TodoTile(
        delete: (){
          ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
        },
        editWidget: GestureDetector(
          onTap: (){
            titles = data.title.toString();
            descs = data.desc.toString();
            Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UpdateTask(id: data.id??0,)));
          },
          child: const Icon(MaterialCommunityIcons.circle_edit_outline),
        ),
        title: data.title,
        color: AppConst.kGreen,
        description: data.desc,
        start: data.startTime,
        end: data.endTime,
        switcher: Switch(
            value: isCompleted,
            onChanged: (value) {
                ref.read(todoStateProvider.notifier).markAsCompleted(
                    data.id??0,
                    data.title.toString(),
                    data.desc.toString(),
                    1,
                    data.date.toString(),
                    data.startTime.toString(),
                    data.endTime.toString());
                ref.read(todoStateProvider.notifier).markAsCompleted(
                    data.id??0,
                    data.title.toString(),
                    data.desc.toString(),
                    1,//isCompleted
                    data.date.toString(),
                    data.startTime.toString(),
                    data.endTime.toString());
            }),
      );
    });
  }
}
