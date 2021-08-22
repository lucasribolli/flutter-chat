import 'package:chat/models/auth_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

TextStyle textStyle = TextStyle(
  fontSize: 13.sp,
);

enum WrongField {
  NAME,
  EMAIL,
  PASSWORD,
}

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthData _authData = AuthData();
  double cardHeight = 45.h;

  late int wrongNameFieldCount;
  late int wrongEmailFieldCount;
  late int wrongPasswordFieldCount;

  late double _cardHeight;

  _increaseCardHeight(height, wrongField) {
    switch (wrongField) {
      case WrongField.NAME:
        if(wrongNameFieldCount > 1) {
          print('wrongNameFieldCount > 1');
          return;
        }
        break;
      case WrongField.EMAIL:
        if(wrongEmailFieldCount > 1) {
          print('wrongEmailFieldCount > 1');
          return;
        }
        break;
      case WrongField.NAME:
        if(wrongPasswordFieldCount > 1) {
          print('wrongPasswordFieldCount > 1');
          return;
        }
        break;
      default:
        break;
    }
    setState(() {
      _cardHeight += height;
    });
  }

  _submitForm() {
    bool isValid = _formKey.currentState!.validate();

    if(isValid) {
      print(_authData);
    }
  }

  @override
  void initState() {
    wrongNameFieldCount = 0;
    wrongEmailFieldCount = 0;
    wrongPasswordFieldCount = 0;
    _cardHeight = _authData.isLogin ? 37.h : 45.h;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSize(
        vsync: this,
        curve: Curves.linear,
        duration: Duration(milliseconds: 200),
        child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
        ),
        height: _cardHeight,
        width: 85.w,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if(_authData.isSignup)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                    style: textStyle,
                    onChanged: (value) => _authData.name = value,
                    validator: (value) {
                      if(value == null) {
                        setState(() {
                          wrongNameFieldCount++;
                        });
                        _increaseCardHeight(5.h, WrongField.NAME);
                        return 'Nome não preenchido';
                      }
                      else if(value.trim().length < 4) {
                        setState(() {
                          wrongNameFieldCount++;
                        });
                        _increaseCardHeight(5.h, WrongField.NAME);
                        return 'Nome deve ter no mínimo 4 caracteres';
                      }
                      return null;
                    },
                  ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                  ),
                  style: textStyle,
                  onChanged: (value) => _authData.email = value,
                  validator: (value) {
                    if(value == null) {
                      setState(() {
                        wrongEmailFieldCount++;
                      });
                      _increaseCardHeight(5.h, WrongField.EMAIL);
                      return 'E-mail não preenchido';
                    }
                    else if(!value.trim().contains('@')) {
                      setState(() {
                        wrongEmailFieldCount++;
                      });
                      _increaseCardHeight(5.h, WrongField.EMAIL);
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                  ),
                  style: textStyle,
                  obscureText: true,
                  onChanged: (value) => _authData.password = value,
                  validator: (value) {
                    if(value == null) {
                      setState(() {
                        wrongPasswordFieldCount++;
                      });
                      _increaseCardHeight(5.h, WrongField.PASSWORD);
                      return 'Senha não preenchida';
                    }
                    else if(value.trim().length < 7) {
                      setState(() {
                        wrongPasswordFieldCount++;
                      });
                      _increaseCardHeight(5.h, WrongField.PASSWORD);
                      return 'Senha deve conter no mínimo 7 caracteres';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 3.h),
                ElevatedButton(
                  onPressed: _submitForm, 
                  child: Text(
                    _authData.isLogin 
                    ? 'Entrar'
                    : 'Cadastrar',
                  ),
                  style: ElevatedButton.styleFrom(
                    textStyle: textStyle,
                  ),
                ),
                TextButton(
                  child: Text('Criar uma nova conta?'),
                  style: TextButton.styleFrom(
                    textStyle: textStyle.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _authData.toggleMode();
                      cardHeight = 30.h;
                    });
                  }, 
                )
              ],
            ),
          ),
        )
        )
      ),
    );
  }
}