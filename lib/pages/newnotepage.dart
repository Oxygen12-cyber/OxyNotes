import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notepadapp/extensions/extension.dart';
import 'package:notepadapp/model/model.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final _titleTextController = TextEditingController();
  final _contentTextController = TextEditingController();

  void saveNote(String atitle, String acontent) {
    // final Map<String, dynamic> aNote = {atitle: acontent};
    MyNotes.insert(0, {"title": atitle, "content": acontent});
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _contentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leadingWidth: 80,
        leading: IconButton.filled(
          padding: const EdgeInsets.all(15),
          iconSize: 24,
          style: IconButton.styleFrom(
            backgroundColor:
                Theme.of(context).colorScheme.brightness == Brightness.dark
                ? const Color(0xff242947)
                : Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  debugPrint('clicked save');
                  if (_titleTextController.text.isNotEmpty) {
                    saveNote(
                      _titleTextController.text,
                      _contentTextController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "save",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: context.wp(2)),
                    Icon(Iconsax.tick_square),
                  ],
                ),
              ),

              SizedBox(width: context.hp(3)),
            ],
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(
          context,
        ).copyWith(scrollbars: false, physics: BouncingScrollPhysics()),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: context.hp(3)),
              TextField(
                controller: _titleTextController,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                maxLines: 2,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),

                decoration: InputDecoration(
                  hoverColor: Colors.transparent,

                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? Color(0xffffffff)
                      : Theme.of(context).scaffoldBackgroundColor,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  hintText: "Title...",
                  hintStyle: GoogleFonts.poppins(
                    textBaseline: TextBaseline.alphabetic,
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.transparent),
                  ),
                  focusedBorder: InputBorder.none,
                ),
              ),
              SizedBox(height: context.hp(1)),
              SizedBox(
                height: double.maxFinite,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  scrollPadding: EdgeInsets.all(5),
                  controller: _contentTextController,
                  autocorrect: true,
                  // expands: true,
                  maxLines: null,
                  minLines: null,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  enableInteractiveSelection: true,
                  scrollPhysics: BouncingScrollPhysics(),
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,

                  decoration: InputDecoration(
                    hoverColor: Colors.transparent,
                    fillColor: Theme.of(context).brightness == Brightness.light
                        ? Color(0xffffffff)
                        : Theme.of(context).scaffoldBackgroundColor,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                    hintText: "Note something down...",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
