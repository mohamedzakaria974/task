class AppException {
  int? errorCode;
  String? msg;

  AppException({this.errorCode = -10000, this.msg});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppException &&
          runtimeType == other.runtimeType &&
          errorCode == other.errorCode &&
          msg == other.msg;

  @override
  int get hashCode => errorCode.hashCode ^ msg.hashCode;

  @override
  String toString() {
    return 'AppException{errorCode: $errorCode, msg: $msg}';
  }
}

//todo: may need to customize errorCodes
