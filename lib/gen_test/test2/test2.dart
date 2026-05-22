


import 'package:flutter/material.dart';
import 'package:rfw_gen/rfw_gen.dart';
import 'package:flutter_rfw_test/common/user_card.dart';

@RfwWidget('myWidget')
Widget buildMyWidget() {
  return Column(
    children: [
      UserCard(name: "Alex", onTap: () {}),
    ],
  );
}

