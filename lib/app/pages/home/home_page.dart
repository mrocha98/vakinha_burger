import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/widgets/delivery_appbar.dart';
import 'home_controller.dart';
import 'home_state.dart';
import 'widgets/delivery_product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    controller.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (_, state) => state.status.matchAny(
          any: hideLoader,
          loading: showLoader,
          error: () {
            hideLoader();
            showError(state.errorMessage!);
          },
        ),
        buildWhen: (_, current) => current.status.matchAny(
          any: () => false,
          initial: () => true,
          loaded: () => true,
        ),
        builder: (_, state) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (_, index) {
                  final product = state.products[index];
                  final orderProduct = state.shoppingBag
                      .firstWhereOrNull((order) => order.product == product);
                  return DeliveryProductTile(
                    product: product,
                    orderProduct: orderProduct,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
