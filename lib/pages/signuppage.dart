import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notepadapp/components/components.dart';
import 'package:notepadapp/extensions/extension.dart';
import 'package:notepadapp/pages/signinpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> handleSignup(String email, String password) async {
    await supabase.auth.signUp(email: email, password: password);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(automaticallyImplyLeading: false),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(
          context,
        ).copyWith(scrollbars: false, physics: BouncingScrollPhysics()),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  SizedBox(height: context.hp(20)),
                  Text(
                    "Sign UP",
                    style: GoogleFonts.ubuntuSansMono(
                      letterSpacing: 1.3,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign up using your email and password",
                    style: GoogleFonts.ubuntuSansMono(
                      letterSpacing: 1.1,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  SizedBox(height: context.hp(1.2)),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),

                    child: TextField(
                      controller: emailController,
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(Iconsax.sms),
                        ),
                        fillColor:
                            Theme.of(context).brightness == Brightness.light
                            ? Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest
                            : Color(0xff242947),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(
                          fontSize: 18,
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                ? Theme.of(context).primaryColor.withAlpha(80)
                                : Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.hp(1.2)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextField(
                      controller: passwordController,
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(Iconsax.password_check),
                        ),
                        fillColor:
                            Theme.of(context).brightness == Brightness.light
                            ? Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest
                            : Color(0xff242947),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontSize: 18,
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                ? Theme.of(context).primaryColor.withAlpha(80)
                                : Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.hp(5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInPage(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 22,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.ubuntuSans(
                            letterSpacing: 1.2,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                      FilledButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          final email = emailController.text;
                          final pass = passwordController.text;
                          if (email.isNotEmpty && pass.isNotEmpty) {
                            try {
                              await handleSignup(email, pass);
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                  context,
                                  "User is successfully registered\n go to signin",
                                  'good',
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInPage(),
                                ),
                              );
                            } on AuthException catch (err) {
                              if (err.message.toLowerCase().contains(
                                    'already registered',
                                  ) ||
                                  err.message.toLowerCase().contains(
                                    'user already exists',
                                  )) {
                                debugPrint(err.message);
                                // if (mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar(
                                    context,
                                    "User is already registered; please Sign In",
                                    'bad',
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInPage(),
                                  ),
                                );
                              }
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(context, err.message, 'bad'),
                              );
                            } catch (err) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(context, err.toString(), 'bad'),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              customSnackBar(
                                context,
                                "fill in all fields",
                                'bad',
                              ),
                            );
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 22,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? CircularProgressIndicator(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHigh,
                              )
                            : Text(
                                "Sign Up",
                                style: GoogleFonts.ubuntuSans(
                                  letterSpacing: 1.2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onInverseSurface
                                      .withValues(alpha: 0.9),
                                ),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.hp(12)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
