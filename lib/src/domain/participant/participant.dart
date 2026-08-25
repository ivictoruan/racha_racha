class Participant {
  String name;
  double total = 0.0;

  Participant(this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Participant &&
          runtimeType == other.runtimeType &&
          name.trim().toLowerCase() == other.name.trim().toLowerCase();

  @override
  int get hashCode => name.trim().toLowerCase().hashCode;
}
