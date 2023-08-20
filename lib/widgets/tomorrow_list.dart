import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/todo/add.dart';
import 'package:todo_app/todo/todo_provider.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/appstyle.dart';
import 'package:todo_app/widgets/custome_text.dart';
import 'package:todo_app/widgets/reusable_text.dart';
import 'package:todo_app/widgets/todo_tile.dart';
import 'package:todo_app/widgets/xpansion_tile.dart';
import 'package:todo_app/xpansion_provider.dart';

import '../todo/UpdateTask.dart';
import '../widgets/todayTask.dart';

class TomorrowList extends ConsumerWidget {
  const TomorrowList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    var color = ref.read(todoStateProvider.notifier).getRandomColor();
    String tomorrow = ref.read(todoStateProvider.notifier).getTomorrow();
    //list:
    var tomorrowTasks = todos.where((element) => element.date!.contains(tomorrow));
    return  XpansionTile(
        text: "Tomorrow's Task",
        text2: "Tomorrow's tasks are shown here",
        onExpansionChanged: (bool expanded) {
          ref.read(xpansionStateProvider.notifier).setStart(!expanded); //not expanded
        },
        trailing:
        Padding(
          padding: EdgeInsets.only(right: 12.0.w),
          child: ref.watch(xpansionStateProvider)
              ?
          const Icon(AntDesign.circledown)
              :const Icon(AntDesign.closecircleo),
        ),
        children: [
          //accessing the list with a for
          for(final todo in tomorrowTasks)
          TodoTile(
            title: todo.title,
            description: todo.desc,
            color: color,
            start: todo.startTime,
            end: todo.endTime,
              delete: (){
                ref.read(todoStateProvider.notifier).deleteTodo(todo.id ?? 0);
              },
              editWidget: GestureDetector(onTap: (){
                titles = todo.title.toString();
                descs = todo.desc.toString();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UpdateTask(id: todo.id??0,)));
                },
                child: const Icon(MaterialCommunityIcons.circle_edit_outline),
              ),
                switcher: const SizedBox.shrink(),

            ),

        ]);
  }
}
