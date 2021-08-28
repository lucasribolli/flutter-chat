import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

TextStyle textStyle = TextStyle(
  fontSize: 13.sp,
);

class AuthForm extends StatefulWidget {
  final void Function(AuthData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthData _authData = AuthData();

  late double _cardHeight;

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  _submitForm() {
    bool isValid = _formKey.currentState!.validate();
    _hideKeyboard();

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  double _cardHeightFromMode() {
    return _authData.isLogin ? 45.h : 70.h;
  }

  @override
  void initState() {
    _cardHeight = _cardHeightFromMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSize(
        vsync: this,
        curve: Curves.easeIn,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_authData.isSignup) UserImagePicker(),
                  if (_authData.isSignup)
                    TextFormField(
                      key: ValueKey('name'),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      style: textStyle,
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if (value == null) {
                          return 'Nome não preenchido';
                        } else if (value.trim().length < 4) {
                          return 'Nome deve ter no mínimo 4 caracteres';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    style: textStyle,
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null) {
                        return 'E-mail não preenchido';
                      } else if (!value.trim().contains('@')) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                    style: textStyle,
                    obscureText: true,
                    onChanged: (value) => _authData.password = value,
                    validator: (value) {
                      if (value == null) {
                        return 'Senha não preenchida';
                      } else if (value.trim().length < 7) {
                        return 'Senha deve conter no mínimo 7 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 3.h),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      _authData.isLogin ? 'Entrar' : 'Cadastrar',
                    ),
                    style: ElevatedButton.styleFrom(
                      textStyle: textStyle,
                    ),
                  ),
                  TextButton(
                    child: Text(_authData.isLogin ? 'Criar uma nova conta?' : 'Já possui uma conta?'),
                    style: TextButton.styleFrom(
                      textStyle: textStyle.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                        _cardHeight = _cardHeightFromMode();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
