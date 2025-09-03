sealed class DataExceptions implements Exception {
  const DataExceptions();
}

class DatabaseDX extends DataExceptions {
  final String reason;

  const DatabaseDX(this.reason);
}
