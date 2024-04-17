import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_page/controllers/category_controller.dart';


class RecommendWidget extends StatefulWidget {
  const RecommendWidget({super.key});

  @override
  State<RecommendWidget> createState() => _RecommendWidgetState();
}

class _RecommendWidgetState extends State<RecommendWidget> {
  final CategoryController _categoryController = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
    return Column(
      children: [
        const Row(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Recommended for you",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 30,
            ),
            Text("View all",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20,color: Colors.blue),
            )
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _categoryController.categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {

              },
              child: Column(
                children: [
                  Image.network(
                    _categoryController
                        .categories[index]
                        .categoryImage,
                    width: 57,
                    height: 57,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(_categoryController.categories[index].categoryName, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue.shade800,fontSize: 20)),
                  ),
                  const Text("4.5"),
                  const Text("500+ bought in past month"),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("Hogar"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                      ],
                    )
                    ],
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
    });
  }
}
