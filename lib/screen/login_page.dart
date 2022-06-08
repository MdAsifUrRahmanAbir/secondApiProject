import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:second_api_project/screen/registation_page.dart';
import 'package:second_api_project/tab_item/tab_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/custome_http_request.dart';
import '../widget/brand_colors.dart';
import '../widget/custom_TextField.dart';
import '../widget/widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late SharedPreferences sharedPreferences;
  String? token;

  bool isLoading = false;
  getLogin(BuildContext context) async {

    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      isLoading = true;
    });
    var map = <String, dynamic>{};
    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    var responce = await http.post(
      Uri.parse("$uri${CustomHttpRequest.login}"),
      body: map,
      //headers: CustomHttpRequest.defaultHeader,
    );
    print(responce.body);

    var data = jsonDecode(responce.body);
    if (responce.statusCode == 200) {
      showInToast("Login Successful");
      setState(() {
        sharedPreferences.setString("token", data['access_token']);
      });

      token = sharedPreferences.getString("token");
      print('Token is $token');

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> TabMenu()));
    } else {
      showInToast("${data["error"]}");
    }

    setState(() {
      isLoading = false;
    });
  }

  isLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString('token')!= null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> TabMenu()));
    }else{
      print("Token is empty");
    }
  }

  @override
  void initState() {
    print(token);
    isLogin();
    // TODO: implement initState
    super.initState();
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
                  controller: emailController,
                  hintText: "Enter your email",
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Enter your password",
                ),
                MaterialButton(
                  onPressed: () {
                    getLogin(context);
                  },
                  color: Colors.orange,
                  child: const Text("Login"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistationPage() ));
                        }, child: const Text('Signup')
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
