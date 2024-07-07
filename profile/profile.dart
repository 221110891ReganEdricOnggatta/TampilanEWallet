import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:dana_kedua/providers/user.dart';

class MyProfiles extends StatefulWidget {
  const MyProfiles({super.key});

  @override
  State<MyProfiles> createState() => _MyProfilesState();
}

class _MyProfilesState extends State<MyProfiles> {
  late TextEditingController _usernameController;
  late TextEditingController _dobController;
  late TextEditingController _residenceController;
  File? _image;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final loggedInUser = userProvider.loggedInUser;

    _usernameController =
        TextEditingController(text: loggedInUser?.username ?? '');
    _dobController = TextEditingController(text: loggedInUser?.birth ?? '');
    _residenceController =
        TextEditingController(text: loggedInUser?.adress ?? '');
    _image = userProvider.profileImage;
  }

  Future<void> getImageProfile() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        Provider.of<UserProvider>(context, listen: false)
            .updateProfileImage(_image!);
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _showSaveConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Save Changes"),
        content: const Text("Save these changes?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final userProvider =
                  Provider.of<UserProvider>(context, listen: false);
              final loggedInUser = userProvider.loggedInUser;
              if (loggedInUser != null) {
                userProvider.updateProfile(
                  username: _usernameController.text,
                  dob: _dobController.text,
                  residence: _residenceController.text,
                );
              }
              Navigator.of(context).pop(); // Close the dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Changes saved successfully')),
              );
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final loggedInUser = userProvider.loggedInUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: loggedInUser == null
          ? const Center(child: Text("No user logged in!"))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : const AssetImage('assets/placeholder.png')
                              as ImageProvider,
                      child: _image == null
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.white)
                          : null,
                    ),
                    TextButton(
                      onPressed: getImageProfile,
                      child: const Text("Change Profile Picture"),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: "Username"),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: loggedInUser.email,
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Tanggal Lahir",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _residenceController,
                      decoration:
                          const InputDecoration(labelText: "Tempat Tinggal"),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        _showSaveConfirmationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
