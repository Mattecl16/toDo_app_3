import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/code_provider.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/appstyle.dart';
import 'package:todo_app/widgets/reusable_text.dart';

class TestPage extends ConsumerWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String code = ref.watch(codeStateProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [

            ReusableText(
              text: code,
              style: appstyle(39, AppConst.kLight, FontWeight.bold),),
            TextButton(
              onPressed: (){
                ref.read(codeStateProvider.notifier).setStart("Hello");
              },
              child: Text("Press Me"))],
        ),
      ),
    );
  }
}
