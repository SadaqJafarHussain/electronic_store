import 'package:electronic_store/Provider/provider_model.dart';
import 'package:electronic_store/presentation/MainScreen/main_screen.dart';
import 'package:electronic_store/presentation/Sign%20up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final mailKey = GlobalKey<FormState>();
  final passKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  Color emailBorderColor = Color(0xffF5F5F5);
  Color passwordBorderColor = Color(0xffF5F5F5);
  String errorMessage = '';

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value)
        ? 'ادخل بريد الكتروني صالح'
        : null;
  }

  String? validatePassword(String? value) {
    RegExp regex = RegExp(r'^.{8,}$');
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
          height: 500,
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              _inputField(context),
              _signup(context),
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
          "تسجيل الدخول",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
        ),
        Text(
          "ادخل معلوماتك لتسجيل الدخول",
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
            key: mailKey,
            child: TextFormField(
              style: TextStyle(
                height: 0.8,
              ),
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
                      borderSide:
                          BorderSide(color: emailBorderColor, width: 1.0)),
                  fillColor: Color(0xffF5F5F5),
                  filled: true,
                  prefixIcon: const Icon(Icons.person)),
              textInputAction: TextInputAction.done,
              validator: validateEmail,
              onChanged: (value) {
                setState(() {
                  if (validateEmail(value) == null) {
                    emailBorderColor = Color(0xFFE91e63);
                  } else {
                    emailBorderColor = Color(0xffF5F5F5);
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
        const SizedBox(height: 10),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: passKey,
            child: TextFormField(
              style: TextStyle(
                height: 0.8,
              ),
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: password,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "********",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide:
                        BorderSide(color: passwordBorderColor, width: 1.0)),
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
                  } else {
                    emailBorderColor = Color(0xffF5F5F5);
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
            final passValidate = passKey.currentState!.validate();
            final isValidate = mailKey.currentState!.validate();
            if (isValidate && passValidate) {
              Provider.of<ModelProvider>(context, listen: false)
                  .logInMethod(email.text, password.text);
              if (Provider.of<ModelProvider>(context, listen: false)
                      .statusCode ==
                  200) {
                setState(() {
                  errorMessage = '';
                  emailBorderColor = Colors.white;
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
                            const Text('تم تسجيل الدخول',
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
              }else if(Provider.of<ModelProvider>(context,listen: false).statusCode==401||Provider.of<ModelProvider>(context,listen: false).statusCode==400){
                setState(() {
                  errorMessage='البريد الالكتروني  غير موجود او كلمة السر غير صحيحه !';
                  emailBorderColor=Colors.red;
                });
              }
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
                "تسجيل الدخول",
                style: TextStyle(
                    fontSize: 15,
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

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("لا تملك حساب ؟",
            style: TextStyle(
                fontSize: 13,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo')),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => SignUp()));
            },
            child: const Text("انشاء حساب",
                style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff514EB7),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo')))
      ],
    );
  }
}
