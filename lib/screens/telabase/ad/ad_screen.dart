import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tcc/models/ad.dart';
import 'package:projeto_tcc/screens/telabase/ad/components/main_panel.dart';

class AdScreen extends StatelessWidget {
  AdScreen(this.ad);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Anúncio'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: 280,
            child: Carousel(
              images: ad.images
                  .map(
                    (url) => CachedNetworkImageProvider(url),
                  )
                  .toList(),
              dotSize: 5,
              dotColor: Colors.teal,
              autoplay: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                MainPanel(ad),
                Divider(color: Colors.black),
                DescriptionPanel(ad),
              ],
            ),
          )
        ],
      ),
    );
  }
}
