


import 'package:flutter/material.dart';
import 'package:rfw_gen/rfw_gen.dart';
import 'package:test_stac/common/user_card.dart';

@RfwWidget('myWidget')
Widget buildMyWidget() {
  return Column(
    children: [
      UserCard(name: "Alex", onTap: () {}),
    ],
  );
}

