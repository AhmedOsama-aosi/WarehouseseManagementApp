class Clint {
  //attributes = fields in table
  int? _clintId;
  late String _fullName;
  String? _phoneNumber;
  String? _commercialRegister;
  String? _taxcard;
  String? _address;
  String? _notes;
  late String _addtionDate;
  int? _operationCount;
  double? _balance;
  String? _lastPaidDate;
  int? _paymentDeadline;
  late int _notify;
  late int _deleted;

  Clint(dynamic customer) {
    _clintId = customer['ClintId'];
    _fullName = customer['FullName'];
    _phoneNumber = customer['PhoneNumber'];
    _commercialRegister = customer['CommercialRegister'];
    _taxcard = customer['Taxcard'];
    _address = customer['Address'];
    _notes = customer['Notes'];
    _addtionDate = customer['AddtionDate'];
    _operationCount = customer['OperationCount'];
    _balance = customer['Balance'];
    _lastPaidDate = customer['LastPaidDate'];
    _paymentDeadline = customer['PaymentDeadline'];
    _notify = customer['Notify'];
    _deleted = customer['Deleted'];
  }
  Clint.fromMap(Map customer) {
    _clintId = customer['ClintId'];
    _fullName = customer['FullName'];
    _phoneNumber = customer['PhoneNumber'];
    _commercialRegister = customer['CommercialRegister'];
    _taxcard = customer['Taxcard'];
    _address = customer['Address'];
    _notes = customer['Notes'];
    _addtionDate = customer['AddtionDate'];
    _operationCount = customer['OperationCount'];
    _balance = customer['Balance'];
    _lastPaidDate = customer['LastPaidDate'];
    _paymentDeadline = customer['PaymentDeadline'];
    _notify = customer['Notify'];
    _deleted = customer['Deleted'];
  }

  Map<String, dynamic> toMap() => {
        'ClintId': _clintId,
        'FullName': _fullName,
        'PhoneNumber': _phoneNumber,
        'CommercialRegister': _commercialRegister,
        'Taxcard': _taxcard,
        'Address': _address,
        'Notes': _notes,
        'AddtionDate': _addtionDate,
        'OperationCount': _operationCount,
        'Balance': _balance,
        'LastPaidDate': _lastPaidDate,
        'PaymentDeadline': _paymentDeadline,
        'Notify': _notify,
        'Deleted': _deleted,
      };

  int get id => _clintId!;
  String get fullName => _fullName;
  String get phoneNumber => _phoneNumber!;
  String get commercialRegister => _commercialRegister!;
  String get taxcard => _taxcard!;
  String get address => _address!;
  String get notes => _notes!;
  String get addtionDate => _addtionDate;
  int get operationCount => _operationCount!;
  double get balance => _balance!;
  String get lastPaidDate => _lastPaidDate!;
  int get paymentDeadline => _paymentDeadline!;
  int get notify => _notify;
  int get deleted => _deleted;
}
