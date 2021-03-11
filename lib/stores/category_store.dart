import 'package:mobx/mobx.dart';
import 'package:projeto_tcc/models/categoty.dart';
import 'package:projeto_tcc/repositories/category_repository.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  _CategoryStore() {
    _loadCategorias();
  }

  ObservableList<Category> categoryList = ObservableList<Category>();

  @computed
  List<Category> get allCategoryList => List.from(categoryList)
    ..insert(0, Category(id: '*', description: 'Todas'));
  @action
  void setCategorias(List<Category> categorias) {
    categoryList.clear();
    categoryList.addAll(categorias);
  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;
  Future<void> _loadCategorias() async {
    try {
      final categorias = await CategoryRepository().getList();
      setCategorias(categorias);
    } catch (e) {
      setError(e);
    }
  }
}
