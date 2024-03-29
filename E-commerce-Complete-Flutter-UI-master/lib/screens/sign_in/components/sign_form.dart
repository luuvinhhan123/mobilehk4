// import 'package:flutter/material.dart';
// import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
// import 'package:shop_app/screens/login_success/login_success_screen.dart';
// import 'package:shop_app/services/auth_service.dart';
// import 'package:shop_app/components/form_error.dart';
// import 'package:shop_app/constants.dart';

// class SignForm extends StatefulWidget {
//   const SignForm({Key? key}) : super(key: key);

//   @override
//   _SignFormState createState() => _SignFormState();
// }

// class _SignFormState extends State<SignForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? email;
//   String? password;
//   bool remember = false;
//   final List<String?> errors = [];
//   String? loginErrorMessage;

//   void addError({String? error}) {
//     if (!errors.contains(error)) {
//       setState(() {
//         errors.add(error);
//       });
//     }
//   }

//   void removeError({String? error}) {
//     if (errors.contains(error)) {
//       setState(() {
//         errors.remove(error);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kEmailNullError);
//               }
//               if (emailValidatorRegExp.hasMatch(value)) {
//                 removeError(error: kInvalidEmailError);
//               }
//               email = value;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kEmailNullError);
//                 return "";
//               } else if (!emailValidatorRegExp.hasMatch(value)) {
//                 addError(error: kInvalidEmailError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "Email",
//               hintText: "Enter your email",
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             obscureText: true,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kPassNullError);
//               } else if (value.length >= 8) {
//                 removeError(error: kShortPassError);
//               }
//               password = value;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kPassNullError);
//                 return "";
//               } else if (value.length < 8) {
//                 addError(error: kShortPassError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "Password",
//               hintText: "Enter your password",
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Checkbox(
//                 value: remember,
//                 activeColor: kPrimaryColor,
//                 onChanged: (value) {
//                   setState(() {
//                     remember = value ?? false; // Cập nhật giá trị remember
//                   });
//                 },
//               ),
//               Text("Remember me"),
//               Spacer(),
//               GestureDetector(
//                 onTap: () => Navigator.pushNamed(
//                   context,
//                   ForgotPasswordScreen.routeName,
//                 ),
//                 child: const Text(
//                   "Forgot Password",
//                   style: TextStyle(decoration: TextDecoration.underline),
//                 ),
//               ),
//             ],
//           ),
//           FormError(errors: errors),
//           if (loginErrorMessage != null)
//             Text(
//               loginErrorMessage!,
//               style: TextStyle(color: Colors.red),
//             ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () async {
//               if (_formKey.currentState!.validate()) {
//                 _formKey.currentState!.save();
//                 try {
//                   final authService = AuthService();
//                   final result = await authService.sendEmailAndPassword(
//                     email!,
//                     password!,
//                   );
//                   if (remember) {
//                     await authService.saveRememberMe(true);
//                   } else {
//                     await authService.saveRememberMe(false);
//                   }
//                   Navigator.pushNamed(context, LoginSuccessScreen.routeName);
//                 } catch (e) {
//                   print('Error during login: $e');
//                   setState(() {
//                     loginErrorMessage =
//                         'Failed to login. Invalid email or password, try again!';
//                   });
//                 }
//               }
//             },
//             child: Text("Sign In"),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/services/auth_service.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/constants.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool remember = false;
  final List<String?> errors = [];
  String? loginErrorMessage;
  String? savedEmail;
  String? savedPassword;

  @override
  void initState() {
    super.initState();
    // Lấy thông tin về email và mật khẩu đã lưu khi widget được khởi tạo
    getSavedCredentials();
  }

  void getSavedCredentials() async {
    final authService = AuthService();
    final savedCredentials = await authService.getRememberedCredentials();
    setState(() {
      savedEmail = savedCredentials['email'];
      savedPassword = savedCredentials['password'];
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: savedEmail ?? '', // Hiển thị email đã lưu (nếu có)
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              }
              if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              email = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: savedPassword ?? '', // Hiển thị mật khẩu đã lưu (nếu có)
            obscureText: true,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 8) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value ?? false; // Cập nhật giá trị remember
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  ForgotPasswordScreen.routeName,
                ),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          FormError(errors: errors),
          if (loginErrorMessage != null)
            Text(
              loginErrorMessage!,
              style: TextStyle(color: Colors.red),
            ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                try {
                  final authService = AuthService();
                  final result = await authService.sendEmailAndPassword(
                    email!,
                    password!,
                  );
                  if (remember) {
                    await authService.saveRememberMe(true);
                  } else {
                    await authService.saveRememberMe(false);
                  }
                  Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                } catch (e) {
                  print('Error during login: $e');
                  setState(() {
                    loginErrorMessage =
                        'Failed to login. Invalid email or password, try again!';
                  });
                }
              }
            },
            child: Text("Sign In"),
          ),
        ],
      ),
    );
  }
}
