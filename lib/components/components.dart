import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:notepadapp/extensions/extension.dart';
import 'package:notepadapp/model/model.dart';

class NoteGrid extends StatelessWidget {
  final String title;
  final String textPreview;

  const NoteGrid({super.key, required this.title, required this.textPreview});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.wp(50),
      margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).colorScheme.surfaceContainerHighest
            : Color(0xff242947),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: context.hp(2)),
          Text(
            textPreview,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: GoogleFonts.poppins(
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withAlpha(150),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: getRandomColor(),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
