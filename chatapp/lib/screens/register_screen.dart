import 'package:chatapp/widgets/button.dart';
import 'package:chatapp/widgets/custom_input.dart';
import 'package:chatapp/widgets/labels.dart';
import 'package:chatapp/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * .9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(title: "Registro",),

                _Form(),

                Labels(
                  title: "¿Ya tienes una cuenta?",
                  subtitle: "Ingresá ahora",
                  route: "login",
                ),

                Text("Términos y condiciones de uso", style: TextStyle(fontWeight: FontWeight.w200),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        child: Column(
          children: [
            CustomInput(
              icon: CupertinoIcons.person,
              placeholder: "Nombre",
              controller: usernameController,
            ),
            CustomInput(
              icon: CupertinoIcons.mail,
              placeholder: "Correo",
              keyboard: TextInputType.emailAddress,
              controller: emailController,
            ),
            CustomInput(
              icon: CupertinoIcons.lock,
              placeholder: "Contraseña",
              controller: passwordController,
              isPassword: true,
            ),

            Button(
              text: "Registrarse",
              onTap: (){
                print("PEPE");
              }
            )
          ],
        ),
      ),
    );
  }
}
