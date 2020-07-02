import 'dart:io';

import 'package:abiolachat/widget/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

/* created by Abiola Gbode
repo -> https://github.com/abiolagbode
whatsapp: +2348176391092
email: infogbodeabiola@gmail.com
 */

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String email,
    String username,
    String password,
    File image,
    bool isLogin,
    BuildContext ctx 
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  var _userImageFile ;

  void _pickedImage(File image){
    _userImageFile = image;

  }

  void _trySubmit() {
    final isvalid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(_userImageFile == null && !_isLogin){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please pick an Image."),backgroundColor: Theme.of(context).errorColor,),);
      return;
    }

    if (isvalid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
      //use those values to send to our auth request
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if(!_isLogin)UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey("email"),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value.isEmpty || !value.contains("@")) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email Address"),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("username"),
                      autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                      validator: (value) {
                        if (value.isEmpty || value.length <= 4) {
                          return "Username must atleast be 4 characters long";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Username"),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey("password"),
                    validator: (value) {
                      if (value.isEmpty || value.length <= 7) {
                        return "Password must atleast be 7 characters long";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if(widget.isLoading) CircularProgressIndicator(),
                  if(!widget.isLoading)
                  RaisedButton(
                      child: Text(_isLogin ? "Login" : "Sign UP"),
                      onPressed: _trySubmit),
                  if(!widget.isLoading)
                  FlatButton(
                    child: Text(_isLogin
                        ? "Create a new account"
                        : "I already have an account"),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
