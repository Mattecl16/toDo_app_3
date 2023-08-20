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
import 'package:todo_app/widgets/completed_tasks.dart';
import 'package:todo_app/widgets/custome_text.dart';
import 'package:todo_app/widgets/reusable_text.dart';
import 'package:todo_app/widgets/todo_tile.dart';
import 'package:todo_app/widgets/tomorrow_list.dart';
import 'package:todo_app/widgets/xpansion_tile.dart';
import 'package:todo_app/xpansion_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'firebase_options.dart';



import '../widgets/dayAfterTomorrow.dart';
import '../widgets/todayTask.dart';


class HomePage extends ConsumerStatefulWidget {


  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin{


  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if(!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  late final TabController tabController = TabController(length: 2, vsync: this);
  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //watches if there are any changes--> if so the states gets mutated
    ref.watch(todoStateProvider.notifier).refresh();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(
                  horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(text: "Dashboard",
                  style: appstyle(18, AppConst.kLight, FontWeight.bold)),
                  Container(
                    width: 25.w,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: AppConst.kLight,
                      borderRadius: BorderRadius.all(Radius.circular(9))
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddTask()));
                      },
                      child: const Icon(Icons.add, color: AppConst.kBkDark),
                    ),
                  ),
                  Container(
                      width: 25.w,
                      height: 25,
                      decoration: const BoxDecoration(
                          color: AppConst.kBlueLight,
                          borderRadius: BorderRadius.all(Radius.circular(9))
                      ),
                      child: GestureDetector(
                        onTap: (){
                          _launchURL("www.3bmeteo.com");
                        },
                        child: const Icon(Icons.sunny, color: AppConst.kYellow),
                      )
                  ),

                ],
              ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: "Search",
                controller: search,
                prefixIcon: Container(
                  padding: EdgeInsets.all(14.h),
                  child: GestureDetector(
                    onTap: null,
                    child: const Icon(AntDesign.search1, color: AppConst.kGreyLight)
                  ),
                ),
                suffixIcon: const Icon(FontAwesome.sliders, color: AppConst.kGreyLight,),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      body: SafeArea(//safe area to make
        //everything within the screen
        child: Padding(padding:
        EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(//instead of column so that
            //widgets are scrollable
            children: [
              const SizedBox(height: 25,),
              Row(
                children: [
                  const Icon(FontAwesome.tasks, size: 20, color: AppConst.kLight,),
                  const SizedBox(width: 10,),
                  ReusableText(text: "Today's Tasks",
                    style: appstyle(18, AppConst.kLight, FontWeight.bold),)
                ],
              ),

              const SizedBox(height: 25,),
              Container(
                decoration: BoxDecoration(
                  color: AppConst.kLight,
                  borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius)),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: AppConst.kGreyLight,
                    borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius))
                  ),
                  controller: tabController,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  labelColor: AppConst.kBlueLight,
                  labelStyle: appstyle(24, AppConst.kBlueLight, FontWeight.w700),
                  unselectedLabelColor: AppConst.kLight,
                  tabs: [
                    Tab(
                      child: SizedBox(
                          width: AppConst.kWidth*0.5,
                          child: Center(
                            child: ReusableText(
                                text: "Pending",
                            style: appstyle(16, AppConst.kBkDark, FontWeight.bold),),
                          ),


                      ),
                    ),

                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(left: 30.w),
                        width: AppConst.kWidth*0.5,
                        child: Center(
                          child: ReusableText(
                            text: "Completed",
                            style: appstyle(16, AppConst.kBkDark, FontWeight.bold),),
                        ),


                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                  height: AppConst.kHeight*0.3,
                  width: AppConst.kWidth,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius)),
                    child: TabBarView(
                      controller: tabController,

                      children: [
                          Container(
                            color: AppConst.kBkLight,
                            height: AppConst.kHeight*0.3,

                              child: const TodayTasks(),
                          ),

                          Container(
                            color: AppConst.kBkLight,
                            height: AppConst.kHeight*0.3,
                            child: const CompletedTask(),                          ),
                        ],
                    ),

                  ),
              ),
              const SizedBox(height: 20,),
              const TomorrowList(),
              const SizedBox(height: 20,),
              // XpansionTile(
              //     text: DateTime.now()
              //               .add(Duration(days: 2))
              //               .toString()
              //               .substring(5,10),
              //     text2: "Day after tomorrow tasks",
              //     onExpansionChanged: (bool expanded) {
              //       ref
              //           .read(xpansionStateProvider.notifier)
              //           .setStart(!expanded); //not expanded
              //     },
              //     trailing:
              //     Padding(
              //       padding: EdgeInsets.only(right: 12.0.w),
              //       child: ref.watch(xpansionStateProvider)
              //           ?
              //       const Icon(AntDesign.circledown, color: AppConst.kLight)
              //       :const Icon(AntDesign.closecircleo, color: AppConst.kBlueLight),
              //     ),
              //     children: [
              //       TodoTile(
              //         start: "03:00",
              //         end: "05:00",
              //         switcher: Switch(
              //             value: true,
              //             onChanged: (value) {}),
              //       ),
              //     ] ),

              const SizedBox(height: 20,),

              const DayAfter(),

            ],
          ),
        ),

      ),
    );
  }
}

