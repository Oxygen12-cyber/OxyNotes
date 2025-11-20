import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:notepadapp/pages/homepage.dart';
import 'package:notepadapp/theme/theme.dart';

void main() {
  runApp(DevicePreview(builder: (context) => NoteApp()));
}

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lighttheme,
      darkTheme: darktheme,
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
