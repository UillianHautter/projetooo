import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_tcc/componemtes/custon_drawer/error_box.dart';
import 'package:projeto_tcc/screens/telabase/singup/componentes/field_title.dart';
import 'package:projeto_tcc/stores/signup_store.dart';

class SignUpScreen extends StatelessWidget {
  final SignupStore signupStore = SignupStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 35),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 25,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Observer(builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ErrorBox(message: signupStore.error),
                      );
                    }),
                    FieldTitle(
                      title: 'Nome',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.nameError),
                        onChanged: signupStore.setName,
                      );
                    }),
                    const SizedBox(
                      height: 15,
                    ),
                    FieldTitle(
                      title: 'E-mail',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.emailError),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: signupStore.setEmail,
                      );
                    }),
                    const SizedBox(
                      height: 15,
                    ),
                    FieldTitle(
                      title: 'Celular',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.phoneError),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                        onChanged: signupStore.setPhone,
                      );
                    }),
                    const SizedBox(
                      height: 15,
                    ),
                    FieldTitle(
                      title: 'Senha',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.pass1Error),
                        obscureText: true,
                        onChanged: signupStore.setPass1,
                      );
                    }),
                    Observer(builder: (_) {
                      return Container(
                        height: 45,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: RaisedButton(
                          color: Colors.teal,
                          disabledColor: Colors.teal.withAlpha(120),
                          child: signupStore.loading
                              ? CircularProgressIndicator()
                              : Text('Cadastrar'),
                          textColor: Colors.white,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          onPressed: signupStore.signUpPressed,
                        ),
                      );
                    }),
                    Divider(
                      color: Colors.black,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Já tenho uma conta ',
                              style: TextStyle(fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: Navigator.of(context).pop,
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.teal,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ))
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
