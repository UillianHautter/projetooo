import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_tcc/screens/telabase/category/category_screen.dart';
import 'package:projeto_tcc/screens/telabase/filter/filter_screen.dart';
import 'package:projeto_tcc/stores/home_store.dart';

import 'bar_button.dart';

class TopBar extends StatelessWidget {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Observer(builder: (_) {
          return BarButton(
            label: homeStore.category?.description ?? 'Categorias ',
            onTap: () async {
              final category =
                  await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CategoryScreen(
                  showAll: true,
                  selected: homeStore.category,
                ),
              ));
              if (category != null) homeStore.setCategory(category);
            },
          );
        }),
        BarButton(
          label: 'Filtrar',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => FilterScreen()));
          },
        ),
      ],
    );
  }
}
