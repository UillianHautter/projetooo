import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_tcc/componemtes/custon_drawer/custon_drawer.dart';
import 'package:projeto_tcc/stores/home_store.dart';

import 'components/ad_title.dart';
import 'components/search_dialog.dart';
import 'components/top_bar.dart';

class HomeScreen extends StatelessWidget {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  openSearch(BuildContext context) async {
    final search = await showDialog(
      context: context,
      builder: (_) => SearchDialog(
        currentSearch: homeStore.search,
      ),
    );
    if (search != null) homeStore.setSearch(search);

    print(search);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustonDrawer(),
        appBar: AppBar(
          title: Observer(
            builder: (_) {
              if (homeStore.search.isEmpty) return Container();
              return GestureDetector(
                  onTap: () => openSearch(context),
                  child: LayoutBuilder(
                    builder: (_, constraints) {
                      return Container(
                        width: constraints.biggest.width,
                        child: Text(homeStore.search),
                      );
                    },
                  ));
            },
          ),
          actions: [
            Observer(builder: (_) {
              if (homeStore.search.isEmpty)
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    openSearch(context);
                  },
                );
              return IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  homeStore.setSearch('');
                },
              );
            })
          ],
        ),
        body: Column(
          children: [
            TopBar(),
            Expanded(
              child: Observer(
                builder: (_) {
                  if (homeStore.error != null)
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 100,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Ocorreu um erro',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    );
                  if (homeStore.showProgress)
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  if (homeStore.adList.isEmpty)
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.beach_access_sharp,
                            color: Colors.white,
                            size: 100,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Não foram encontrados nenhum anúncio para esta pesquisa',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    );
                  return ListView.builder(
                    itemCount: homeStore.itemCount,
                    itemBuilder: (_, index) {
                      if (index < homeStore.adList.length)
                        return AdTile(homeStore.adList[index]);

                      homeStore.loadNextPage();
                      return Container(
                        height: 15,
                        child: LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.teal),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
