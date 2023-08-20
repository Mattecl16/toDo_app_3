//managing tasks
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/db_helper.dart';
import 'package:todo_app/models/task_model.dart';

import '../utils/constants.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoState extends _$TodoState{
  @override
  List<Task> build(){
    return [];//returning an empty list
  }
  void refresh() async {
    //picking data from the database using the function we built
    final data = await DBHelper.getItems();

    state = data.map((e) => Task.fromJson(e)).toList();
  }
  
  void addItem(Task task) async {
    await DBHelper.createItem(task);
    refresh();
  }

 dynamic getRandomColor() {
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
 }

  void updateItem(
      int id, String title, String desc,
      int isCompleted, String date,
      String startTime, String endTime
      ) async {
    await DBHelper.updateItem(
        id,title,desc,isCompleted,
        date,startTime,endTime);
    refresh();
  }

  Future<void> deleteTodo(int id) async {
    await DBHelper.deleteItem(id);
    refresh();
  }

  void markAsCompleted(
      int id, String title, String desc,
      int isCompleted, String date,
      String startTime, String endTime
      ) async {
    await DBHelper.updateItem(
        id,title,desc,1,
        date,startTime,endTime);
    refresh();
  }
//today
  String getToday() {
    DateTime today = DateTime.now();

    return today.toString().substring(0,10);//getToday function returns today converted into a string
  }
//tomorrow
  String getTomorrow() {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));

    return tomorrow.toString().substring(0,10);//returns today converted into a string
  }

  String getDayAfter() {
    DateTime tomorrow = DateTime.now().add(Duration(days: 2));

    return tomorrow.toString().substring(0,10);//returns today converted into a string
  }


  List<String> last30days() {
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(const Duration(days: 30));

    List<String> dates = [];
    for (int i=0;i<30;i++) {
      DateTime date = oneMonthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0,10));

      }
    return dates;
  }

// //pigli data di oggi, torni indietro di un mese
// //da lì vai avanti con +1--> così hai tutti i 30 giorni passati
// //e li metti nella lista dates
// //a partire dalla data odierna

    //metti dentro isCompleted un booleano (prima era un int)
    bool getStatus(Task data) {
      bool? isCompleted;

      if(data.isCompleted==0){//if ==0 the task is not completed
          isCompleted = false;
      } else {
        isCompleted = true;
      }
      return isCompleted;
    }
  }


