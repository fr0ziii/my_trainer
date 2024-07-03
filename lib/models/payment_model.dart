class Payment {
  final String paymentId;
  final String userId;
  final double amount;
  final DateTime date;
  final String sessionId;
  final String paymentMethod;

  Payment({
    required this.paymentId,
    required this.userId,
    required this.amount,
    required this.date,
    required this.sessionId,
    required this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return {
      'paymentId': paymentId,
      'userId': userId,
      'amount': amount,
      'date': date.toIso8601String(),
      'sessionId': sessionId,
      'paymentMethod': paymentMethod,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      paymentId: map['paymentId'],
      userId: map['userId'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      sessionId: map['sessionId'],
      paymentMethod: map['paymentMethod'],
    );
  }
}
