import 'package:flutter/material.dart';

class DeliveryAppbar extends AppBar {
  DeliveryAppbar({
    super.key,
    super.elevation = 1,
  }) : super(
          title: Image.asset(
            'assets/images/logo.png',
            width: 80,
          ),
        );
}
