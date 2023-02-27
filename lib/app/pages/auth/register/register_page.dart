import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/base_state/base_state.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/delivery_appbar.dart';
import '../../../core/ui/widgets/delivery_button.dart';
import 'register_controller.dart';
import 'register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const routeName = '/auth/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) => state.status.matchAny(
        any: hideLoader,
        register: showLoader,
        error: () {
          hideLoader();
          showError('Erro ao registar usuário');
        },
        success: () {
          hideLoader();
          showSuccess('Cadastro realizado com sucesso');
          Navigator.pop(context);
        },
      ),
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  children: [
                    Text(
                      'Cadastro',
                      style: context.textStyles.textTitle,
                    ),
                    Text(
                      'Preencha os campos abaixo para criar o seu cadastro.',
                      style:
                          context.textStyles.textMedium.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                      controller: _nameEC,
                      validator: Validatorless.required('Nome obrigatório'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      controller: _emailEC,
                      validator: Validatorless.multiple([
                        Validatorless.required('Email obrigatório'),
                        Validatorless.email('Email inválido'),
                      ]),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                      ),
                      controller: _passwordEC,
                      validator: Validatorless.multiple([
                        Validatorless.required('Senha obrigatória'),
                        Validatorless.min(
                          6,
                          'Senha deve ter pelo menos 6 caracteres',
                        ),
                      ]),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Confirmar Senha',
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('Confirmar senha obrigatório'),
                        Validatorless.compare(
                          _passwordEC,
                          'Confirmação diferente da senha',
                        ),
                      ]),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: DeliveryButton(
                        onPressed: () {
                          final valid =
                              _formKey.currentState?.validate() ?? false;
                          if (valid) {
                            controller.register(
                              _nameEC.text,
                              _emailEC.text,
                              _passwordEC.text,
                            );
                          }
                        },
                        label: 'Cadastrar',
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
