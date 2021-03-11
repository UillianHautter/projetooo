import 'package:mobx/mobx.dart';
import 'package:projeto_tcc/models/user.dart';
import 'package:projeto_tcc/repositories/repository.dart';

part 'user_manager_store.g.dart';

class UserManagerStore  = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store{

  _UserManagerStore(){
    _getCurrentUser();
  }

  @observable
  User user;

  @action
  void setUser(User value ) => user = value;
  @computed
  bool get isLoggedIn => user != null;
  Future<void> _getCurrentUser() async{
    final user = await UserRepository().currentuser();
    setUser(user);
  }
}