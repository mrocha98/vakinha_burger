import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../dto/order_product_dto.dart';
import '../../../pages/auth/login/login_page.dart';
import '../../extensions/formatter_extension.dart';
import '../helpers/size_extensions.dart';
import '../styles/text_styles.dart';

class ShoppingBag extends StatelessWidget {
  const ShoppingBag({
    super.key,
    required this.bag,
  });

  final List<OrderProductDto> bag;

  double get _totalBag =>
      bag.fold(0.0, (total, element) => total + element.totalPrice);

  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final cache = GetStorage();
    if (!cache.hasData('accessToken')) {
      final loginResult = await navigator.pushNamed(LoginPage.routeName);
    }
    // envia para o order
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: 90,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          _goOrder(context);
        },
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.shopping_cart_outlined),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Ver Sacola',
                style: context.textStyles.textExtraBold.copyWith(fontSize: 14),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _totalBag.currencyPTBR,
                style: context.textStyles.textExtraBold.copyWith(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
