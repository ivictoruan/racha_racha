import '../participant/participant.dart';

class Item {
  final String name;
  final double price;
  final List<Participant> consumers;

  Item({
    required this.name,
    required this.price,
    required this.consumers,
  });
}
