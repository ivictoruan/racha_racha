import '../../item/item.dart';
import '../../participant/participant.dart';

class Check {
  String? id;
  DateTime? creationDate;
  List<Participant> participants;
  List<Item> items;

  Check({
    this.id,
    this.creationDate,
    this.participants = const [],
    this.items = const [],
  });

  double get totalValue =>
      items.fold(0, (double sum, Item item) => sum + item.price);

  Check copyWith({
    String? id,
    DateTime? creationDate,
    List<Participant>? participants,
    List<Item>? items,
  }) {
    return Check(
      id: id ?? this.id,
      creationDate: creationDate ?? this.creationDate,
      participants: participants ?? this.participants,
      items: items ?? this.items,
    );
  }
}
