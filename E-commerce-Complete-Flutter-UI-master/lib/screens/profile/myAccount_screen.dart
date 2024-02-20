// import 'package:flutter/material.dart';
// import 'package:shop_app/services/auth_service.dart';
// import 'package:shop_app/services/user_service.dart';

// import '../../../components/custom_surfix_icon.dart';
// import '../../../components/form_error.dart';
// import '../../../constants.dart';

// class MyAccountScreen extends StatefulWidget {
//   static String routeName = "/account";

//   const MyAccountScreen({Key? key}) : super(key: key);

//   @override
//   _MyAccountScreenState createState() => _MyAccountScreenState();
// }

// class _MyAccountScreenState extends State<MyAccountScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final List<String> errors = [];
//   String? firstName;
//   String? lastName;
//   String? phoneNumber;
//   String? email;
//   bool isEditing = false;

//   AuthService _authService = AuthService();
//   UserService _userService = UserService();

//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//   }

//   void getUserData() async {
//     try {
//       Map<String, dynamic> userData = await _userService.getUserData();
//       int userId = userData['id'];
//       Map<String, dynamic> userDetails = await _userService.getUserById(userId);

//       setState(() {
//         firstName = userDetails['firstname'];
//         lastName = userDetails['lastname'];
//         phoneNumber = userDetails['phoneNumber'];
//         email = userDetails['email'];
//       });
//     } catch (e) {
//       print("Error getting user data: $e");
//       // Xử lý lỗi khi không thể lấy dữ liệu người dùng
//     }
//   }

//   void addError({required String error}) {
//     if (!errors.contains(error)) {
//       setState(() {
//         errors.add(error);
//       });
//     }
//   }

//   void removeError({required String error}) {
//     if (errors.contains(error)) {
//       setState(() {
//         errors.remove(error);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Account"),
//         actions: [
//           IconButton(
//             icon: Icon(isEditing ? Icons.save : Icons.edit),
//             onPressed: () {
//               setState(() {
//                 isEditing = !isEditing;
//               });
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Email: $email",
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 enabled: isEditing,
//                 initialValue: firstName,
//                 onSaved: (newValue) => firstName = newValue,
//                 decoration: InputDecoration(
//                   labelText: "First Name",
//                   hintText: "Enter your first name",
//                   floatingLabelBehavior: FloatingLabelBehavior.always,
//                   suffixIcon:
//                       CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 enabled: isEditing,
//                 initialValue: lastName,
//                 onSaved: (newValue) => lastName = newValue,
//                 decoration: InputDecoration(
//                   labelText: "Last Name",
//                   hintText: "Enter your last name",
//                   floatingLabelBehavior: FloatingLabelBehavior.always,
//                   suffixIcon:
//                       CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 enabled: isEditing,
//                 initialValue: phoneNumber,
//                 keyboardType: TextInputType.phone,
//                 onSaved: (newValue) => phoneNumber = newValue,
//                 decoration: InputDecoration(
//                   labelText: "Phone Number",
//                   hintText: "Enter your phone number",
//                   floatingLabelBehavior: FloatingLabelBehavior.always,
//                   suffixIcon:
//                       CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
//                 ),
//               ),
//               FormError(errors: errors),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: isEditing
//                     ? () async {
//                         if (_formKey.currentState!.validate()) {
//                           _formKey.currentState!.save();
//                           try {
//                             await _userService.updateUser(1, {
//                               'firstname': firstName,
//                               'lastname': lastName,
//                               'phoneNumber': phoneNumber,
//                               'email': email,
//                             });

//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Your information has been saved.'),
//                               ),
//                             );
//                           } catch (e) {
//                             print("Error updating user data: $e");
//                             // Xử lý lỗi khi không thể cập nhật thông tin người dùng
//                           }
//                         }
//                       }
//                     : null,
//                 child: Text("Save"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
