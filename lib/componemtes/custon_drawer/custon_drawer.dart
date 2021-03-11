import 'package:flutter/material.dart';
import 'package:projeto_tcc/componemtes/custon_drawer/page_section.dart';

import 'custon_drawer_header.dart';


class CustonDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ClipRRect(
     borderRadius: BorderRadius.horizontal(right: Radius.circular(35)),
      child: SizedBox(
       width:MediaQuery.of(context).size.width * 0.6,
       child: Drawer(
        child: ListView(
          children: [
            CustonDrawerHeader(),

            PageSection(),
          ],
        )
       ),
      ),
    );
  }
}