import 'package:dana_kedua/components/motor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dana_kedua/providers/saldoProvider.dart';
import 'package:dana_kedua/utils/atoms/listTopup.dart';
import 'package:dana_kedua/components/drawer.dart';
import 'package:dana_kedua/providers/user.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String textQRCode = "";

  void navigateToPage(BuildContext context, String page) {
    if (page == "Motor") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyMotors()),
      );
    } else if (page == "Rumah") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyMotors()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userName = userProvider.loggedInUser?.username ?? "Guest";

    final List<String> favoriteItems = [
      'Food',
      'Beverage',
      'Clothing',
      'Gaming'
    ];
    final List<String> billingItems = [
      'Listrik',
      'PDAM',
      'Security',
      'Internet'
    ];
    final List<String> installmentItems = ['Mobil', 'Motor', 'Rumah'];

    Widget buildIcon(String label, IconData icon) {
      return Column(
        children: [
          IconButton(
            icon: Icon(icon),
            onPressed: () {
              if (label == "Motor" || label == "Rumah") {
                navigateToPage(context, label);
              }
              // Tambahkan kondisi lainnya jika perlu
            },
          ),
          Text(label),
        ],
      );
    }

    List<Widget> buildTabContent(List<String> items, List<IconData> icons) {
      return items.asMap().entries.map((entry) {
        int index = entry.key;
        String item = entry.value;
        return buildIcon(item, icons[index]);
      }).toList();
    }

    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Konfirmasi"),
                content: const Text("Apakah Anda yakin ingin keluar?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Tidak"),
                  ),
                  TextButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: const Text("Ya"),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[500],
            title: const Text('Home'),
          ),
          drawer: const MyDrawer(),
          floatingActionButton: Tooltip(
            message: 'Scan Barcode',
            child: FloatingActionButton(
              backgroundColor: Colors.grey[500],
              onPressed: () async {
                String? scannerResult = await scanner.scan();
                setState(() {
                  textQRCode = scannerResult ?? "";
                });
              },
              child: const Icon(Icons.qr_code, color: Colors.white),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 240,
                            decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Welcome, ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 110,
                        left: 20,
                        right: 20,
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Total Saldo",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Consumer<MySaldoProviders>(
                                          builder: (context, balanceProvider,
                                              child) {
                                            return Text(
                                              "Rp ${balanceProvider.balance}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Total Poins",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          "20.000",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25),
                                MyTopups(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[500],
                    ),
                    child: Column(
                      children: [
                        const TabBar(
                          indicatorColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.white,
                          tabs: [
                            Tab(
                              child: Text(
                                "Favorit",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Tagihan",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Cicilan",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 150,
                          child: TabBarView(
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: buildTabContent(
                                    favoriteItems,
                                    [
                                      Icons.fastfood,
                                      Icons.local_drink,
                                      Icons.shop,
                                      Icons.videogame_asset,
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: buildTabContent(
                                    billingItems,
                                    [
                                      Icons.flash_on,
                                      Icons.water,
                                      Icons.security,
                                      Icons.wifi,
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: buildTabContent(
                                    installmentItems,
                                    [
                                      Icons.directions_car,
                                      Icons.motorcycle,
                                      Icons.home,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
