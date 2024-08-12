// Copyright (C) 2024 Rudson Alves
//
// This file is part of bgbazzar.
//
// bgbazzar is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// bgbazzar is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with bgbazzar.  If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';

import '../../common/models/user.dart';
import '../../common/parse_server/errors_mensages.dart';
import '../../components/buttons/big_button.dart';
import '../../components/dialogs/simple_message.dart';
import '../../components/others_widgets/state_error_message.dart';
import '../../components/others_widgets/state_loading_message.dart';
import '../signup/signup_screen.dart';
import 'login_controller.dart';
import 'login_state.dart';
import 'widgets/login_form.dart';
import '../../components/others_widgets/or_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ctrl = LoginController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    ctrl.dispose();

    super.dispose();
  }

  Future<void> _userLogin() async {
    FocusScope.of(context).unfocus();
    final valid =
        _formKey.currentState != null && _formKey.currentState!.validate();

    if (valid) {
      try {
        final user = await ctrl.login(
          UserModel(
            email: ctrl.emailController.text,
            password: ctrl.passwordController.text,
          ),
        );

        if (user == null || user.id == null) {
          throw Exception(
              '-1	error code indicating that an unknown error or an error'
              ' unrelated to Parse occurred.');
        }

        if (mounted) Navigator.pop(context);
        return;
      } catch (err) {
        if (!mounted) return;
        await SimpleMessage.open(
          context,
          title: 'Ocorreu um Error',
          message: ParserServerErrors.message(err.toString()),
          type: MessageType.error,
        );

        return;
      }
    }
  }

  void _navSignUp() {
    Navigator.pop(context);
    Navigator.pushNamed(
      context,
      SignUpScreen.routeName,
    );
  }

  void _navLostPassword() {
    throw Exception('Has not yet been implemented');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor:
          ctrl.app.isDark ? null : colorScheme.onPrimary.withOpacity(0.85),
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: ListenableBuilder(
        listenable: ctrl,
        builder: (context, _) {
          return Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: SingleChildScrollView(
                    child: Card(
                      color: ctrl.app.isDark
                          ? colorScheme.primary.withOpacity(.15)
                          : null,
                      margin: const EdgeInsets.all(20),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BigButton(
                              color: Colors.blue,
                              label: 'Entrar com Facebook',
                              onPressed: () {
                                throw Exception('Has not yet been implemented');
                              },
                            ),
                            const OrRow(),
                            LoginForm(
                              formKey: _formKey,
                              controller: ctrl,
                              userLogin: _userLogin,
                              navSignUp: _navSignUp,
                              navLostPassword: _navLostPassword,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (ctrl.state is LoginStateLoading)
                const Positioned.fill(
                  child: StateLoadingMessage(),
                ),
              if (ctrl.state is LoginStateError)
                Positioned.fill(
                  child: StateErrorMessage(
                    closeDialog: ctrl.closeErroMessage,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
