import 'package:dana_kedua/components/bottomNav.dart';
import 'package:dana_kedua/providers/user.dart';
import 'package:dana_kedua/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyRegisters extends StatefulWidget {
  const MyRegisters({super.key});

  @override
  State<MyRegisters> createState() => _MyRegistersState();
}

class _MyRegistersState extends State<MyRegisters> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome,",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  const Text("Please Register!"),
                  const SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordConfirmationController,
                    obscureText: !_confirmPasswordVisible,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Password Confirmation",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
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
                        final name = nameController.text;
                        final email = emailController.text;
                        final password = passwordController.text;
                        final passwordConfirmation =
                            passwordConfirmationController.text;

                        if (name.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty ||
                            passwordConfirmation.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Masukin data Anda!"),
                              duration: const Duration(seconds: 5),
                              behavior: SnackBarBehavior.floating,
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

                        if (password == passwordConfirmation) {
                          final userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                          userProvider.register(name, email, password);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Registration Successful!"),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 5),
                              action: SnackBarAction(
                                label: "OK",
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentMaterialBanner();
                                },
                              ),
                            ),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyBottomNav(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Passwords do not match!"),
                              duration: const Duration(seconds: 5),
                              behavior: SnackBarBehavior.floating,
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
                        "REGISTER",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyLogins()),
                          );
                        },
                        child: Text(
                          "Login",
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
                            thickness: 1, // Menentukan ketebalan Divider
                            color: Colors.black, // Menentukan warna Divider
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
          ),
        ),
      ),
    );
  }
}
