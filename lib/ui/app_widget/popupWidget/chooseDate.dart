import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/theme/app_colors.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:game_app_training/ui/theme/styles.dart';
import 'package:lo_form/lo_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/auth_widget/bloc/login_bloc.dart';

var textController = MaskedTextController(mask: '0000-00-00');


class Form extends StatefulWidget {
  Form({Key? key, required this.bloc}) : super(key: key);
  AppBloc bloc;

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
        String date = textController.text;
        widget.bloc.add(HaveNewOrderEvent(date));
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
            name: 'гггг-мм-дд',
            validate: LoValidation().build(),
            props: TextFieldProps(
              keyboardType: TextInputType.datetime,
              decoration: decorator,
              controller: textController,
            )),
        const SizedBox(height: 16),
        Container(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            style: styleBtn,
            onPressed: form.submit,
            child: const Text('Создать'),
          ),
        )
      ],
    );
  }
}


smartChooseDataDialog(context, AppState state) {
  SmartDialog.show(
      useAnimation: true,
      clickMaskDismiss: false,
      builder: (_) {
        final appBloc = BlocProvider.of<AppBloc>(context);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: 246, //FIXME
                width: 500,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Введите дату',style: h20_600()),
                          const Expanded(
                              child: SizedBox(
                            width: 20,
                          )),
                          IconButton(
                              onPressed: () {
                         
                                SmartDialog.dismiss();
                              },
                              icon: const Icon(Icons.close_rounded)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Form(bloc: appBloc,)
                    ],
                  ),
                )),
          ],
        );
      });

}