import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notepadapp/components/components.dart';
import 'package:notepadapp/extensions/extension.dart';
import 'package:notepadapp/pages/signinpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.ubuntuSans(
            letterSpacing: 1.3,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream: Supabase.instance.client.auth.onAuthStateChange,
          builder: (context, asyncSnapshot) {
            final Session? session = asyncSnapshot.data?.session;
            final user = session?.user;
            final emailDisplay = user?.email ?? '';
            final emailLength = emailDisplay.length;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: context.hp(10)),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.yellow[200],
                  foregroundImage: AssetImage(
                    'assets/images/avatar_image2.png',
                  ),
                ),
                SizedBox(height: context.hp(5)),

                Text(
                  emailDisplay,
                  style: GoogleFonts.ubuntuSans(
                    letterSpacing: 1.3,
                    fontSize: emailLength > 16 ? 24 : 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  emailLength < 1
                      ? ""
                      : "Job Specialist at Google Inc ; \n from Nargrid",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntuSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                SizedBox(height: context.hp(15)),
                IconButton.filledTonal(
                  onPressed: () async {
                    debugPrint("logout clicked");
                    try {
                      await supabase.auth.signOut();
                      debugPrint('signed userout');
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(customSnackBar(context, 'Signing out'));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    } on AuthException catch (err) {
                      if (!context.mounted) {
                        return;
                      }
                      debugPrint("logout error: ${err.message}");

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(customSnackBar(context, err.message));
                    } catch (err) {
                      debugPrint("logout error: ${err.toString()}");
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(customSnackBar(context, err.toString()));
                    }
                  },
                  tooltip: "logout",
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(24),
                  icon: Icon(Iconsax.logout_1),
                  iconSize: 32,
                ),
                Text(
                  "click to logout",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntuSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
