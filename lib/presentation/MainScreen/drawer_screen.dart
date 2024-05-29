import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../Models/user_model.dart';
import '../../Provider/provider_model.dart';
import '../../widgets/custom_elevated_button.dart';
class DrawerScreen extends StatefulWidget {
  final UserModel userModel;
  const DrawerScreen({required this.userModel,super.key});
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}
class _DrawerScreenState extends State<DrawerScreen> {
 late TextEditingController email;
 late TextEditingController name;
  final mailEditKey = GlobalKey<FormState>();
 final userEditKey = GlobalKey<FormState>();
 TextEditingController address=TextEditingController();

 @override
  void initState() {
email=TextEditingController(text: widget.userModel.email) ;
name=TextEditingController(text: widget.userModel.name);
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ModelProvider>(context);
    return Drawer(
      backgroundColor: Color(0xff514EB7),
      child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column( mainAxisAlignment: MainAxisAlignment.start,
              children:[
                const SizedBox(height: 30,),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/loading.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(widget.userModel.email,style:TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.white,
                    fontSize: 20
                ),),
                const SizedBox(height: 30,),

                Container(
                  color: Colors.white,
                  height: 0.5,
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    showModalBottomSheet<void>(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                      ),
                      backgroundColor: Colors.white,
                      builder: (BuildContext context) {
                        return showSheet();
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.edit_calendar,size: 30,color: Colors.white,),
                      const SizedBox(width: 15,),
                      Text('تحديث المعلومات',style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          color: Colors.white
                      ),)
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  color: Colors.white,
                  height: 0.5,
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    showModalBottomSheet<void>(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                      ),
                      backgroundColor: Colors.white,
                      builder: (BuildContext context) {
                        return showSheet();
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.password,size: 30,color: Colors.white,),
                      const SizedBox(width: 15,),
                      Text('تغيير كلمة السر',style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          color: Colors.white
                      ),)
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  color: Colors.white,
                  height: 0.5,
                ),
                const SizedBox(height: 20,),

                InkWell(
                  onTap: (){},
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app,size: 30,color: Colors.white,),
                      const SizedBox(width: 15,),
                      Text('تسجيل الخروج',style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          color: Colors.white
                      ),)
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
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
  Widget showSheet(){
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundColor: Color(0xff00D261),
                  radius: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/loading.png'),
                        )
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(' اسم المستخدم :',style: TextStyle(
                    fontFamily: 'Cairo',
                  ),),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 400,
                    child: Form(
                      key: userEditKey,
                      child: TextFormField(
                        style: TextStyle(
                            height: 1,
                            fontSize: 13,
                            fontFamily: 'Cairo'
                        ),
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: name,
                        decoration: InputDecoration(
                            hintText: "اسم المستخدم",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                    color:Colors.grey)
                            ),
                            fillColor: Color(0xffF5F5F5),
                            filled: true,
                            prefixIcon: const Icon(Icons.person)),
                        textInputAction: TextInputAction.done,
                        validator: validateUser,
                      ),
                    ),
                  ),
                ],
              ),
            ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(' البريد الالكتروني :',style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      color: Colors.black54
                    ),),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 400,
                      child: Form(
                        key: mailEditKey,
                        child: TextFormField(
                          style: TextStyle(
                              height: 1,
                            fontSize: 13
                          ),
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z.]")),
                          ],
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: email,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                      color: Colors.grey
                                  )
                              ),
                              fillColor: Color(0xffF5F5F5),
                              filled: true,
                              prefixIcon: const Icon(Icons.email_outlined)),
                          textInputAction: TextInputAction.done,
                          validator: validateEmail,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(' عنوان السكن :',style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        color: Colors.black54
                    ),),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 400,
                      child: Form(
                        child: TextFormField(
                          style: TextStyle(
                              height: 1,
                              fontSize: 12
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: address,
                          decoration: InputDecoration(
                              hintText: "ذي قار_ سوق الشيوخ _ كرمة بني سعيد",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                      color: Colors.grey
                                  )
                              ),
                              fillColor: Color(0xffF5F5F5),
                              filled: true,
                              prefixIcon: const Icon(Icons.home)),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    isFill: false,
                    onPressed: (){
                    },
                    text: "الغاء",
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CustomElevatedButton(
                    isFill: true,
                    onPressed: (){
                    },
                    text: "حفظ البيانات",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
 String? validateUser(String? value) {

   return value!.isEmpty
       ? 'اسم المستخدم مطلوب'
       : null;
 }

}
