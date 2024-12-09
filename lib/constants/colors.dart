import 'package:flutter/material.dart';

const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF000000);
const kMainColor = Color(0xFF2563EB);

const Gradient kContainerGradient = LinearGradient(
  colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const Gradient kBlueToLightBlue = LinearGradient(
  colors: [
    Color.fromARGB(255, 203, 209, 255),
    Color.fromARGB(255, 208, 188, 255)
  ], // Light gray tones
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
