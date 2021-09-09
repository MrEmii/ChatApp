import 'package:chatapp/dialogs/alerts_dialogs.dart';
import 'package:chatapp/services/services.dart';
import 'package:chatapp/widgets/button.dart';
import 'package:chatapp/widgets/custom_input.dart';
import 'package:chatapp/widgets/labels.dart';
import 'package:chatapp/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {

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
                Logo(title: "DotMSN",),

                _Form(),

                Labels(
                  title: "¿No tienes cuenta?",
                  subtitle: "¡Creá una ahora!",
                  route: "register",
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

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        child: Column(
          children: [
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
              text: "Ingresar",
              onTap: () async {

                FocusScope.of(context).unfocus();

                if( emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Faltan ingresar datos....")));
                  return;
                }

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => Center(child: CircularProgressIndicator(),)
                );

                final isSignIn = await authService.login(email: emailController.text, password: passwordController.text);
                Navigator.pop(context);

                if(isSignIn) {

                  print("HOLA");
                }else{
                  showAlert(context, "No se pudo", "No iniciaste sesion flaco jaj");

                }


                Navigator.pop(context);
              }
            )
          ],
        ),
      ),
    );
  }
}
