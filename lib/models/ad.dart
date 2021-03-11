import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:projeto_tcc/models/categoty.dart';
import 'package:projeto_tcc/models/user.dart';
import 'package:projeto_tcc/repositories/repository.dart';
import 'package:projeto_tcc/repositories/table_keys.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }

class Ad {
  Ad.fromParse(ParseObject object) {
    id = object.objectId;
    title = object.get<String>(keyAdTitle);
    description = object.get<String>(keyAdDescription);
    images = object.get<List>(keyAdImages).map((e) => e.url).toList();
    hidephone = object.get<bool>(keyAdHidePhone);
    price = object.get<num>(keyAdPrice);
    created = object.createdAt;

    views = object.get<int>(keyAdViews, defaultValue: 0);
    user = UserRepository().mapParseToUser(object.get<ParseUser>(keyAdOwner));
    category = Category.fromParse(object.get<ParseObject>(keyAdCategory));
    status = AdStatus.values[object.get<int>(keyAdStatus)];
  }
  Ad();

  String id;
  List images;

  String title;
  String description;

  Category category;

  num price;
  bool hidephone;

  AdStatus status = AdStatus.PENDING;
  DateTime created;

  User user;

  int views;
}
