import 'package:flutter/material.dart';
import 'auth.dart';

class TODOLogin extends StatefulWidget {

  final onLogin;

  TODOLogin({@required this.onLogin});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<TODOLogin> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final auth = Authentication();

  void doLogin() async {
    final user = await auth.login(emailController.text, passwordController.text);
    if (user != null) {
      // Calling callback in TODOState
      widget.onLogin(user);
      Navigator.pushReplacementNamed(context, '/list');
    } else {
      _showAuthFailedDialog();
    }
  }

  void _showAuthFailedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text('Could not log in'),
          content: new Text('Double check your credentials and try again'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Please log in')
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email'
                      ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password'
                      ),
                    )
                ),
                RaisedButton(
                  // Calling the doLogin function on press
                  onPressed: doLogin,
                  child: Text('LOGIN'),
                  color: ThemeData().primaryColor,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
            )
        )
    );
  }
}