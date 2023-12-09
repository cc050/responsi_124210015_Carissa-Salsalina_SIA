import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:responsi/Data/Categories.dart';
import 'package:responsi/Data/Detail_meals.dart';

import 'halaman_detail_meal.dart';

class HalamanMeals extends StatefulWidget {
  final Categories category;

  const HalamanMeals({Key? key, required this.category}) : super(key: key);

  @override
  State<HalamanMeals> createState() => _HalamanMealsState();
}

class _HalamanMealsState extends State<HalamanMeals> {
  late Future<List<Meals>> mealsList;

  @override
  void initState() {
    super.initState();
    mealsList = _fetchMeals();
  }

  Future<List<Meals>> _fetchMeals() async {
    final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.category.strCategory}"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> mealsData = data['meals'];
      return mealsData.map((result) => Meals.fromJson(result)).toList();
    } else {
      throw Exception('Failed to load Meals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category.strCategory} Meals'),
      ),
      body: FutureBuilder<List<Meals>>(
        future: mealsList,
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
              child: Text('No Meals available for ${widget.category.strCategory}.'),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final meal = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    // Handle meal item tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HalamanDetail(),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2.0,
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(meal.strMealThumb ?? ''),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              meal.strMeal ?? '',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
