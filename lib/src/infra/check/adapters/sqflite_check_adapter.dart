import 'dart:convert';
import '../../../domain/check/entities/check.dart';
import '../../../domain/item/item.dart';
import '../../../domain/participant/participant.dart';

class SqfliteCheckAdapter {
  static Map<String, dynamic> toMap(Check check) {
    return {
      'id': check.id,
      'creationDate': check.creationDate?.toIso8601String() ??
          DateTime.now().toIso8601String(),
      'totalValue': check.totalValue,
      'participants': jsonEncode(check.participants
          .map((p) => {
                'name': p.name,
                'total': p.total,
              })
          .toList()),
      'items': jsonEncode(check.items
          .map((i) => {
                'name': i.name,
                'price': i.price,
                'consumers': i.consumers.map((p) => p.name).toList(),
              })
          .toList()),
    };
  }

  static Check fromMap(Map<String, dynamic> map) {
    final participantsList = (jsonDecode(map['participants'] ?? '[]') as List)
        .map((p) {
          final name = p['name'] as String?;
          final total = p['total'] as num?;
          if (name == null) {
            return null;
          }
          return Participant(name)..total = (total ?? 0.0).toDouble();
        })
        .whereType<Participant>()
        .toList();

    final participantMap = {
      for (final p in participantsList) p.name.trim().toLowerCase(): p
    };

    final itemsList = (jsonDecode(map['items'] ?? '[]') as List)
        .map((i) {
          final name = i['name'] as String?;
          final price = i['price'] as num?;
          final consumers = i['consumers'] as List?;
          if (name == null) {
            return null;
          }
          return Item(
            name: name,
            price: (price ?? 0.0).toDouble(),
            consumers: (consumers ?? [])
                .map((consumerName) {
                  if (consumerName is! String) return null;
                  return participantMap[consumerName.trim().toLowerCase()] ??
                      Participant(consumerName);
                })
                .whereType<Participant>()
                .toList(),
          );
        })
        .whereType<Item>()
        .toList();

    return Check(
      id: map['id'] as String?,
      creationDate: map['creationDate'] != null
          ? DateTime.parse(map['creationDate'])
          : null,
      participants: participantsList,
      items: itemsList,
    );
  }
}
