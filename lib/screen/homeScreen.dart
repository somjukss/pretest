import 'package:flutter/material.dart';
import '../model/userDB.dart';
import '../model/share.dart';
// import './profileScreen.dart';

class Home extends StatefulWidget{
  final Account _account;
  Home(this._account);

  @override
  State<StatefulWidget> createState() {
    return HomeScreen();
  }
}

class HomeScreen extends State<Home>{
  String quote;

  void initState() {
    super.initState();
    SharedPreferencesUtil.loadQuote().then((value){
      setState(() {
        this.quote = value;
      });
    });
    print("test");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        children: <Widget>[
          ListTile(
            title: Text("Hello ${widget._account.name}  ${widget._account.id}"),
            subtitle: Text("This is my quote ${this.quote} "),
          ),
          RaisedButton(
            child: Text("PROFILE SETUP"),
            onPressed: (){
              print('profile pass');
              // Navigator.pushReplacement(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => ProfileUi()),
              //             );
            },
          ),
          RaisedButton(
            child: Text("LOGOUT"),
            onPressed: (){
              SharedPreferencesUtil.saveLastLogin(null);
              SharedPreferencesUtil.saveQuote(null);
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
        ],
      ),
    );
  }

}