import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Controlar si la contraseña se ve o no
  bool _isObscure = true;
  //Cerebro de la logica de las animaciones
  StateMachineController? controller;
  //SMI= Statae Machine Input
  SMIBool? isChecking; //Activa el modo chismoso
  SMIBool? isHandsUp; //Se tapa los ojos
  SMITrigger? trigSuccess; // Se emociona
  SMITrigger? trigFail; // Se pone sad

  // 1) FocusNode
  final emailFocus = FocusNode();
  final passFocus = FocusNode();

  // 2) Listeners (Oyentes/Chismosos)
  @override
  void initState() {
    super.initState();
    emailFocus.addListener(() {
      if (emailFocus.hasFocus) {
        //Manos abajo en email
        isHandsUp?.change(false);
      }
    });
    passFocus.addListener(() {
      //Manos arriba en password
      isHandsUp?.change(passFocus.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    //Consulta el tamaño de la pantalla
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
                child: RiveAnimation.asset(
                    'assets/animated_login_character.riv',
                    stateMachines: ["Login Machine"],
                    //Al iniciarse
                    onInit: (artboard) {
                  controller = StateMachineController.fromArtboard(
                      artboard, "Login Machine");
                  //Verificar que inició bien
                  if (controller == null) return;
                  artboard.addController(controller!);
                  //Asignar las variables
                  isChecking = controller!.findSMI("isChecking");
                  isHandsUp = controller!.findSMI("isHandsUp");
                  trigSuccess = controller!.findSMI("trigSuccess");
                  trigFail = controller!.findSMI("trigFail");
                })),
            //Espacio entre el oso y el texto email
            const SizedBox(height: 10),
            //Campo de texto email
            TextField(
              // 3) Asignas el focusNode al TextField
              //Llamas a tu familia chismosa
              focusNode: emailFocus,
              onChanged: (value) {
                if (isHandsUp != null) {
                  //No tapar los ojos al escribir el mail
                  //isHandsUp!.change(false);
                }
                if (isChecking == null) return;
                //Activar el modo chismoso
                isChecking!.change(true);
              },
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
            //Password con toggle de visibilidad
            TextField(
              //3) Asignas el focusNode al TextField
              //Llamas a tu familia chismosa
              focusNode: passFocus,
              onChanged: (value) {
                if (isChecking != null) {
                  //No tapar los ojos al escribir el mail
                  //isChecking!.change(false);
                }
                if (isHandsUp == null) return;
                //Activar el modo chismoso
                isHandsUp!.change(true);
              },
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
            const SizedBox(height: 10),
            //Texto "Forgot your password?" alineado a la derecha
            SizedBox(
              width: size.width,
              child: const Text(
                "¿Forgot your password?",
                //Alinear a la derecha
                textAlign: TextAlign.right,
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
            //Boton de Login
            const SizedBox(height: 10),
            //Boton estilo Android
            MaterialButton(
              onPressed: () {
                //TODO:
              },
              minWidth: size.width,
              height: 50,
              color: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child:
                  const Text("Log In", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Don´t have an account?"),
                TextButton(
                  onPressed: () {},
                  child: const Text("Register",
                      style: TextStyle(
                          color: Colors.black,
                          //En negritas
                          fontWeight: FontWeight.bold,
                          //Subrayado
                          decoration: TextDecoration.underline)),
                  //El STATE MACHINE ES COMO EL CEREBRO QUE DECIDE QUE ANIMACION CORRE Y CUANDO
                ),
              ]),
            ),
          ],
        ),
      ),
    ));
  }

  //4) Liberación de recursos / limpieza de focos
  @override
  void dispose() {
    emailFocus.dispose();
    passFocus.dispose();
    super.dispose();
  }
}
