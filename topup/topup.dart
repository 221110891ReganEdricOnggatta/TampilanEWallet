import 'package:dana_kedua/providers/saldoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTopUps extends StatefulWidget {
  const MyTopUps({super.key});

  @override
  State<MyTopUps> createState() => _MyTopUpsState();
}

class _MyTopUpsState extends State<MyTopUps> {
  final List<double> _chipValues = [10000, 20000, 50000, 100000];
  double? _selectedChipValue;
  final TextEditingController _customSaldoController = TextEditingController();
  bool _isLoading = false;

  double _sliderValue = 50000;
  final double _minSliderValue = 10000;
  final double _maxSliderValue = 1000000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up Saldo'),
        backgroundColor: Colors.grey[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isLoading)
                const LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Pilih jumlah saldo:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Wrap(
                  spacing: 10.0,
                  children: _chipValues.map((value) {
                    return ChoiceChip(
                      label: Text(
                        'Rp ${value.toInt()}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      selected: _selectedChipValue == value,
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.grey[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedChipValue = selected ? value : null;
                          _customSaldoController.clear();
                          _sliderValue = _minSliderValue;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 50),
              const Divider(height: 2),
              const SizedBox(height: 50),
              const Text(
                'Atau masukkan jumlah saldo:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _customSaldoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Masukkan jumlah saldo',
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedChipValue = null;
                    _sliderValue = _minSliderValue;
                  });
                },
              ),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Atau pilih jumlah saldo dengan Slider:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: _sliderValue,
                      min: _minSliderValue,
                      max: _maxSliderValue,
                      divisions:
                      ((_maxSliderValue - _minSliderValue) / 10000).round(),
                      label: 'Rp ${_sliderValue.round()}',
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                          _selectedChipValue = null;
                          _customSaldoController.clear();
                        });
                      },
                    ),
                    Text(
                      'Rp ${_sliderValue.round()}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                  ),
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    double? amount = _selectedChipValue ??
                        double.tryParse(_customSaldoController.text) ??
                        _sliderValue;
                    if (amount > 0) {
                      await Future.delayed(const Duration(seconds: 2));

                      Provider.of<MySaldoProviders>(context, listen: false)
                          .tambahSaldo(amount);
                      _customSaldoController.clear();
                      ScaffoldMessenger.of(context).showMaterialBanner(
                        MaterialBanner(
                          content: const Text('Saldo Anda berhasil ditambah'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentMaterialBanner();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Masukan jumlah saldo yang valid!")));
                    }

                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: const Text('Tambah Saldo', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
