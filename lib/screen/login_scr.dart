import 'package:bitsdojo_window/bitsdojo_window.dart' as win;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/provider/auth_provider/singup_provider.dart';

import '../constant/kconst.dart';
import '../widget/error_dialog.dart';
import '../widget/windows_headter.dart';

class LoginScr extends ConsumerWidget {
  const LoginScr({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: win.WindowBorder(
        width: Kconst.borderWith,
        color: Kconst.borderColor,
        child: Column(
          children: [
            const WindowsHeadter(),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Kconst.isMini(context) ? 60 : 120,
                    vertical: Kconst.isMini(context) ? 60 : 40),
                decoration:
                    BoxDecoration(gradient: Kconst.linearBackroundDark2),
                child: const Row(
                  children: [
                    LoginTextFiled(),
                    LoginImage(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginTextFiled extends ConsumerStatefulWidget {
  const LoginTextFiled({
    super.key,
  });

  @override
  ConsumerState<LoginTextFiled> createState() => _LoginTextFiledState();
}

class _LoginTextFiledState extends ConsumerState<LoginTextFiled> {
  final _formKey = GlobalKey<FormState>();
  bool _isLongin = true;

  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  var username = '';
  var email = '';
  var password = '';

  void submite() {
    final isvalidate = _formKey.currentState!.validate();
    if (!isvalidate) {
      return;
    }
    _formKey.currentState!.save();

    if (_isLongin) {
      ref.read(singUpProvider.notifier).singIn(email, password);
    } else {
      ref.read(singUpProvider.notifier).singUp(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(singUpProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          errorDialog(context, error);
        },
      );
    });
    final singUpSate = ref.watch(singUpProvider);

    return Expanded(
      flex: 11,
      child: Container(
        color: Kconst.text4,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Kconst.isMini(context) ? 50 : 90, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isLongin ? 'Login' : 'SignUp',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                        ),
                  ),
                  Text(
                    'Welcome!',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (!_isLongin)
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Kconst.text3,
                          prefixIcon: Icon(
                            Icons.people_sharp,
                            color: Kconst.green2,
                          ),
                          label: Text(
                            ' Name',
                            style: TextStyle(
                              color: Kconst.green2,
                            ),
                          ),
                          hintText: 'John',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length <= 4) {
                            return 'Please enter a valid username ';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          username = newValue!;
                        },
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Kconst.text3,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Kconst.green2,
                        ),
                        label: Text(
                          'Email',
                          style: TextStyle(
                            color: Kconst.green2,
                          ),
                        ),
                        hintText: 'username@gmai.com',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@') ||
                            !value.contains('.')) {
                          return 'enter a valid Email Id';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        email = newValue!;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Kconst.text3,
                        prefixIcon: Icon(
                          Icons.password_outlined,
                          color: Kconst.green2,
                        ),
                        label: Text(
                          'Password',
                          style: TextStyle(
                            color: Kconst.green2,
                          ),
                        ),
                        hintText: '*********',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty || value.trim().length <= 6) {
                          return 'Please enter password';
                        } else {
                          // if (!regex.hasMatch(value)) {
                          //   return 'Enter valid password';
                          // }
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        password = newValue!;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: singUpSate.maybeWhen(
                            loading: () => null,
                            orElse: () {
                              return () => setState(() {
                                    _isLongin = !_isLongin;
                                    _formKey.currentState!.reset();
                                  });
                            },
                          ),
                          child: Text(
                            _isLongin
                                ? "Create a account ?"
                                : 'already have an account ?',
                            style: Kconst.kTextTheme(context)
                                .titleMedium!
                                .copyWith(color: Kconst.green),
                          ),
                        ),
                        if (_isLongin)
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot password',
                              style: Kconst.kTextTheme(context).titleMedium,
                            ),
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        disabledBackgroundColor: Kconst.yellow2,
                        backgroundColor: Kconst.yellow2,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        elevation: 20,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: singUpSate.maybeWhen(
                          loading: () => null, orElse: () => submite),
                      child: singUpSate.maybeWhen(
                        loading: () {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    color: Kconst.text4,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Submitted',
                                style: Kconst.kTextTheme(context)
                                    .titleLarge!
                                    .copyWith(
                                        color: Kconst.text4,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        },
                        orElse: () {
                          return Text(
                            _isLongin ? "Login" : 'SignUp',
                            style: Kconst.kTextTheme(context)
                                .titleLarge!
                                .copyWith(
                                    color: Kconst.text4,
                                    fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginImage extends StatelessWidget {
  const LoginImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: Image.asset(
            'assets/image/login.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
