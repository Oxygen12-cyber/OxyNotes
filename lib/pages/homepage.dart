import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notepadapp/components/components.dart';
import 'package:notepadapp/extensions/extension.dart';
import 'package:notepadapp/model/model.dart';
import 'package:notepadapp/pages/newnotepage.dart';
import 'package:provider/provider.dart';
import 'profilepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SupabaseDb>().getAllNotes();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadNewData() async {
    debugPrint('trying to get new data');
    context.read<SupabaseDb>().getAllNotes();
    debugPrint('loaded new data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          debugPrint('clicked add');
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewNotePage()),
          );
          if (mounted) {
            loadNewData();
          }
        },
        enableFeedback: true,
        shape: CircleBorder(),
        backgroundColor: Color(0xff3758f4),
        foregroundColor: Colors.white,
        elevation: 3,
        tooltip: "add new note",
        child: Icon(Iconsax.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        leadingWidth: 200,
        leading: Padding(
          padding: EdgeInsetsGeometry.only(left: 15, top: 5),
          child: Text(
            'Keep Note',
            style: GoogleFonts.ubuntuSansMono(
              letterSpacing: 1.3,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                    if (mounted) {
                      loadNewData();
                    }
                  },
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.light
                        ? Color(0xffeff2f9)
                        : Color(0xffe9ecec),
                    foregroundImage: AssetImage(
                      'assets/images/avatar_image2.png',
                    ),
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: TextField(
                controller: _searchController,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,

                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      icon: Icon(Iconsax.search_normal),
                      onPressed: () {},
                    ),
                  ),
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 0,
                          blurRadius: 12,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                    ),
                    child: Icon(Iconsax.driver),
                  ),
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.surfaceContainerHighest
                      : Color(0xff242947),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  hintText: "Search note...",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Theme.of(context).primaryColor.withAlpha(80)
                          : Theme.of(context).colorScheme.secondary,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: SizedBox(
                height: context.hp(60),
                width: double.infinity,
                child: Consumer<SupabaseDb>(
                  builder:
                      (BuildContext context, SupabaseDb value, Widget? child) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                          itemCount: value.noteCache.length,
                          itemBuilder: (context, index) {
                            final String title =
                                value.noteCache[index]["title"] ?? "";
                            final String preview =
                                value.noteCache[index]["content"] ?? "";
                            final String noteId =
                                value.noteCache[index]['id'] ?? "";

                            return GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return NewNotePage(
                                        title: title,
                                        content: preview,
                                        index: index,
                                        noteId: noteId,
                                      );
                                    },
                                  ),
                                );

                                if (mounted) {
                                  loadNewData();
                                }
                              },
                              child: NoteGrid(
                                title: title,
                                textPreview: preview,
                                onDelete: () async {
                                  try {
                                    await value.deleteNote(title, preview, noteId);
                                    debugPrint('deleted note');
                                  } catch (err) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(err.toString())),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        );
                      },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
