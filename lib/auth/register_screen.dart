import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/registerScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body:
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/img.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create account',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppTheme.backGroundColorDark, fontSize: 24),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                DefaultTextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter your name ';
                    } else {
                      return null;
                    }
                  },
                  controller: nameController,
                  hintText: 'Please enter your name ',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                DefaultTextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter your email ';
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  hintText: 'Please enter your email ',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                DefaultTextFormField(
                  isPassWord: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter your password ';
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  hintText: 'Please enter your password ',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                DefaultElevatedButton(
                  onPressed: () {
                    register();
                    if (formKey.currentState!.validate()) {
                    } else {
                      return;
                    }
                  },
                  label: 'Create account',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName),
                  child: Text(
                    'Already have an account ? ',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                color: AppTheme.primary,
              ),
            );
          });
      FirebaseFunctions.register(
        password: passwordController.text,
        name: nameController.text,
        email: emailController.text,
      ).then((user){
        Provider.of<UserProvider>(context,listen: false,).updatUser(user);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomeScreen.routeName,(_)=>false,);
      }).catchError((error){
        String? message ;
        if(error is FirebaseAuthException){
          message = error.message;
        }
        Fluttertoast.showToast(
            msg: message ?? "Something went wrong !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
  }
}
