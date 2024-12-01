class ConvertHelper {
  double rateUsdBs;
  double rateBsUsd;

  ConvertHelper(this.rateUsdBs, this.rateBsUsd);

  double usdABs(double mount) {
    double result = mount * rateUsdBs;
    return _bankRound(result);
  }

  double bsAUsd(double mount) {
    double result = mount * rateBsUsd;
    return _bankRound(result);
  }

  double _bankRound(double value) {
    return (value * 100).roundToDouble() / 100;
  }
}
