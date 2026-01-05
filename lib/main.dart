import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notepadapp/extensions/extension.dart';
import 'package:notepadapp/model/model.dart';
import 'package:notepadapp/pages/homepage.dart';
import 'package:notepadapp/pages/signinpage.dart';
import 'package:notepadapp/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await Supabase.initialize(
    url: 'https://pzqlaqxjmqoztduborga.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6cWxhcXhqbXFvenRkdWJvcmdhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MjU0NzA0NywiZXhwIjoyMDc4MTIzMDQ3fQ.F1ASB3mqk27kj71TbWy5wo-oUMf9JAe4WP53RgYxf70',
  );

  runApp(
    // MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider(create: (context) => NoteClass()),
    //       ChangeNotifierProvider(create: (context) => SupabaseDb())
    //     ],
    //     child: NoteApp(),
    //   )

    DevicePreview(
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NoteClass()),
          ChangeNotifierProvider(create: (context) => SupabaseDb()),
        ],
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
      debugShowCheckedModeBanner: false,
      theme: lighttheme,
      darkTheme: darktheme,
      themeMode: ThemeMode.system,
      home: StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          final Session? session = snapshot.data?.session;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                  "${snapshot.error}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }

          return session != null ? HomePage() : SignInPage();
        },
      ),
    );
  }
}
