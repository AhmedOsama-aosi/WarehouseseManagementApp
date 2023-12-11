class Operation {
  int? _operationId;
  late int _clintId;
  late String _operationDescribe;
  String? _operationNotes;
  late String _operationDate;
  double? _discount;
  double? _required;
  double? _paid;
  double? _residual;
  double? _lastBalance;
  double? _currentBalance;

  Operation(dynamic operation) {
    _operationId = operation['OperationId'];
    _clintId = operation['ClintId'];
    _operationDescribe = operation['OperationDescribe'];
    _operationNotes = operation['OperationNotes'];
    _operationDate = operation['OperationDate'];
    _discount = operation['Discount'];
    _required = operation['Required'];
    _paid = operation['Paid'];
    _residual = operation['Residual'];
    _lastBalance = operation['LastBalance'];
    _currentBalance = operation['CurrentBalance'];
  }

  Operation.fromMap(Map<String, dynamic> operationMap) {
    _operationId = operationMap['OperationId'];
    _clintId = operationMap['ClintId'];
    _operationDescribe = operationMap['OperationDescribe'];
    _operationNotes = operationMap['OperationNotes'];
    _operationDate = operationMap['OperationDate'];
    _discount = operationMap['Discount'];
    _required = operationMap['Required'];
    _paid = operationMap['Paid'];
    _residual = operationMap['Residual'];
    _lastBalance = operationMap['LastBalance'];
    _currentBalance = operationMap['CurrentBalance'];
  }

  Map<String, dynamic> toJson() => {
        'OperationId': _operationId,
        'ClintId': _clintId,
        'OperationDescribe': _operationDescribe,
        'OperationNotes': _operationNotes,
        'OperationDate': _operationDate,
        'Discount': _discount,
        'Required': _required,
        'Paid': _paid,
        'Residual': _residual,
        'LastBalance': _lastBalance,
        'CurrentBalance': _currentBalance,
      };

  int get operationId => _operationId!;

  set operationId(int operationId) => _operationId = operationId;

  String get operationNotes => _operationNotes!;

  set operationNotes(String operationNotes) => _operationNotes = operationNotes;

  double get discount => _discount!;

  set discount(double discount) => _discount = discount;

  double get operationRequired => _required!;

  set operationRequired(double operationrequired) =>
      _required = operationrequired;

  double get paid => _paid!;

  set paid(double paid) => _paid = paid;

  double get residual => _residual!;

  set residual(double residual) => _residual = residual;

  double get lastBalance => _lastBalance!;

  set lastBalance(double lastBalance) => _lastBalance = lastBalance;

  double get currentBalance => _currentBalance!;

  set currentBalance(double currentBalance) => _currentBalance = currentBalance;
}
