import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        //Eje x/horizontal/derecha-izquierda 20px
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
                width: size.width,
                height: 200,
                child:
                    RiveAnimation.asset('assets/animated_login_character.riv')),
            //Espacio entre el oso y el texto email
            const SizedBox(height: 10),
            //Campo de texto email
            TextField(
              //Para que el teclado sea de email en móviles
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mail),
                border: OutlineInputBorder(
                    //Esquinas redondeadas
                    borderRadius: BorderRadius.circular(12)),
                //Texto que aparece cuando no hay nada escrito
                labelText: "Email",
              ),
            ),
            //Espacio entre el texto email y el texto password
            const SizedBox(height: 10),
            //Campo de texto password
            TextField(
              //Para que el teclado sea de password visible en móviles
              keyboardType: TextInputType.visiblePassword,
              obscureText: _isObscure,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                      //Esquinas redondeadas
                      borderRadius: BorderRadius.circular(12)),
                  //Texto que aparece cuando no hay nada escrito
                  labelText: "Password",
                  //Para que no se vea la contraseña
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ))),
            ),
          ],
        ),
      ),
    ));
  }
}
