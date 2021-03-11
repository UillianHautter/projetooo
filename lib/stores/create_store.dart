import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_tcc/models/ad.dart';
import 'package:projeto_tcc/models/categoty.dart';
import 'package:projeto_tcc/repositories/ad_repository.dart';
import 'package:projeto_tcc/stores/user_manager_store.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  ObservableList images = ObservableList();

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @computed
  bool get imagesValid => images.isNotEmpty;
  String get imagesError {
    if (!showError || imagesValid)
      return null;
    else
      return 'Insira imagens';
  }

  @observable
  String title = '';
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length >= 5;
  String get titleError {
    if (!showError || titleValid)
      return null;
    else if (title.isEmpty)
      return 'Campo Obrigatório';
    else
      return 'Titulo muito curto';
  }

  @observable
  String description = '';
  void setDescription(String value) => description = value;

  @computed
  bool get descriptionValid => description.length >= 10;
  String get descriptionError {
    if (!showError || descriptionValid)
      return null;
    else if (description.isEmpty)
      return 'Campo Obrigatório';
    else
      return 'descrição muito curto';
  }

  @observable
  String priceText = '';

  @action
  void setPrice(String value) => priceText = value;

  @computed
  num get price {
    if (priceText.contains(',')) {
      return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), '')) / 100;
    } else {
      return num.tryParse(priceText);
    }
  }

  bool get priceValid => price != null && price <= 9999999999;
  String get priceError {
    if (!showError || priceValid)
      return null;
    else if (priceText.isEmpty)
      return 'campo obrigatório';
    else
      return 'Preço inválido';
  }

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool value) => hidePhone = value;

  @computed
  bool get formValid =>
      imagesValid && titleValid && descriptionValid && priceValid;

  @computed
  Function get sendPressed => formValid ? _send : null;

  @observable
  bool showError = false;

  @action
  void invalidSendPressed() => showError = true;

  @observable
  bool loading = false;

  @observable
  String error;

  @observable
  bool savedAd = false;

  @action
  Future<void> _send() async {
    final ad = Ad();
    ad.title = title;
    ad.description = description;
    ad.category = category;
    ad.price = price;
    ad.hidephone = hidePhone;
    ad.images = images;
    ad.user = GetIt.I<UserManagerStore>().user;

    loading = true;
    try {
      await AdRepository().save(ad);
      savedAd = true;
    } catch (e) {
      error = e;
    }
    loading = false;
  }
}
