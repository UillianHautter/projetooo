import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:projeto_tcc/models/categoty.dart';
import 'package:projeto_tcc/repositories/parse_errors.dart';
import 'package:projeto_tcc/repositories/table_keys.dart';

class CategoryRepository {
  Future<List<Category>> getList() async {
    final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByAscending(keyCategoriasDescription);

    final response = await queryBuilder.query();
    if (response.success) {
      return response.results.map((p) => Category.fromParse(p)).toList();
    } else {
      throw ParseErrors.getDescription(response.error.code);
    }
  }
}
