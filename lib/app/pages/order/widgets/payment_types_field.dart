import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_styles.dart';

class PaymentTypesField extends StatelessWidget {
  const PaymentTypesField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Forma de Pagamento",
            style: context.textStyles.textRegular.copyWith(
              fontSize: 16,
            ),
          ),
          SmartSelect.single(
            title: '',
            selectedValue: '',
            modalType: S2ModalType.bottomSheet,
            onChange: (value) {},
            tileBuilder: (context, state) {
              return InkWell(
                onTap: state.showModal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: context.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.selected.title ?? '',
                            style: context.textStyles.textRegular,
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            choiceItems: S2Choice.listFrom(
              source: [
                {'value': 'VA', 'title': 'Vale Alimentação'},
                {'value': 'VR', 'title': 'Vale Refeição'},
                {'value': 'CC', 'title': 'Cartão de Crédito'},
              ],
              title: (index, item) => item['title'] ?? '',
              value: (index, item) => item['value'] ?? '',
              group: (index, item) => 'Selecione uma forma de pagamento',
            ),
            choiceType: S2ChoiceType.radios,
            choiceGrouped: true,
            modalFilter: false,
            placeholder: '',
          ),
        ],
      ),
    );
  }
}
