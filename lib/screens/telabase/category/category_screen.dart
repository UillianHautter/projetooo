import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_tcc/componemtes/custon_drawer/error_box.dart';
import 'package:projeto_tcc/models/categoty.dart';
import 'package:projeto_tcc/stores/category_store.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({this.showAll = true, this.selected});

  final Category selected;
  final bool showAll;

  final CategoryStore categoryStore = GetIt.I<CategoryStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: Center(
        child: Card(
            margin: const EdgeInsets.fromLTRB(32, 12, 32, 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 10,
            child: Observer(
              builder: (_) {
                if (categoryStore.error != null) {
                  return ErrorBox(
                    message: categoryStore.error,
                  );
                } else if (categoryStore.categoryList.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final categorias = showAll
                      ? categoryStore.allCategoryList
                      : categoryStore.allCategoryList;
                  return ListView.separated(
                    itemCount: categorias.length,
                    separatorBuilder: (_, __) {
                      return Divider(height: 0.1, color: Colors.grey);
                    },
                    itemBuilder: (_, index) {
                      final category = categorias[index];

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop(category);
                        },
                        child: Container(
                          height: 50,
                          color: category.id == selected?.id
                              ? Colors.teal.withAlpha(50)
                              : null,
                          alignment: Alignment.center,
                          child: Text(
                            category.description,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: category.id == selected?.id
                                    ? FontWeight.bold
                                    : null),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            )),
      ),
    );
  }
}
