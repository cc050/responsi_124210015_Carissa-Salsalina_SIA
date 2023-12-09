import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:responsi/Data/Detail_meals.dart';
import 'package:url_launcher/url_launcher.dart';

class HalamanDetail extends StatefulWidget {
  const HalamanDetail({Key? key});

  @override
  State<HalamanDetail> createState() => _HalamanDetailState();
}

class _HalamanDetailState extends State<HalamanDetail> {
  late Future<List<Meals>> detailList;

  @override
  void initState() {
    super.initState();
    detailList = _fetchMeals();
  }

  Future<List<Meals>> _fetchMeals() async {
    final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> detailData = data['meals'];
      return detailData.map((result) => Meals.fromJson(result)).toList();
    } else {
      throw Exception('Failed to load Meals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Detail'),
      ),
      body: FutureBuilder<List<Meals>>(
        future: detailList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No Detail Meals available.'),
            );
          } else {
            final detail = snapshot.data![0];
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(detail.strMealThumb ?? ''),
                  SizedBox(height: 16.0),
                  Text(
                    detail.strMeal ?? '',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Category: ${detail.strCategory ?? ''}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Ingrediens: '
                        '${detail.strIngredient1?? ''},'
                        '${detail.strIngredient2?? ''},'
                        '${detail.strIngredient3?? ''},'
                        '${detail.strIngredient4?? ''},'
                        '${detail.strIngredient5?? ''}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Instructions: ${detail.strInstructions ?? ''}',
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (detail.strYoutube != null) {
                        launchUrl(detail.strYoutube!);
                      }
                    },
                    child: Text('Watch'),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
void launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
