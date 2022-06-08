import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:second_api_project/screen/login_page.dart';

import '../http/custome_http_request.dart';
import '../widget/brand_colors.dart';
import '../widget/custom_TextField.dart';
import '../widget/widget.dart';

class RegistationPage extends StatefulWidget {
  const RegistationPage({Key? key}) : super(key: key);

  @override
  State<RegistationPage> createState() => _RegistationPageState();
}

class _RegistationPageState extends State<RegistationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;
  getRegister(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var map = <String, dynamic>{};
    map["name"] = nameController.text.toString();
    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    map["password_confirmation"] = confirmPasswordController.text.toString();
    var responce = await http.post(
      Uri.parse("$uri${CustomHttpRequest.registration}"),
      body: map,
      headers: CustomHttpRequest.defaultHeader,
    );
    print(responce.body);

    var data = jsonDecode(responce.body);
    if (responce.statusCode == 201) {
      showInToast("Registation Successful");
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage() ));
    } else {
      showInToast("${data["errors"]["email"]}");
    }
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading == true,
        opacity: 0.0,
        progressIndicator: const CircularProgressIndicator(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: nameController,
                  hintText: "Enter your name",
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: "Enter your email",
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Enter your password",
                ),
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm password",
                ),


                MaterialButton(
                  onPressed: () {
                    getRegister(context);
                  },
                  color: Colors.orange,
                  child: const Text("Register"),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage() ));
                        }, child: const Text('Login')
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
