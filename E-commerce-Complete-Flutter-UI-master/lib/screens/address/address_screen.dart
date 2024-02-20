import 'package:flutter/material.dart';
import 'package:shop_app/screens/address/components/addNewAddess_screen.dart'; // Import Add New Address Screen

class AddScreen extends StatelessWidget {
  static const String routeName = '/address';

  // Example list of user addresses
  final List<String> userAddresses = [
    '123 Main St, City A',
    '456 Elm St, City B',
    '789 Oak St, City C',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Addresses'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: userAddresses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    userAddresses[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Add any additional details or actions for each address
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to Add New Address Screen
                Navigator.pushNamed(context, AddNewAddressScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(14),
              ),
              child: Text(
                'Add New Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
