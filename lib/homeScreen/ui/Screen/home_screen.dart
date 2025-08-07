import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app1/homeScreen/bloC/cubit/home_screen_cubit.dart';
import 'package:todo_app1/homeScreen/model/note_model.dart';
import 'package:todo_app1/homeScreen/ui/Screen/add_note_screen.dart';
import 'package:todo_app1/homeScreen/ui/Screen/edit_screen.dart';
import 'package:todo_app1/homeScreen/ui/widgets/category.dart';
import 'package:todo_app1/homeScreen/ui/widgets/header.dart';
import 'package:todo_app1/homeScreen/ui/widgets/imaortant_card.dart';
import 'package:todo_app1/homeScreen/ui/widgets/searchbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenCubit, HomeScreenState>(
      listenWhen: (previous, current) =>
          current is NotesLoading ||
          current is NotesFetched ||
          current is HomeScreenError,
      listener: (context, state) {
        if (state is NotesLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: Colors.blue),
                      SizedBox(height: 16.h),
                      Text(
                        "Loading...",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is NotesFetched || state is HomeScreenError) {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF2F2F6),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<HomeScreenCubit>().refreshNotes();
              },
              color: Colors.blue,
              backgroundColor: Colors.white,
              displacement: 30,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    BlocBuilder<HomeScreenCubit, HomeScreenState>(
                      builder: (context, state) {
                        final cubit = context.watch<HomeScreenCubit>();
                        return NotesHeader(username: cubit.userName ?? "User");
                      },
                    ),
                    CustomTextFormField(
                      hintText: 'Search',
                      controller: context
                          .read<HomeScreenCubit>()
                          .searchController,
                      onChanged: (value) {
                        context.read<HomeScreenCubit>().searchNotes(value);
                      },
                    ),
                    20.verticalSpace,
                    BlocBuilder<HomeScreenCubit, HomeScreenState>(
                      builder: (context, state) {
                        final cubit = context.watch<HomeScreenCubit>();
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
                                    backGroungColor:
                                        cubit.getCardState('All Notes')
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
                                    backGroungColor:
                                        cubit.getCardState('Hidden')
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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    15.verticalSpace,
                    BlocBuilder<HomeScreenCubit, HomeScreenState>(
                      builder: (context, state) {
                        final cubit = context.watch<HomeScreenCubit>();
                        final recentNotes = cubit.searchController.text.isEmpty
                            ? cubit.getLastTwoNotes()
                            : cubit.getLastTwoSearchResults();

                        if (recentNotes.isEmpty) {
                          return const Center(child: Text("No recent notes."));
                        }

                        return Row(
                          children: List.generate(recentNotes.length, (index) {
                            final note = recentNotes[index];
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: index == 0 ? 10.0 : 0,
                                ),
                                child: ImportantInfo(
                                  title: note.title ?? 'Untitled',
                                  subtitle: note.content ?? '',
                                  prefixText: 'Note ID:',
                                  boldText: ' ${note.noteId}',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditScreen(
                                          noteId: note.noteId.toString(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 0),
                      child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                        builder: (context, state) {
                          final cubit = context.watch<HomeScreenCubit>();
                          final notes = cubit.searchController.text.isEmpty
                              ? cubit.notes
                              : cubit.searchResults;

                          if (notes.isEmpty) {
                            return const Center(
                              child: Text("No notes available."),
                            );
                          }

                          final List<NoteModel> localNotes = List.from(notes);

                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: localNotes.length,
                            itemBuilder: (context, index) {
                              final note = localNotes[index];
                              return Dismissible(
                                key: Key(note.noteId.toString()),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) async {
                                  final noteId = note.noteId.toString();
                                  // await cubit.deleteNote(noteId);
                                  // cubit.refreshNotes();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          const Icon(
                                            Icons.delete_outline,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 12.r),
                                          Expanded(
                                            child: Text(
                                              'Note ${note.noteId} deleted',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.redAccent,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                        vertical: 10.h,
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                child: ImportantInfo(
                                  title: note.title ?? 'Untitled',
                                  subtitle: note.content ?? '',
                                  prefixText: 'Note ID:',
                                  boldText: ' ${note.noteId}',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditScreen(
                                          noteId: note.noteId.toString(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                6.verticalSpace,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Container(
          width: 55.w,
          height: 55.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateNotePage()),
              );
              if (result == true) {
                context.read<HomeScreenCubit>().refreshNotes();
              }
            },
            child: Icon(Icons.note_add_rounded, size: 28.r),
          ),
        ),
      ),
    );
  }
}
