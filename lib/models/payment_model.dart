class PaymentModel {
  String? paymentNo;
  String? controlNo;
  double? amount;
  double? units;
  String? date;

  PaymentModel({
    this.paymentNo,
    this.controlNo,
    this.amount,
    this.units,
    this.date
  });

  // You can add methods for converting to and from JSON here if needed.
  // For example:

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentNo: json['payment_no'],
      controlNo: json['control_no'],
      amount: json['amount'],
      units: json['units'],
      date:json['date']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_no': paymentNo,
      'control_no': controlNo,
      'amount': amount,
      'units': units,
      'date':date
    };
  }
}
