import 'package:flutter/material.dart' show BuildContext;
import './media_query.dart';

double reponsiveBlackBoardWidth(BuildContext context) {
  if (screenWidth(context) > 1200) {
    return screenWidth(context) * 0.45;
  } else if (screenWidth(context) > 900) {
    return screenWidth(context) * 0.65;
  } else if (screenWidth(context) > 750) {
    return screenWidth(context) * 0.75;
  } else if (screenWidth(context) > 500) {
    return screenWidth(context) * 0.85;
  }
  return screenWidth(context) * 0.95;
}

double responsiveBlackBoardHeight(BuildContext context) {
  if (screenWidth(context) > 1200) {
    return screenHeight(context) * 0.35;
  } else if (screenWidth(context) > 900) {
    return screenHeight(context) * 0.3;
  } else if (screenWidth(context) > 750) {
    return screenHeight(context) * 0.25;
  } else if (screenWidth(context) < 500) {
    return screenHeight(context) * 0.3;
  }
  return screenHeight(context) * 0.27;
}

double responsiveFontSize(BuildContext context, double fontSize) {
  if (screenWidth(context) > 1200) {
    return fontSize;
  } else if (screenWidth(context) > 900) {
    return fontSize - 4;
  } else if (screenWidth(context) > 750) {
    return fontSize - 6;
  } else if (screenWidth(context) > 500) {
    return fontSize - 8;
  }
  return fontSize - 10;
}

double responsiveOptionPane(BuildContext context) {
  if (screenWidth(context) > 750) {
    return screenHeight(context) * 0.7;
  } else if (screenWidth(context) < 500) {
    return screenHeight(context) * 0.9;
  }
  return screenHeight(context) * 0.9;
}
