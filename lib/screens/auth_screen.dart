import 'package:auth_sample/notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart' as Constants;
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _passwordRepFocusNode;

  bool _isLoading = false;

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _passwordRepTextController = TextEditingController();

  AuthScreenMode _authScreenMode;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordRepFocusNode = FocusNode();
    _authScreenMode = AuthScreenMode.SignIn;
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _companyName = Hero(
      tag: 'appa-h',
      child: Text(
        'APPA',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold, color: Constants.appaColor2),
      ),
    );

    final _title = Text(
      _authScreenMode == AuthScreenMode.SignIn ? 'signin' : 'signup',
      style: TextStyle(
        fontSize: 28,
        color: Constants.appaColor3,
      ),
    );

    final _textFieldStyle = TextStyle(fontSize: 16);

    final _emailField = TextFormField(
      controller: _emailTextController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email address',
        hintText: 'please enter your email address',
        labelStyle: TextStyle(
          fontSize: 18,
        ),
        suffixIcon: Icon(
          Icons.email_outlined,
        ),
      ),
      style: _textFieldStyle,
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      // onSaved: (value) => _userName = value,
      validator: (value) {
        if (value.isEmpty) return 'please enter your email address';
        if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}").hasMatch(value)) return 'please enter valid email address';
        return null;
      },
      onTap: () {
        setState(() {});
      },
      onEditingComplete: () {
        setState(() {
          _passwordFocusNode.requestFocus();
        });
      },
    );

    final _passwordField = TextFormField(
      controller: _passwordTextController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
        hintText: 'please enter your password',
        labelStyle: TextStyle(
          fontSize: 18,
        ),
        suffixIcon: Icon(
          Icons.lock_outline,
        ),
      ),
      style: _textFieldStyle,
      focusNode: _passwordFocusNode,
      textInputAction: _authScreenMode == AuthScreenMode.SignIn ? TextInputAction.done : TextInputAction.next,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      // onSaved: (value) => _password = value,
      validator: (value) {
        if (value.isEmpty) return 'Enter password please';
        if (value.length < 8) return 'Password must have more than 8 characters';
        // _password = value;
        return null;
      },
      onTap: () {
        setState(() {});
      },
      onEditingComplete: () {
        if (_authScreenMode == AuthScreenMode.SignUp) {
          setState(() {
            _passwordRepFocusNode.requestFocus();
          });
        } else {
          _passwordFocusNode.unfocus();
        }
      },
    );

    final _passwordRepField = AnimatedOpacity(
      opacity: _authScreenMode == AuthScreenMode.SignUp ? 1 : 0,
      duration: Duration(milliseconds: 500),
      child: AnimatedContainer(
        height: _authScreenMode == AuthScreenMode.SignUp ? 80 : 0,
        child: TextFormField(
          controller: _passwordRepTextController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password confirm',
            hintText: 'enter password confirmation',
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Constants.appaColor1)),
            labelStyle: TextStyle(
              fontSize: 18,
              color: _passwordRepFocusNode.hasFocus ? Constants.appaColor2 : Colors.grey,
            ),
            suffixIcon: AnimatedOpacity(
              opacity: _authScreenMode == AuthScreenMode.SignUp ? 1 : 0,
              child: Icon(
                Icons.lock_outline,
                color: _passwordRepFocusNode.hasFocus ? Constants.appaColor2 : Colors.grey,
              ),
              duration: Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
            ),
          ),
          style: _textFieldStyle,
          focusNode: _passwordRepFocusNode,
          textInputAction: TextInputAction.done,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          // onSaved: (value) => _password = value,
          validator: (value) {
            if (_authScreenMode == AuthScreenMode.SignIn) return null;
            if (value.isEmpty) return 'enter password confirmation';
            if (_passwordTextController.text != _passwordRepTextController.text) return 'check password confirmation';
            return null;
          },
          onTap: () {
            setState(() {});
          },
        ),
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      ),
    );

    final _signForm = Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 64),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _emailField,
                const SizedBox(height: 16),
                _passwordField,
                const SizedBox(height: 16),
                _passwordRepField,
                const SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );

    final _signButton = FlatButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        _saveForm();
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36), side: BorderSide(color: Constants.appaColor3)),
      color: Constants.appaColor3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: Text(
          _authScreenMode == AuthScreenMode.SignIn ? 'Sign in' : 'Sign up',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    final _changeAuthModeButton = Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 32, left: 32, right: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _authScreenMode == AuthScreenMode.SignIn ? "Don't have an account yet? " : 'Already have account? ',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          InkWell(
            onTap: () {
              _formKey.currentState.reset();
              if (_authScreenMode == AuthScreenMode.SignIn) {
                setState(() {
                  _authScreenMode = AuthScreenMode.SignUp;
                });
              } else {
                setState(() {
                  _authScreenMode = AuthScreenMode.SignIn;
                });
              }
            },
            child: Text(
              _authScreenMode == AuthScreenMode.SignIn ? 'Register now' : 'Sign in now',
              style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 64),
            _companyName,
            _title,
            _signForm,
            _isLoading ? CircularProgressIndicator() : _signButton,
            const SizedBox(height: 32),
            Column(
              children: [
                const Divider(indent: 64, endIndent: 64, color: Colors.black87, thickness: 1),
                _changeAuthModeButton,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveForm() async {
    final form = _formKey.currentState;

    if (!form.validate()) {
      return;
    }
    if (_authScreenMode == AuthScreenMode.SignIn) {
      try {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<AuthNotifier>(context, listen: false)
            .login(_emailTextController.text, _passwordTextController.text);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (error) {
        _showToast('Log in field, tray again');
        print(error);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

    // else
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

enum AuthScreenMode {
  SignIn,
  SignUp,
}
