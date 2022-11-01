import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/ui/util/delayed_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'market_price.g.dart';

@riverpod
MarketPriceRepository _marketPriceRepository(_MarketPriceRepositoryRef ref) =>
    MarketPriceRepository();

@riverpod
MarketPrice? _getUCOMarketPrice(
  _GetUCOMarketPriceRef ref, {
  required String currency,
}) {
  return ref.read(_marketPriceRepositoryProvider).getUCOMarketPrice(currency);
}

class MarketPriceRepository {
  MarketPrice? getUCOMarketPrice(
    String currency, {
    Duration delay = const Duration(milliseconds: 800),
  }) async {
    if (currency.isEmpty) {
      return MarketPrice(
        amount: 0,
        useOracle: false,
        lastLoading: DateTime.now().millisecondsSinceEpoch ~/
            Duration.millisecondsPerSecond,
      );
    }

    CancelableTask<MarketPrice?>? _getUCOMarketPriceTask;

    late final MarketPrice ucoMarketPrice;

    if (currency == 'eur' || currency == 'usd') {
      try {
        ucoMarketPrice = await Future<MarketPrice>(
          () async {
            _getUCOMarketPriceTask?.cancel();
            _getUCOMarketPriceTask = CancelableTask<MarketPrice?>(
              task: () => _getUCOMarketPrice(currency: currency),
            );
            final ucoMarketPrice =
                await _getUCOMarketPriceTask?.schedule(delay);

            return ucoMarketPrice ??
                MarketPrice(
                  amount: 0,
                  useOracle: false,
                  lastLoading: DateTime.now().millisecondsSinceEpoch ~/
                      Duration.millisecondsPerSecond,
                );
          },
        );
      } on CanceledTask {
        return;
      }
    }

    Future<MarketPrice> _getUCOMarketPrice(
      String currency, {
      Duration delay = const Duration(milliseconds: 800),
    }) async {
      ref = ref.copyWith(
        feeEstimation: const AsyncValue.loading(),
      );

      state = state.copyWith(
        feeEstimation: AsyncValue.data(fees),
        errorNameText: '',
      );
      if (state.feeEstimationOrZero >
          state.accountBalance.nativeTokenValue! - fees) {
        state = state.copyWith(
          errorNameText:
              AppLocalization.of(context)!.insufficientBalance.replaceAll(
                    '%1',
                    state.symbolFees(context),
                  ),
        );
      }
    }
  }
}

abstract class MarketPriceProviders {
  static final getUCOMarketPrice = _getUCOMarketPriceProvider;
}
