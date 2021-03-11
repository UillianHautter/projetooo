import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_tcc/screens/telabase/category/category_screen.dart';
import 'package:projeto_tcc/stores/create_store.dart';

class CategoryField extends StatelessWidget {
  CategoryField(this.createStore);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ListTile(
        title: createStore.category == null
            ? Text(
                'Categorias *',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.teal,
                  fontSize: 15,
                ),
              )
            : Text(
                'Categorias *',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.teal,
                  fontSize: 14,
                ),
              ),
        subtitle: createStore.category == null
            ? null
            : Text(
                '${createStore.category.description}',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
        trailing: Icon(Icons.keyboard_arrow_down),
        onTap: () async {
          final category = await showDialog(
            context: context,
            builder: (_) => CategoryScreen(
              showAll: false,
              selected: createStore.category,
            ),
          );
          if (category != null) {
            createStore.setCategory(category);
          }
        },
      );
    });
  }
}
