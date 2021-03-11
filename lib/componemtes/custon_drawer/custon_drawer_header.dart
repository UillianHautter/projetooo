import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_tcc/screens/telabase/login/login_screen.dart';
import 'package:projeto_tcc/stores/page_store.dart';
import 'package:projeto_tcc/stores/user_manager_store.dart';

class CustonDrawerHeader extends StatelessWidget {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();

        if (userManagerStore.isLoggedIn) {
          GetIt.I<PageStore>().setPage(3);
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => LoginScreen()));
        }
      },
      child: Container(
        color: Colors.teal,
        height: 85,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(
              Icons.supervised_user_circle_sharp,
              color: Colors.white,
              size: 35,
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userManagerStore.isLoggedIn
                        ? userManagerStore.user.name
                        : 'Acessar sua Conta ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                      userManagerStore.isLoggedIn
                          ? userManagerStore.user.email
                          : 'Clique Aqui',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
