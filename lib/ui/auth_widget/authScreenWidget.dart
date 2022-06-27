// ignore_for_file: prefer_const_declarations

import 'package:game_app_training/ui/theme/app_colors.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/auth_widget/bloc/login_bloc.dart';

var phoneController = MaskedTextController(mask: '+7 (000) 000-00-00');
var passwordController = TextEditingController();

class AuthScreenWidget extends StatefulWidget {
  const AuthScreenWidget({Key? key}) : super(key: key);

  @override
  State<AuthScreenWidget> createState() => _AuthScreenWidget();
}

class _AuthScreenWidget extends State<AuthScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Войти в аккаунт',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          )),
          shadowColor: AppColors.mainOrange,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Head(),
                SizedBox(
                  height: 52,
                ),
                Form(),
              ],
            ),
          ),
        ));
  }
}

class _Head extends StatelessWidget {
  const _Head({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 80,
        ),
        Image.asset('assets/images/logo.png'),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Авторизация',
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
        )
      ],
    ));
  }
}

class Form extends StatefulWidget {
  const Form({Key? key}) : super(key: key);

  @override
  State<Form> createState() => FormState();
}

class FormState extends State<Form> {
  @override
  Widget build(BuildContext context) {
    return LoForm(
      submittableWhen: (status) => status.isValid,
      builder: (form) {
        return (FormWidget(
          context: context,
          form: form,
        ));
      },
      onSubmit: (values, setErrors) {
        String password = passwordController.text;
        String phoneNumber = phoneController.text;
        context
            .read<LoginBloc>()
            .add(AuthorizeEvent(password, phoneNumber, passwordController));
        // passwordController.clear();
      },
    );
  }
}

class FormWidget extends StatelessWidget {
  final BuildContext context;
  final LoFormState form;

  const FormWidget({Key? key, required this.context, required this.form})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styleBtn = ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.mainOrange),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        )));
    final decorator = const InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(108, 163, 161, 161), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(11.0))),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 17),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(108, 163, 161, 161), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(11.0))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(108, 163, 161, 161), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(11.0))),
    );
    return Column(
      children: [
        const SizedBox(height: 16),
        LoTextField(
            name: 'Номер',
            validate: LoValidation().build(),
            props: TextFieldProps(
              keyboardType: TextInputType.phone,
              decoration: decorator,
              controller: phoneController,
            )),
        const SizedBox(height: 16),
        LoTextField(
          name: 'Пароль',
          validate: LoValidation().required('Обязательное поле').build(),
          props: TextFieldProps(
            obscureText: true,
            decoration: decorator,
            controller: passwordController,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            style: styleBtn,
            onPressed: form.submit,
            child: const Text('Войти'),
          ),
        )
      ],
    );
  }
}
