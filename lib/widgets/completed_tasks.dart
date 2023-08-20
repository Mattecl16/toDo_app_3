import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/todo_tile.dart';

import '../todo/todo_provider.dart';
import '../utils/constants.dart';

class CompletedTask extends ConsumerWidget {
  const CompletedTask({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listData = ref.watch(todoStateProvider);
    List lastMonth = ref.read(todoStateProvider.notifier).last30days();
    var completedList = listData.where((element)
    => element.isCompleted == 1 || lastMonth.contains(element.date!.substring(0, 10))).toList();
    return ListView.builder(
        itemCount: completedList.length, itemBuilder: (context, index) {
      final data = completedList[index];
      //if isCompleted == 0 the boolean is set to false, otherwise it is set to true
      bool isCompleted = ref.read(todoStateProvider.notifier).getStatus(data);

      dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();

      return TodoTile(
        delete: (){
          ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
        },
        editWidget: const SizedBox.shrink(),
        title: data.title,
        color: AppConst.kGreen,
        description: data.desc,
        start: data.startTime,
        end: data.endTime,
        switcher: const Icon(AntDesign.checkcircle, color: AppConst.kGreen),

      );
    });
  }
}
