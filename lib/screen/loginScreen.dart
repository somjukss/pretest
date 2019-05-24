import 'package:flutter/material.dart';
import 'package:pretest/screen/homeScreen.dart';
import 'package:pretest/screen/registerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/share.dart';
import '../model/userDB.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreen();
  }
}

class LoginScreen extends State<Login> {
  UserProvider userdb = UserProvider();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userid = TextEditingController();
  final TextEditingController password = TextEditingController();

  void initState() {
    super.initState();
    this.userdb.open();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: <Widget>[
                Image.asset(
                  "image/piclog.png",
                  height: 180,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "User ID",
                    icon: Icon(Icons.account_circle,
                    size: 30,),
                  ),
                  controller: userid,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "user empty";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Password", icon: Icon(Icons.lock,
                      size: 30,)
                  ),
                  obscureText: true,
                  controller: password,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "password empty";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text("LOGIN"),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await userdb.open();
                      userdb.getAccountByUserId(userid.text).then((account) {
                        if (account == null ||
                            password.text != account.password) {
                          print("LOGIN FAIL");
                        } else {
                          print("LOFIN PASS");
                          SharedPreferencesUtil.saveLastLogin(userid.text);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(account)),
                          );
                        }
                      });
                    }
                  },
                ),
                Container(
                  child: FlatButton(
                    child: Text("Register"),
                    onPressed: () {
                      Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()),
                          );
                    },
                  ),
                  alignment: Alignment.topRight,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
