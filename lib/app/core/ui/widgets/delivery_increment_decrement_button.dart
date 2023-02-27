import 'package:flutter/material.dart';

import '../styles/colors_app.dart';
import '../styles/text_styles.dart';

class DeliveryIncrementDecrementButton extends StatelessWidget {
  const DeliveryIncrementDecrementButton({
    super.key,
    required this.amount,
    required this.onDecrementTap,
    required this.onIncrementTap,
  }) : _compact = false;

  const DeliveryIncrementDecrementButton.compact({
    super.key,
    required this.amount,
    required this.onDecrementTap,
    required this.onIncrementTap,
  }) : _compact = true;

  final int amount;

  final VoidCallback? onDecrementTap;

  final VoidCallback? onIncrementTap;

  final bool _compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _compact ? const EdgeInsets.all(5.0) : EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onDecrementTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '-',
                style: context.textStyles.textMedium.copyWith(
                  fontSize: _compact ? 10 : 22,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Text(
            amount.toString(),
            style: context.textStyles.textRegular.copyWith(
              fontSize: _compact ? 13 : 17,
              color: context.colors.secondary,
            ),
          ),
          InkWell(
            onTap: onIncrementTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '+',
                style: context.textStyles.textMedium.copyWith(
                  fontSize: _compact ? 10 : 22,
                  color: context.colors.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
