import 'package:flutter/material.dart';
import 'package:flutter_login_screen_with_input_validations/blocs/login_bloc.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<LoginBloc>(
                  builder: (BuildContext context, bloc, child) => TextFormField(
                    onChanged: (value) => bloc.setUserID(value),
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                    decoration: const InputDecoration(labelText: 'User ID'),
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<LoginBloc>(
                  builder: (BuildContext context, bloc, child) => TextFormField(
                    onChanged: (value) => bloc.setPhoneNumber(value),
                    keyboardType: TextInputType.phone,
                    decoration:
                        const InputDecoration(labelText: 'Phone Number'),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<LoginBloc>(
                      builder: (BuildContext context, bloc, child) =>
                          TextFormField(
                        onChanged: (value) => bloc.setEmail(value),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                    ),
                    Consumer<LoginBloc>(
                      builder: (BuildContext context, bloc, child) =>
                          (bloc.userEmail.isNotEmpty)
                              ? Text(
                                  bloc.emailValidationMessage(bloc.userEmail),
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                )
                              : Container(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<LoginBloc>(
                      builder: (BuildContext context, bloc, child) =>
                          TextFormField(
                        onChanged: (value) => bloc.setPassword(value),
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Consumer<LoginBloc>(
                      builder: (BuildContext context, bloc, child) =>
                          (bloc.userPassword.isNotEmpty)
                              ? Text(
                                  bloc.passwordValidationMessage,
                                  style: TextStyle(
                                      color: (bloc.userPassword == "123456" ||
                                              bloc.userPassword.length < 6)
                                          ? Colors.red
                                          : Colors.green),
                                )
                              : Container(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Consumer<LoginBloc>(
                  builder: (BuildContext context, bloc, child) =>
                      ElevatedButton(
                    onPressed: bloc.isLoginButtonEnabled
                        ? () {
                            bloc.login(context);
                          }
                        : null,
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
