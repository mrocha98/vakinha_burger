import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/styles/text_styles.dart';
import '../../core/ui/widgets/delivery_appbar.dart';
import '../../core/ui/widgets/delivery_button.dart';
import '../../dto/order_product_dto.dart';
import '../../models/product_model.dart';
import 'widgets/widgets.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  static const routeName = '/order';

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text('Carrinho', style: context.textStyles.textTitle),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/trashRegular.png'),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    OrderProductTile(
                      index: index,
                      order: OrderProductDto(
                        product: const ProductModel(
                          id: 1,
                          description: 'xablau',
                          image:
                              'https://yt3.ggpht.com/EHTmzCY68TPEvzRA1lfXa5LwEmv8chOPumYYxA7IEdVxtNlBoN8weTqK2IC1C8euOzUZywFkxsH3pQ=s1024-nd-v1',
                          name: 'tanto faz',
                          price: 420.69,
                        ),
                        amount: 3,
                      ),
                    ),
                    const Divider(color: Colors.grey),
                  ],
                );
              },
              childCount: 2,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total do pedido',
                        style: context.textStyles.textExtraBold
                            .copyWith(fontSize: 16),
                      ),
                      Text(
                        r'R$ 420,69',
                        style: context.textStyles.textExtraBold
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.grey),
                const SizedBox(height: 10),
                OrderField(
                  title: 'Endereço de Entrega',
                  controller: TextEditingController(),
                  validator: Validatorless.required('a'),
                  hintText: 'Digite um endereço...',
                ),
                const SizedBox(height: 10),
                OrderField(
                  title: 'CPF',
                  controller: TextEditingController(),
                  validator: Validatorless.required('a'),
                  hintText: 'Digite o CPF...',
                ),
                const SizedBox(height: 10),
                const PaymentTypesField(),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DeliveryButton(
                    label: 'FINALIZAR',
                    onPressed: () {},
                    width: double.infinity,
                    height: 48,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
