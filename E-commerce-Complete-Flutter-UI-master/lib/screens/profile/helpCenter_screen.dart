import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  static String routeName = "/help";
  final List<Map<String, String>> faqs = [
    {
      'question': 'What is your warranty policy?',
      'answer': 'We offer a standard warranty of 1 year for all our products. If you encounter any issues with your purchase within this period, please contact our customer support for assistance.',
    },
    {
      'question': 'What is your return and exchange policy?',
      'answer': 'We accept returns and exchanges within 30 days of purchase. Items must be unused and in their original condition. Please refer to our Returns & Exchanges page for detailed instructions.',
    },
    {
      'question': 'What are your shipping options?',
      'answer': 'We offer standard and expedited shipping options. Standard shipping usually takes 3-5 business days, while expedited shipping delivers within 1-2 business days. Shipping costs and delivery times may vary depending on your location.',
    },
    {
      'question': 'How can I contact customer support?',
      'answer': 'You can contact our customer support team via email at support@example.com or by phone at +1 (123) 456-7890. Our support team is available Monday to Friday from 9:00 AM to 5:00 PM EST.',
    },
    {
      'question': 'Do you offer international shipping?',
      'answer': 'Yes, we offer international shipping to select countries. Shipping costs and delivery times vary depending on the destination. Please contact our customer support for more information regarding international shipping.',
    },
    {
      'question': 'What payment methods do you accept?',
      'answer': 'We accept various payment methods including credit/debit cards, PayPal, and bank transfers. You can select your preferred payment option during checkout.',
    },
    {
      'question': 'How do I unsubscribe from your mailing list?',
      'answer': 'To unsubscribe from our mailing list, you can click on the "Unsubscribe" link provided at the bottom of any promotional email you receive from us. Alternatively, you can contact our customer support for assistance.',
    },
    {
      'question': 'Can I cancel my order?',
      'answer': 'You can cancel your order within 24 hours of placing it. Please contact our customer support team with your order details to request a cancellation. Once an order has been processed for shipping, it cannot be canceled.',
    },
    // Add more FAQs here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center'),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Khoảng cách 2 bên trái phải nhiều hơn
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 3,
              child: ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    faqs[index]['question']!,
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold), // Chỉnh kích thước chữ nhỏ lại
                  ),
                ),
                children: <Widget>[
                  Container(
                    color: Color(0xFFF5F6F9), // Đổi màu nền của khung chữ
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      faqs[index]['answer']!,
                      style: TextStyle(fontSize: 12.0), // Chỉnh kích thước chữ nhỏ lại
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
