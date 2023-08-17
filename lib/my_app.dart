import 'package:flutter/material.dart';
import 'package:flutter_application_rating_bar/meal_api.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();
  var enabled = false;
  List<Score> score = [];
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    var listView = ListView.separated(
      itemCount: score.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => ListTile(
        leading: Text('${score[index].rate}'),
        title: Text(score[index].comment),
      ),
    );
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Color.fromARGB(255, 165, 3, 151),
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  rate = rating;
                  enabled = true;
                });
                print(rating);
              },
            ),
            TextFormField(
              controller: controller,
              enabled: enabled,
              decoration: InputDecoration(
                  hintText: '오늘의 급식은 어땠나요?',
                  label: Text("급식 평가하기"),
                  border: OutlineInputBorder()),
              maxLength: 30,
            ),
            ElevatedButton(
                onPressed: enabled
                    ? () async {
                        var api = MealApi();
                        var eval_date = DateTime.now().toString().split(' ')[0];
                        var res =
                            await api.insert(eval_date, rate, controller.text);
                        print(res);
                        score.add(
                          new Score(rate: rate, comment: controller.text),
                        );
                        setState(() {
                          listView;
                        });
                      }
                    : null,
                child: Text("저장하기")),
            Expanded(child: listView)
          ],
        ),
      ),
    );
  }
}

class Score {
  double rate;
  String comment;
  Score({required this.rate, required this.comment});
}
