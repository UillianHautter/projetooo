import 'package:flutter/material.dart';
import 'package:projeto_tcc/helpers/extensions.dart';
import 'package:projeto_tcc/models/ad.dart';

class MainPanel extends StatelessWidget {
  MainPanel(this.ad);

  final Ad ad;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 15),
          child: Text(
            ad.price.formattedMoney(),
            style: TextStyle(
              fontSize: 35,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
        ),
        Text(
          ad.title,
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 28),
          child: Text(
            'Publicado no dia ${ad.created.formattedDate()}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),
        )
      ],
    );
  }
}
