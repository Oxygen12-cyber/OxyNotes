import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:notepadapp/extensions/extension.dart';
import 'package:notepadapp/pages/signuppage.dart';
import 'package:notepadapp/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://pzqlaqxjmqoztduborga.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6cWxhcXhqbXFvenRkdWJvcmdhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MjU0NzA0NywiZXhwIjoyMDc4MTIzMDQ3fQ.F1ASB3mqk27kj71TbWy5wo-oUMf9JAe4WP53RgYxf70',
  );

  runApp(
    DevicePreview(
      builder: (context) => MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => NoteClass())],
        child: NoteApp(),
      ),
    ),
  );
}

final supabase = Supabase.instance.client;

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lighttheme,
      darkTheme: darktheme,
      themeMode: ThemeMode.system,
      home: SignUpPage(),
    );
  }
}
