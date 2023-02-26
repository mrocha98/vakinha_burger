import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/formatter_extension.dart';
import '../../../core/ui/styles/colors_app.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../dto/order_product_dto.dart';
import '../../../models/product_model.dart';
import '../../product_detail/product_detail_page.dart';
import '../home_controller.dart';

class DeliveryProductTile extends StatelessWidget {
  const DeliveryProductTile({
    super.key,
    required this.product,
    this.orderProduct,
  });

  final ProductModel product;

  final OrderProductDto? orderProduct;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final controller = context.read<HomeController>();
        final orderProductResult = await Navigator.of(context).pushNamed(
          ProductDetailPage.routeName,
          arguments: {
            'product': product,
            'order': orderProduct,
          },
        );
        if (orderProductResult is OrderProductDto) {
          controller.addOrUpdateBag(orderProductResult);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      product.name,
                      style: context.textStyles.textExtraBold
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      product.description,
                      style:
                          context.textStyles.textRegular.copyWith(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      product.price.currencyPTBR,
                      style: context.textStyles.textMedium.copyWith(
                        fontSize: 12,
                        color: context.colors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: product.image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
