import 'package:assignment4/view_model/weather_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:assignment4/model/to_do_model.dart';
import 'package:assignment4/view_model/to_do_view_model.dart';
import 'package:assignment4/core/app_theme.dart';
import 'package:assignment4/view/home/add_to_do_dialog.dart';
import 'package:assignment4/view/home/no_to_do.dart';
import 'package:assignment4/view/home/to_do_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ToDoViewModel 구독
    final List<ToDoModel> todos = ref.watch(toDoViewModelProvider);
    // WeatherInfoViewModel 구독
    final weather = ref.watch(weatherInfoViewModelProvider);

    return Scaffold(
      backgroundColor: vrc(context).background300,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: vrc(context).background200,
        scrolledUnderElevation: 0,
        title: Text(
          title,
          style: TextStyle(
            color: vrc(context).textColor200,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: todos.isEmpty
          ? NoToDo(title: title) // 할 일 있을 때 화면
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) =>
                    ToDoView(todo: todos[index]), // 할 일 없을 때 화면
              ),
            ),
      // 할 일 추가 버튼
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: fxc(context).brandColor,
        shape: CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: vrc(context).background100,
            isScrollControlled: true,
            context: context,
            builder: (context) => AddToDoDialog(),
          );
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add_rounded, size: 24),
      ),
      // 현재 위치와 시간에 따른 날씨 정보
      bottomNavigationBar: BottomAppBar(
        color: vrc(context).background200,
        height: 120,
        child: weather.when(
          // UI 렌더링
          data: (w) => Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 10,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  Text(
                    style: TextStyle(fontSize: 15),
                    "업데이트 시간: ${w.time.year}년 ${w.time.month}월 ${w.time.day}일 ${w.time.hour}시 ${w.time.minute}분",
                  ),
                  Icon(
                    6 <= w.time.hour && w.time.hour < 18
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  Text(
                    style: TextStyle(fontSize: 15),
                    "날씨: ${w.weatherDescription}",
                  ),
                  Text(
                    style: TextStyle(fontSize: 15),
                    "온도: ${w.temperature}°C",
                  ),
                  Text(style: TextStyle(fontSize: 15), "풍속: ${w.windSpeed}"),
                ],
              ),
              Text(style: TextStyle(fontSize: 15), "자외선: ${w.uv}"),
            ],
          ),
          loading: () => Center(
            child: Text("날씨 정보를 불러오는 중...", style: TextStyle(fontSize: 14)),
          ),

          error: (e, s) => Center(
            child: Text("날씨 정보를 불러올 수 없습니다.", style: TextStyle(fontSize: 14)),
          ),
        ),
      ),
    );
  }
}
