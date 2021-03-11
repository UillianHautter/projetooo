import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_tcc/componemtes/custon_drawer/error_box.dart';
import 'package:projeto_tcc/screens/telabase/singup/singup_screen.dart';
import 'package:projeto_tcc/stores/login_store.dart';

class LoginScreen extends StatelessWidget {
  final LoginStore loginStore = LoginStore();

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
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 35),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            elevation: 25,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Entrar com o seu E-mail',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.teal),
                  ),
                  Observer(builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ErrorBox(
                        message: loginStore.error,
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 5, top: 8),
                    child: Text(
                      'E-mail',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !loginStore.loading,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: loginStore.emailError),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: loginStore.setetEmail,
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 5, top: 8),
                    child: Row(
                      children: [
                        Text(
                          'Senha',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !loginStore.loading,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: loginStore.passwordError),
                      obscureText: true,
                      onChanged: loginStore.setPassword,
                    );
                  }),
                  Observer(builder: (_) {
                    return Container(
                      height: 45,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: RaisedButton(
                        color: Colors.teal,
                        disabledColor: Colors.teal.withAlpha(120),
                        child: loginStore.loading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                              )
                            : Text('Entrar->'),
                        textColor: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        onPressed: loginStore.loginPressed,
                      ),
                    );
                  }),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Não tem uma conta? ',
                          style: TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SignUpScreen()));
                          },
                          child: Text(
                            'Cadastre-se',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.teal,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
