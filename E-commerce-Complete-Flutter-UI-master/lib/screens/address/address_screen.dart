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
        title: Text('Shipping Addresses'),
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: userAddresses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        userAddresses[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Add any additional details or actions for each address
                    ),
                  ),
                );
              },
            ),
          ),
          // Add New Address Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddNewAddressScreen.routeName);
              },
              child: Text("Add New Address"),
            ),
          ),
        ],
      ),
    );
  }
}
