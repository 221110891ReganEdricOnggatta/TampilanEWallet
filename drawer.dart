import 'package:dana_kedua/providers/user.dart';
import 'package:dana_kedua/screens/profile/profile.dart';
import 'package:dana_kedua/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final loggedInUser = userProvider.loggedInUser;

    return Drawer(
      backgroundColor: Colors.grey[200],
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey[800]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: userProvider.profileImage != null
                      ? FileImage(userProvider.profileImage!)
                      : const AssetImage('assets/placeholder.png')
                          as ImageProvider,
                  child: userProvider.profileImage == null
                      ? const Icon(Icons.person, size: 25, color: Colors.white)
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loggedInUser?.username ?? "Guest",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        loggedInUser?.email ?? "Guest",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const MyProfiles()),
                    );
                  },
                  child: const Text("Edit"),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            trailing: const Icon(Icons.arrow_right),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.history),
            title: const Text("History Transaction"),
            trailing: const Icon(Icons.arrow_right),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.contacts),
            title: const Text("Contacts"),
            trailing: const Icon(Icons.arrow_right),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.payment),
            title: const Text("Payment"),
            trailing: const Icon(Icons.arrow_right),
          ),
          const SizedBox(
            height: 160,
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MySettings()));
            },
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
          ),
          ListTile(
            onTap: () {
              _showLogoutDialog(context);
            },
            leading: const Icon(Icons.logout),
            title: const Text("Log out"),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah Anda yakin ingin Logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Tidak"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
            child: const Text("Ya"),
          ),
        ],
      ),
    );
  }
}
