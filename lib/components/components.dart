import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'package:notepadapp/extensions/extension.dart';
import 'package:notepadapp/model/model.dart';

class NoteGrid extends StatelessWidget {
  final String title;
  final String textPreview;
  final Future<void> Function()? onDelete;

  const NoteGrid({
    super.key,
    required this.title,
    required this.textPreview,
    this.onDelete,
  });

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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.length > 10
                    ? '${title.substring(0, title.indexOf(' ') + 3)}...'
                    : title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.poppins(
                  fontSize: title.length > 10 ? 16 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              PopupMenuButton(
                icon: Icon(Iconsax.more),
                iconSize: 24,
                padding: EdgeInsets.all(3),
                menuPadding: EdgeInsets.all(2),
                tooltip: "delete note",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: Theme.of(context).colorScheme.onPrimary,
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'delete_note', child: Text('delete')),
                ],
                onSelected: (String value) {
                  debugPrint('onSelected called with: $value');
                  if (value == 'delete_note') {
                    debugPrint('internal try to $value');
                    onDelete?.call();
                  }
                },
              ),
            ],
          ),
          // SizedBox(height: context.hp(2)),
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

SnackBar customSnackBar(BuildContext context, String textValue, String? value) {
  return SnackBar(
    dismissDirection: DismissDirection.down,
    duration: Durations.long2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    backgroundColor: value!.contains("good")
        ? Theme.of(context).colorScheme.surfaceBright
        : Theme.of(context).colorScheme.error,
    content: Center(
      child: Text(
        textValue,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
