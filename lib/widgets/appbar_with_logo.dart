import 'package:flutter/material.dart';
import 'package:ricky_mobile/utilities/utilities.dart';

class AppBarWithLogo extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWithLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: '171717'.toColor(),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 34,
            ),
            Row(
              children: [
                Icon(
                  Icons.search_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
