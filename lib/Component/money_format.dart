import 'package:flutter_masked_text2/flutter_masked_text2.dart';

MoneyMaskedTextController moneyFormat(money) {
 return MoneyMaskedTextController(
  thousandSeparator: ".",
  leftSymbol: "Rp. ",
  precision: 2,
  initialValue: money.toDouble(),
 );
}