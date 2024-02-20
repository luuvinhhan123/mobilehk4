import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNewAddressScreen extends StatefulWidget {
  static const String routeName = '/addressNew';
  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  List<dynamic> _cities = [];
  List<dynamic> _districts = [];
  List<dynamic> _wards = [];

  String _selectedCity = '';
  String _selectedDistrict = '';
  String _selectedWard = '';
  String _street = '';

  bool _isLoading = false;

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json'));
    if (response.statusCode == 200) {
      setState(() {
        _cities = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchDistrictsAndWards(String cityId) async {
    final response = await http.get(Uri.parse('https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final city = data.firstWhere((city) => city['Id'] == cityId);
      setState(() {
        _districts = city['Districts'];
      });
    } else {
      throw Exception('Failed to load districts data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField(
                    value: _selectedCity.isNotEmpty ? _selectedCity : null,
                    hint: Text('Select City'),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCity = newValue.toString();
                        _selectedDistrict = '';
                        _selectedWard = '';
                        _districts = [];
                        _wards = [];
                      });
                      fetchDistrictsAndWards(newValue.toString());
                    },
                    items: _cities.map((city) {
                      return DropdownMenuItem(
                        child: Text(city['Name']),
                        value: city['Id'],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  if (_districts.isNotEmpty)
                    DropdownButtonFormField(
                      value: _selectedDistrict.isNotEmpty ? _selectedDistrict : null,
                      hint: Text('Select District'),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedDistrict = newValue.toString();
                          _selectedWard = '';
                          _wards = [];
                        });
                      },
                      items: _districts.map((district) {
                        return DropdownMenuItem(
                          child: Text(district['Name']),
                          value: district['Id'],
                        );
                      }).toList(),
                    ),
                  SizedBox(height: 16.0),
                  if (_wards.isNotEmpty)
                    DropdownButtonFormField(
                      value: _selectedWard.isNotEmpty ? _selectedWard : null,
                      hint: Text('Select Ward'),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedWard = newValue.toString();
                        });
                      },
                      items: _wards.map((ward) {
                        return DropdownMenuItem(
                          child: Text(ward['Name']),
                          value: ward['Id'],
                        );
                      }).toList(),
                    ),
                  SizedBox(height: 16.0),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _street = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Street',
                      labelText: 'Street',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle adding new address
                      print('New Address: Street: $_street, Ward: $_selectedWard, District: $_selectedDistrict, City: $_selectedCity');
                    },
                    child: Text('Add New Address'),
                  ),
                ],
              ),
      ),
    );
  }
}

