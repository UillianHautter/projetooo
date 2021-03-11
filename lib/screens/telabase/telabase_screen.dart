import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_tcc/screens/telabase/create/create_screen.dart';
import 'package:projeto_tcc/stores/page_store.dart';

import 'home/home_screen.dart';

class TelabaseScreen extends StatefulWidget{

  @override
  _TelabaseScreenState createState() => _TelabaseScreenState();
}

class _TelabaseScreenState extends State<TelabaseScreen> {
  final PageController pageController = PageController();


  @override
  void initState() {
    super.initState();

    reaction(
          (_) =>pageStore.page,
          (page) => pageController.jumpToPage(page)
    );

  }

  final PageStore pageStore  = GetIt.I<PageStore>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          HomeScreen(),
          CreateScreen(),
          Container(color: Colors.lightGreen,),
          Container(color: Colors.greenAccent,),
        ],
      ),
    );
  }
}