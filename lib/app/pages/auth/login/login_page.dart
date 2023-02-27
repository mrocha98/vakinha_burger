import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';
import '../../../core/ui/base_state/base_state.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/delivery_appbar.dart';
import '../../../core/ui/widgets/delivery_button.dart';
import '../register/register_page.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/auth/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();

  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state) => state.status.matchAny(
        any: hideLoader,
        login: showLoader,
        loginError: () {
          hideLoader();
          showError(state.errorMessage ?? '');
        },
        error: () {
          hideLoader();
          showError(state.errorMessage ?? '');
        },
        success: () {
          hideLoader();
          Navigator.pop(context, true);
        },
      ),
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: context.textStyles.textTitle,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _emailEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Email obrigatório'),
                          Validatorless.email('Email inválido'),
                        ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        controller: _passwordEC,
                        validator: Validatorless.required('Senha obrigatória'),
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: DeliveryButton(
                          onPressed: () {
                            final valid =
                                _formKey.currentState?.validate() ?? false;
                            if (valid) {
                              controller.login(_emailEC.text, _passwordEC.text);
                            }
                          },
                          label: 'ENTRAR',
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não possui uma conta?',
                        style: context.textStyles.textBold,
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pushNamed(
                          RegisterPage.routeName,
                        ),
                        child: Text(
                          'Cadastre-se',
                          style: context.textStyles.textBold
                              .copyWith(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
