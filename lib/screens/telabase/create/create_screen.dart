import 'package:brasil_fields/formatter/real_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_tcc/componemtes/custon_drawer/custon_drawer.dart';
import 'package:projeto_tcc/componemtes/custon_drawer/error_box.dart';
import 'package:projeto_tcc/stores/create_store.dart';
import 'package:projeto_tcc/stores/page_store.dart';

import 'componentes/category_field.dart';
import 'componentes/hide_phone_field.dart';
import 'componentes/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final CreateStore createStore = CreateStore();

  @override
  void initState() {
    super.initState();

    when((_) => createStore.savedAd, () {
      GetIt.I<PageStore>().setPage(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.teal,
      fontSize: 16,
    );
    final contentPadding = const EdgeInsets.fromLTRB(15, 10, 12, 10);
    return Scaffold(
      drawer: CustonDrawer(),
      appBar: AppBar(
        title: Text('Anunciar  Imóvel'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 35),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            elevation: 25,
            child: Observer(
              builder: (_) {
                if (createStore.loading)
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Salvando o Anúncio',
                          style: TextStyle(fontSize: 16, color: Colors.teal),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.teal[800]),
                        ),
                      ],
                    ),
                  );
                else
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImagesField(createStore),
                      Observer(builder: (_) {
                        return TextFormField(
                          onChanged: createStore.setTitle,
                          decoration: InputDecoration(
                            labelText: 'Titulo *',
                            labelStyle: labelStyle,
                            contentPadding: contentPadding,
                            errorText: createStore.titleError,
                          ),
                        );
                      }),
                      Observer(builder: (_) {
                        return TextFormField(
                          onChanged: createStore.setDescription,
                          decoration: InputDecoration(
                            labelText: 'Descrição *',
                            labelStyle: labelStyle,
                            contentPadding: contentPadding,
                            errorText: createStore.descriptionError,
                          ),
                          maxLines: null,
                        );
                      }),
                      CategoryField(createStore),
                      Observer(builder: (_) {
                        return TextFormField(
                          onChanged: createStore.setPrice,
                          decoration: InputDecoration(
                            labelText: 'Preço *',
                            labelStyle: labelStyle,
                            contentPadding: contentPadding,
                            prefixText: 'R\$ ',
                            errorText: createStore.priceError,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            RealInputFormatter(centavos: true),
                          ],
                        );
                      }),
                      HidePhoneField(createStore),
                      Observer(builder: (_) {
                        return ErrorBox(
                          message: createStore.error,
                        );
                      }),
                      Observer(builder: (_) {
                        return SizedBox(
                          height: 50,
                          child: GestureDetector(
                            onTap: createStore.invalidSendPressed,
                            child: RaisedButton(
                              child: Text(
                                'Enviar->',
                                style: TextStyle(fontSize: 18),
                              ),
                              color: Colors.teal,
                              disabledColor: Colors.teal.withAlpha(120),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onPressed: createStore.sendPressed,
                            ),
                          ),
                        );
                      }),
                    ],
                  );
              },
            ),
          ),
        ),
      ),
    );
  }
}
