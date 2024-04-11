import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_page/controllers/auth_controller.dart';
import 'package:login_page/views/buyers/authorization/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController _authCOntroller = AuthController();

  late String email;
  late String fullName;
  late String password;

  registerUser() async{
    if (_formKey.currentState!.validate()) {
      BuildContext localContext = context;

      String response = await _authCOntroller.registerUser(email, fullName, password);

      if(response == 'success'){
        Future.delayed(Duration.zero, (){
          Navigator.push(localContext, MaterialPageRoute(builder: (context){
            return LoginScreen();
          },));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account Created')));
        });
      }
      else{
        Future.delayed(Duration.zero, (){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
          print(response);
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
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey, // valida el status del formulario
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create an account",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 23.0, color: Color(0XFF0D12FE))),
                    ),
                    Text(
                      "to explore world's exclusive",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(fontSize: 14.0)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: AssetImage('assets/icons/user.png'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid email address';
                        }
                      },
                      onChanged: (value){
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          labelText: 'Your Email',
                          hintText: 'user@email.com',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid name';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value){
                        fullName = value;
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          labelText: 'Your FullName',
                          hintText: 'your FullName',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value){
                        password = value;
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: Icon(Icons.visibility),
                          labelText: 'Your Password',
                          hintText: 'your Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        registerUser();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0XFF262FDE), Color(0XFF050957)]),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            'Register',
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          //Capa invisible que te permite hacer acciones
                          child: Text(
                            'Login now!',
                            style: GoogleFonts.roboto(
                                color: Color(0XFF0D12FE),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }))
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
