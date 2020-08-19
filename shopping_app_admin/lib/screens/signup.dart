import 'package:flutter/material.dart';
import 'package:shoppingappadmin/db/user_provider.dart';
import 'package:shoppingappadmin/screens/admin.dart';
import 'package:shoppingappadmin/screens/loading.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  bool hidePass = true;
  bool loading = false;
  String error='';
  final UserProvider _provider = UserProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body:loading?Loading():Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[350],
                    blurRadius: 20,
                  ),
                ]
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height:40),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'images/cart.png',
                            width: 120.0,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 8.0, 14, 8),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              controller: _name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Full Name",
                                icon: Icon(Icons.person_outline),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "The name field cannot be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 8.0, 14, 8),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              controller: _email,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                icon: Icon(Icons.alternate_email),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  Pattern pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(value))
                                    return 'Please make sure your email address is valid';
                                  else
                                    return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 8.0, 14, 8),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              obscureText: hidePass,
                              controller: _password,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.green,
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "The password field cannot be empty";
                                } else if (value.length < 6) {
                                  return "The password has to be atleast 6 characters long";
                                }
                                return null;
                              },
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    hidePass = false;
                                  });
                                }),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 8.0, 14, 8),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                              title: TextFormField(
                                obscureText: hidePass,
                                controller: _mobileController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Mobile Number",
                                  icon: Icon(Icons.phone),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mobile number cannot be empty";
                                  } else if (value.length < 10) {
                                    return "Mobile number has to be 10 characters long";
                                  }
                                  return null;
                                },
                              ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 8.0, 14, 8),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange,
                        elevation: 0,
                        child: MaterialButton(
                            onPressed: ()
                            async {
                              if (_formKey.currentState.validate()) {
                                dynamic result  = await  _provider.registerWithEmailAndPass(_email.text, _password.text,_name.text,_mobileController.text);
                                if(result == null){
                                  setState(() {
                                    error = "Could not sign in with those credentials";
                                    loading = false;
                                  });
                                }
                              }
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              'Sign up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "I already have an account",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red,fontSize: 16),
                            ))),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Or sign up with", style: TextStyle(fontSize: 18,color: Colors.grey),),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                                child: MaterialButton(
                                    onPressed: () async{
                                      dynamic result  = await  _provider.loginWithEmailAndPass(_email.text, _password.text);
                                      if(result == null){
                                        setState(() {
                                          error = "Could not sign in with those credentials";
                                          loading = false;
                                        });
                                      }
                                    },
                                    child: Image.asset("images/ggg.png", width: 30,)
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            ),
          ),
        ],
      ),
    );
  }
}
