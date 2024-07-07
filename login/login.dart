import 'package:dana_kedua/components/bottomNav.dart';
import 'package:dana_kedua/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../register/register.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyLogins extends StatefulWidget {
  const MyLogins({super.key});

  @override
  State<MyLogins> createState() => _MyLoginsState();
}

class _MyLoginsState extends State<MyLogins> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome,",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            const Text("Please Login!"),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "email",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: TextField(
                obscureText: !_passwordVisible,
                controller: passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "password",
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  }, icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off))
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  final email = emailController.text;
                  final password = passwordController.text;

                  if (email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 6),
                        content:
                            const Text("Email and password must not be empty!"),
                        action: SnackBarAction(
                          label: "OK",
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                    return;
                  }

                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);

                  if (!userProvider.isEmailRegistered(email)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 6),
                        content: const Text("Email is not registered!"),
                        action: SnackBarAction(
                          label: "OK",
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                    return;
                  }

                  if (userProvider.login(email, password)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 6),
                        content: const Text("Login successful!"),
                        action: SnackBarAction(
                          label: "OK",
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                          },
                        ),
                      ),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyBottomNav()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 6),
                        content: const Text("Incorrect password!"),
                        action: SnackBarAction(
                          label: "OK",
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  "LOGIN",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Row(
              children: [
                const Text("Don't have an account? "),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyRegisters()),
                    );
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or"),
                  ),
                  Expanded(
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  elevation: 5,
                  child: IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      size: 42,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.facebook,
                      size: 42,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.tiktok,
                      size: 42,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
