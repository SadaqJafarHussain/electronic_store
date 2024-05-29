import 'dart:async';

import 'package:electronic_store/Provider/provider_model.dart';
import 'package:electronic_store/presentation/MainScreen/main_screen.dart';
import 'package:electronic_store/presentation/Sign%20up/sign_up.dart';
import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../Sign in/sign_in.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final mailUpKey = GlobalKey<FormState>();
  final passUpKey = GlobalKey<FormState>();
  final userUpKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  Color emailBorderColor = Colors.white;
  Color passwordBorderColor = Colors.white;
  Color userBorderColor = Colors.white;
  String errorMessage='';

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
return value!.isEmpty || !regex.hasMatch(value)?
  'ادخل بريد الكتروني صالح'
: null;


  }

  String? validateUser(String? value) {

    return value!.isEmpty
        ? 'اسم المستخدم مطلوب'
        : null;
  }

  String? validatePassword(String? value) {
    RegExp regex =
    RegExp(r'^.{8,}$');
    if (value!.isEmpty) {
      return 'كلمة السر مطلوبة';
    } else {
      if (!regex.hasMatch(value)) {
        return 'يجب ان ان يكون طول الباسورد 8 احرف او ارقام';
      } else {
        return null;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _signIn(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "انشاء حساب جدبد",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
        ),
        Text(
          "ادخل معلوماتك لتسجيل حساب جديد",
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        errorMessage == ''
            ? Container()
            : Text(
          '$errorMessage',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('اسم المستخدم :',
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),),
        const SizedBox(
          height: 10,
        ),
        Form(
          key: userUpKey,
          child: TextFormField(
            style: TextStyle(height: 0.8),
            keyboardType: TextInputType.text,
            autocorrect: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: userName,
            decoration: InputDecoration(
                hintText: "اصيل محمد",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                        color: userBorderColor, width: 1.0)
                ),
                fillColor: Color(0xffF5F5F5),
                filled: true,
                prefixIcon: const Icon(Icons.person)),
            textInputAction: TextInputAction.done,
            validator: validateUser,
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  userBorderColor = Color(0xFFE91e63);
                }
                else {
                  userBorderColor = Colors.white;
                }
              });
            },
          ),
        ),
        const SizedBox(height: 20,),
        Text('البريد الالكتروني :',
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),),
        const SizedBox(
          height: 10,
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: mailUpKey,
            child: TextFormField(
              style: TextStyle(height: 0.8),
              keyboardType: TextInputType.emailAddress,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z.]")),
              ],
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: email,
              decoration: InputDecoration(
                  hintText: "example@gmail.com",

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          color: emailBorderColor, width: 1.0)
                  ),
                  fillColor: Color(0xffF5F5F5),
                  filled: true,
                  prefixIcon: const Icon(Icons.email_outlined)),
              textInputAction: TextInputAction.done,
              validator: validateEmail,
              onChanged: (value) {
                setState(() {
                  if (validateEmail(value) == null) {
                    emailBorderColor = Color(0xFFE91e63);
                  }
                  else {
                    emailBorderColor = Colors.white;
                  }
                });
              },


            ),
          ),
        ),
        const SizedBox(height: 20),
        Text('كلمة السر :',
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),),
        const SizedBox(
          height: 10,
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: passUpKey,
            child: TextFormField(
              style: TextStyle(height: 0.8),
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: password,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "********",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                        color: passwordBorderColor, width: 1.0)),
                fillColor: Color(0xffF5F5F5),
                filled: true,
                prefixIcon: const Icon(Icons.password),
              ),
              textInputAction: TextInputAction.done,
              validator: validatePassword,
              onChanged: (value) {
                setState(() {
                  if (validatePassword(value) == null) {
                    emailBorderColor = Color(0xFFE91e63);
                  }
                  else {
                    emailBorderColor = Colors.white;
                  }
                });
              },
              obscureText: true,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final passValidate = passUpKey.currentState!.validate();
            final isValidate = mailUpKey.currentState!.validate();
            final userValid=userUpKey.currentState!.validate();
            if (isValidate && passValidate&&userValid){
               Provider.of<ModelProvider>(context,listen: false).signUpMethod(email.text, userName.text, password.text);
              Timer(Duration(seconds: 2),(){
                   if(Provider.of<ModelProvider>(context,listen: false).statusCode==200){
                     setState(() {
                       errorMessage='';
                       emailBorderColor=Colors.white;
                     });
                     showModalBottomSheet<void>(
                       context: context,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                       ),
                       backgroundColor: Colors.white,
                       builder: (BuildContext context) {
                         return Container(
                           height: 300,
                           color: Colors.transparent,
                           child: Center(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: <Widget>[
                                 CircleAvatar(
                                   backgroundColor: Color(0xffF5F5F5),
                                   radius: 50,
                                   child: CircleAvatar(
                                     radius: 40,
                                     backgroundColor: Color(0xff00D261),
                                     child: Icon(Icons.check_circle,color: Colors.white,
                                       size: 40,),
                                   ),
                                 ),
                                 const Text('تم تسجيل حسابك بنجاح',
                                   style: TextStyle(
                                     fontFamily: 'Cairo',
                                     fontSize: 20,
                                     color: Colors.black87,
                                     fontWeight: FontWeight.bold,
                                   ),),
                                 const SizedBox(height: 30,),
                                 ElevatedButton(
                                   child: Padding(
                                     padding: const EdgeInsets.only(left: 30.0,right: 30.0,top: 15,bottom: 15),
                                     child: const Text('الذهاب الى الرئيسية',
                                       style: TextStyle(
                                         fontFamily: 'Cairo',
                                         fontSize: 15,
                                         color: Colors.white,
                                         fontWeight: FontWeight.bold,
                                       ),),
                                   ),
                                   onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen())),
                                 ),
                               ],
                             ),
                           ),
                         );
                       },
                     );
                   }else if(Provider.of<ModelProvider>(context,listen: false).statusCode==401){
                     setState(() {
                       errorMessage='البريد الالكتروني موجود بالفعل قم بتسجيل الدخول';
                       emailBorderColor=Colors.red;
                     });
                   }
               });
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Color(0xff514EB7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: const Text(
                "انشاء الحساب",
                style: TextStyle(fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Cairo'),
              ),
            ),
          ),
        )
      ],
    );
  }

  _signIn(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("لديك حساب بالفعل ؟", style: TextStyle(fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontFamily: 'Cairo')),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => SignIn()));
            },
            child: const Text("تسجيل الدخول", style: TextStyle(fontSize: 13,
                color: Color(0xff514EB7),
                fontWeight: FontWeight.w700,
                fontFamily: 'Cairo'))
        )
      ],
    );
  }
}