import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app1/homeScreen/bloC/cubit/home_screen_cubit.dart';
import 'package:todo_app1/homeScreen/ui/Screen/add_note_screen.dart';
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
      backgroundColor: const Color(0xffF2F2F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Top header with username
                BlocBuilder<HomeScreenCubit, HomeScreenState>(
                  builder: (context, state) {
                    final cubit = context.watch<HomeScreenCubit>();
                    return NotesHeader(username: cubit.userName ?? "User");
                  },
                ),

                /// Search input
                const CustomTextFormField(hintText: 'Search'),
                20.verticalSpace,

                /// Note categories
                BlocBuilder<HomeScreenCubit, HomeScreenState>(
                  builder: (context, state) {
                    final cubit = context.watch<HomeScreenCubit>();

                    return Column(
                      children: [
                        // First row: All Notes + Favourites
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

                        // Second row: Hidden + Trash
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

                /// Section title: Recent Notes
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Recent Notes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),

                15.verticalSpace,

                /// Static info cards
                Row(
                  children: const [
                    Expanded(
                      child: InfoCard(
                        title: "Getting Started",
                        description:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        boldText: "Maecenas sed diam cum ligula justo.",
                        footer: "elementum.",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: InfoCard(
                        title: "UX Design",
                        description:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        boldText: "Maecenas sed diam cum ligula justo.",
                        footer: "elementum.",
                      ),
                    ),
                  ],
                ),

                /// Notes list from state
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 6),
                  child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                    builder: (context, state) {
                      final cubit = context.watch<HomeScreenCubit>();
                      final notes = cubit.notes;

                      if (notes.isEmpty) {
                        return const Center(child: Text("No notes available."));
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          return ImportantInfo(
                            title: note.title ?? 'Untitled',
                            subtitle: note.content ?? '',
                            prefixText: 'Note ID:',
                            boldText: ' ${note.noteId}',
                          );
                        },
                        separatorBuilder: (context, index) => 6.verticalSpace,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      /// Floating action button to add new note
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateNotePage()),
          );
          if (result == true) {
            // Refresh note list after returning from add page
            context.read<HomeScreenCubit>().refreshNotes();
          }
        },
        child: const Icon(Icons.note_add_rounded),
      ),
    );
  }
}
