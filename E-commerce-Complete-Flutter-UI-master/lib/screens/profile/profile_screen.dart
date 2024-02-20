import 'package:flutter/material.dart';
import 'package:shop_app/screens/address/address_screen.dart';
import 'package:shop_app/screens/profile/helpCenter_screen.dart';
import 'package:shop_app/screens/profile/myAccount_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/services/auth_service.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showBackButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        automaticallyImplyLeading: showBackButton,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "Edit Personal Information",
              icon: "assets/icons/User Icon.svg",
              press: () {
                // Khi chuyển đến trang khác, hiển thị nút back
                setState(() {
                  showBackButton = true;
                });
                // Điều hướng đến trang SettingsScreen
                //Navigator.pushNamed(context, MyAccountScreen.routeName);
              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {
                // Khi chuyển đến trang khác, hiển thị nút back
                setState(() {
                  showBackButton = true;
                });
                // Điều hướng đến trang NotificationsScreen
                //Navigator.pushNamed(context, NotificationsScreen.routeName);
              },
            ),
            ProfileMenu(
              text: "Shipping Addresses",
              icon: "assets/icons/Location point.svg",
              press: () {
                // Khi chuyển đến trang khác, hiển thị nút back
                setState(() {
                  showBackButton = true;
                });
                // Điều hướng đến trang SettingsScreen
                Navigator.pushNamed(context, AddScreen.routeName);
              },
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {
                // Khi chuyển đến trang khác, hiển thị nút back
                setState(() {
                  showBackButton = true;
                });
                // Điều hướng đến trang HelpCenterScreen
                Navigator.pushNamed(context, HelpCenterScreen.routeName);
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {
                AuthService().logout();
                // Sử dụng pushReplacementNamed để thay thế trang hiện tại bằng SignInScreen
                Navigator.pushReplacementNamed(context, SignInScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
