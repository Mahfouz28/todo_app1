import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app1/homeScreen/bloC/cubit/home_screen_cubit.dart';
import 'package:todo_app1/homeScreen/ui/widgets/category.dart';
import 'package:todo_app1/homeScreen/ui/widgets/header.dart';
import 'package:todo_app1/homeScreen/ui/widgets/imaortant_card.dart';
import 'package:todo_app1/homeScreen/ui/widgets/info_card.dart';
import 'package:todo_app1/homeScreen/ui/widgets/searchbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenCubit>().getUserData();
    });

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Header with user info
                BlocBuilder<HomeScreenCubit, HomeScreenState>(
                  builder: (context, state) {
                    if (state is UserDataLoaded) {
                      return NotesHeader(
                        username: state.user.username,
                        
                      );
                    }
                    return const NotesHeader();
                  },
                ),

                const CustomTextFormField(hintText: 'Search'),
                20.verticalSpace,

                /// Categories
                BlocBuilder<HomeScreenCubit, HomeScreenState>(
                  builder: (context, state) {
                    final cubit = context.read<HomeScreenCubit>();

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => cubit.toggleCard('All Notes'),
                              child: NoteCategoryCard(
                                icon: Icons.description_outlined,
                                title: 'All Notes',
                                color: Colors.grey,
                                backGroungColor: cubit.getCardState('All Notes')
                                    ? Colors.grey
                                    : Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => cubit.toggleCard('Favourites'),
                              child: NoteCategoryCard(
                                icon: Icons.star_border,
                                title: 'Favourites',
                                color: Colors.amber,
                                backGroungColor:
                                    cubit.getCardState('Favourites')
                                    ? Colors.yellow
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                        12.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => cubit.toggleCard('Hidden'),
                              child: NoteCategoryCard(
                                icon: Icons.visibility_off_outlined,
                                title: 'Hidden',
                                color: Colors.blue,
                                backGroungColor: cubit.getCardState('Hidden')
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => cubit.toggleCard('Trash'),
                              child: NoteCategoryCard(
                                icon: Icons.delete_outline,
                                title: 'Trash',
                                color: Colors.red,
                                backGroungColor: cubit.getCardState('Trash')
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
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

                /// Static Info Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    InfoCard(
                      title: "Getting Started",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      boldText: "Maecenas sed diam cum ligula justo.",
                      footer: "elementum.",
                    ),
                    SizedBox(width: 10),
                    InfoCard(
                      title: "UX Design",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      boldText: "Maecenas sed diam cum ligula justo.",
                      footer: "elementum.",
                    ),
                  ],
                ),

                /// Important Notes List
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 6),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) => const ImportantInfo(
                      title: 'Important',
                      subtitle:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      prefixText: 'Maecenas sed ',
                      boldText: 'diam cum ligula justo.',
                    ),
                    separatorBuilder: (context, index) => 6.verticalSpace,
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
