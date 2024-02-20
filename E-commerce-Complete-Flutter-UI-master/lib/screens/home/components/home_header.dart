// import 'package:flutter/material.dart';

// import '../../cart/cart_screen.dart';
// import 'icon_btn_with_counter.dart';
// import 'search_field.dart';

// class HomeHeader extends StatelessWidget {
//   const HomeHeader({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Expanded(child: SearchField()),
//           const SizedBox(width: 16),
//           IconBtnWithCounter(
//             svgSrc: "assets/icons/Cart Icon.svg",
//             press: () => Navigator.pushNamed(context, CartScreen.routeName),
//           ),
//           const SizedBox(width: 8),
//           IconBtnWithCounter(
//             svgSrc: "assets/icons/Bell.svg",
//             numOfitem: 3,
//             press: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/services/auth_service.dart';
import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: SearchField()),
          const SizedBox(width: 16),
          FutureBuilder<bool>(
            future: AuthService().isLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show loading indicator while checking login status
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              final isLoggedIn = snapshot.data ?? false;
              return isLoggedIn
                  ? IconBtnWithCounter(
                      svgSrc: "assets/icons/Cart Icon.svg",
                      press: () =>
                          Navigator.pushNamed(context, CartScreen.routeName),
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                      icon: Icon(Icons.shopping_cart),
                    );
            },
          ),
          const SizedBox(width: 8),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
