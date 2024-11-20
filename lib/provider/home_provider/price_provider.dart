import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/home_provider/model/total_price_model.dart';
import 'package:posapp/provider/home_provider/products_provider.dart';


class PriceNotifier extends StateNotifier<TotalPriceModel>{
  final Ref ref;
  PriceNotifier(this.ref): super(TotalPriceModel(
      subTotal: '0.00',
      billDisc: '0.00',
      total: '0.00',
      taxable: '0.00',
      vat: '0.00',
      netAmount: '0.00',
      rcvdAmount: '0.00',
      balance: '0.00',
      itemDisc: '0.00',
      recvdCurr: '0.00'));

  void updateNetAmount() {
    double totalPrice = ref.read(productProvider.notifier).getTotalPrice();

    double vat = (totalPrice/100)*5;
    // double priceWithVat = vat + totalPrice;

    state = state.copyWith(
      vat: vat.toString(),
        netAmount: totalPrice.toStringAsFixed(2));
  }

}

final priceProvider = StateNotifierProvider<PriceNotifier, TotalPriceModel>((ref) {

  return PriceNotifier(ref);
});

enum PaidVia { cash, card, cardPlusCash}

final paidViaProvider = StateProvider<PaidVia>((ref){
  return PaidVia.cash;
});



