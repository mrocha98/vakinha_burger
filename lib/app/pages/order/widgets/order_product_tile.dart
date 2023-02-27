import 'package:flutter/material.dart';

import '../../../core/extensions/formatter_extension.dart';
import '../../../core/ui/styles/colors_app.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/delivery_increment_decrement_button.dart';
import '../../../dto/order_product_dto.dart';

class OrderProductTile extends StatelessWidget {
  const OrderProductTile({
    super.key,
    required this.index,
    required this.order,
  });

  final int index;

  final OrderProductDto order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image.network(
            order.product.image,
            width: 112,
            height: 112,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.product.name,
                    style: context.textStyles.textRegular.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.product.price.currencyPTBR,
                        style: context.textStyles.textMedium.copyWith(
                          fontSize: 14,
                          color: context.colors.secondary,
                        ),
                      ),
                      DeliveryIncrementDecrementButton.compact(
                        amount: 1,
                        onDecrementTap: () {},
                        onIncrementTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
