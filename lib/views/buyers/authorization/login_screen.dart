import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_page/controllers/auth_controller.dart';
import 'package:login_page/views/buyers/authorization/register_screen.dart';
import 'package:login_page/views/buyers/nav_screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;

  late String password;

  bool _isLoading = false;

  bool _isObscure = true;

  final GlobalKey<FormState>  _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  signInUser() async{

    setState(() {
      _isLoading = true;
    });

    if(_formKey.currentState!.validate()){

      BuildContext localContext = context;
      var response = await _authController.LoginUser(email, password);
      if(response == 'success'){
        Future.delayed(Duration.zero, (){
          Navigator.pushReplacement(localContext, MaterialPageRoute(builder: (context){
            return const MainScreen();
          },));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account Created')));
        }).whenComplete((){
          setState(() {
            _formKey.currentState!.reset();
            _isLoading = false;
          });
        });

      }
      else{
        Future.delayed(Duration.zero, (){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
        }).whenComplete((){
          setState(() {
            _isLoading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login to your Account',
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 23.0,
                            color: Color(0xff050957),
                            fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    "to explore the world exclusive",
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/images/Illustration.png',
                    width: 200,
                    height: 200,
                  ),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please enter an email';
                      }
                      else{
                        return null;
                      }
                    },
                    onChanged: (value){
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Color(0XFF0D12FF),
                      ),
                      labelText: 'Email',
                      hintText: 'user@email.com',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please enter a password';
                      }
                      else{
                        return null;
                      }
                    },
                    onChanged: (value){
                      password = value;
                    },
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0XFF0D12FF),
                      ),
                      suffixIcon: InkWell(
                        onTap: (){
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                          child: const Icon(Icons.visibility)
                      ),
                      labelText: 'Password',
                      hintText: 'your password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return const MainScreen();
                      },));
                      //signInUser();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color(0xFF262fde),
                            Color(0xff050957),
                          ]),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                        child: _isLoading
                        ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                        : Text(
                          'Login',
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Need an Account'),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Text(
                          'Register here!',
                          style: GoogleFonts.roboto(
                            color: const Color(0xff050957),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const RegisterScreen();
                          }));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
