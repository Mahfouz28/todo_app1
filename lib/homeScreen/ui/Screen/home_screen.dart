import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app1/homeScreen/ui/widgets/category.dart';
import 'package:todo_app1/homeScreen/ui/widgets/header.dart';
import 'package:todo_app1/homeScreen/ui/widgets/imaortant_card.dart';
import 'package:todo_app1/homeScreen/ui/widgets/info_card.dart';
import 'package:todo_app1/homeScreen/ui/widgets/searchbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NotesHeader(),
                CustomTextFormField(hintText: 'Search'),
                20.verticalSpace,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NoteCategoryCard(
                      icon: Icons.description_outlined,
                      title: 'All Notes',
                      color: Colors.grey,
                    ),
                    NoteCategoryCard(
                      icon: Icons.star_border,
                      title: 'Favourites',
                      color: Colors.amber,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NoteCategoryCard(
                      icon: Icons.visibility_off_outlined,
                      title: 'Hidden',
                      color: Colors.blue,
                    ),
                    NoteCategoryCard(
                      icon: Icons.delete_outline,
                      title: 'Trash',
                      color: Colors.red,
                    ),
                  ],
                ),
                20.verticalSpace,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Recent Notes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                15.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InfoCard(
                      title: "Getting Started",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                      boldText: "Maecenas sed diam cum ligula justo.",
                      footer: "elementum.",
                    ),
                    10.horizontalSpace,

                    InfoCard(
                      title: "UX Design",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                      boldText: "Maecenas sed diam cum ligula justo.",
                      footer: "elementum.",
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 6),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

                    itemCount: 10,
                    itemBuilder: (context, index) => ImportantInfo(
                      title: 'Important',
                      subtitle:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      prefixText: 'Maecenas sed ',
                      boldText: 'diam cum ligula justo.',
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        6.verticalSpace,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
