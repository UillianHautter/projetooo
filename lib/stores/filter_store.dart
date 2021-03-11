import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import 'home_store.dart';

part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  _FilterStore({this.orderBy = OrderBy.DATE, this.minPrice, this.maxPrice});

  @observable
  OrderBy orderBy = OrderBy.DATE;

  @action
  void serOrderBy(OrderBy value) => orderBy = value;

  @observable
  int minPrice;

  @action
  void setMinPrice(int value) => minPrice = value;

  @observable
  int maxPrice;

  @action
  void setMaxPrice(int value) => maxPrice = value;

  @computed
  String get princeError =>
      maxPrice != null && minPrice != null && maxPrice < minPrice
          ? 'Faixa de preços invalida'
          : null;
  @computed
  bool get isFormatValid => princeError == null;

  void save() {
    GetIt.I<HomeStore>().setFilter(this);
  }

  FilterStore clone() {
    return FilterStore(
      orderBy: orderBy,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }
}
