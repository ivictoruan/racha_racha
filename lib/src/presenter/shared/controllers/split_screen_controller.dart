import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../domain/check/entities/check.dart';
import '../../../domain/check/usecases/create_check.dart';
import '../../../domain/item/item.dart';
import '../../../domain/participant/participant.dart';

class SplitScreenController extends ChangeNotifier {
  final CreateCheck _createCheck;

  String? _id;
  DateTime? _creationDate;

  final List<Item> _items = [];
  final List<Participant> _participants = [];

  List<Participant> _initialParticipants = [];
  List<Item> _initialItems = [];

  SplitScreenController({required CreateCheck createCheck})
      : _createCheck = createCheck {
    _saveInitialSnapshot();
  }

  String? get id => _id;
  DateTime? get creationDate => _creationDate;
  UnmodifiableListView<Item> get items => UnmodifiableListView<Item>(_items);
  UnmodifiableListView<Participant> get participants =>
      UnmodifiableListView<Participant>(_participants);
  double get totalValue =>
      _items.fold(0.0, (sum, item) => sum + item.price);

  bool get hasChanges {
    if (_participants.isEmpty && _items.isEmpty) return false;
    final participantsChanged =
        !_areParticipantsEqual(_initialParticipants, _participants);
    final itemsChanged = !_areItemsEqual(_initialItems, _items);
    return participantsChanged || itemsChanged;
  }

  void _saveInitialSnapshot() {
    _initialParticipants = _participants
        .map((p) => Participant(p.name)..total = p.total)
        .toList();
    _initialItems = _items
        .map((item) => Item(
              name: item.name,
              price: item.price,
              consumers:
                  item.consumers.map((c) => Participant(c.name)).toList(),
            ))
        .toList();
  }

  bool _areParticipantsEqual(List<Participant> a, List<Participant> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i].name.trim().toLowerCase() != b[i].name.trim().toLowerCase()) {
        return false;
      }
    }
    return true;
  }

  bool _areItemsEqual(List<Item> a, List<Item> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i].name.trim().toLowerCase() != b[i].name.trim().toLowerCase()) {
        return false;
      }
      if (a[i].price != b[i].price) {
        return false;
      }
      if (!_areParticipantsEqual(a[i].consumers, b[i].consumers)) {
        return false;
      }
    }
    return true;
  }

  Future<bool> createCheck() async {
    final now = DateTime.now();
    final check = Check(
      id: _id,
      creationDate: _creationDate ?? now,
      items: _items,
      participants: _participants,
    );
    final result = await _createCheck.call(check: check);
    return result.fold(
      (failure) {
        log('[SplitScreenController] Falha ao salvar check: ${failure.message}');
        return false;
      },
      (savedId) {
        _id = savedId;
        _creationDate ??= now;
        _saveInitialSnapshot();
        notifyListeners();
        return true;
      },
    );
  }

  void addParticipant(String name) {
    addParticipantWithItems(name, const []);
  }

  void addParticipantWithItems(String name, List<Item> consumedItems) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty ||
        _participants.any((p) =>
            p.name.trim().toLowerCase() == trimmedName.toLowerCase())) {
      return;
    }
    final newParticipant = Participant(trimmedName);
    _participants.add(newParticipant);

    for (final item in consumedItems) {
      final actualItem = _items.firstWhere(
        (i) => i == item || (i.name == item.name && i.price == item.price),
        orElse: () => item,
      );
      if (!actualItem.consumers.contains(newParticipant)) {
        actualItem.consumers.add(newParticipant);
      }
    }

    _splitBill();
    notifyListeners();
  }

  void editParticipant(int index, String newName) {
    final trimmedName = newName.trim();
    if (index >= 0 && index < _participants.length && trimmedName.isNotEmpty) {
      _participants[index].name = trimmedName;
      _splitBill();
      notifyListeners();
    }
  }

  void editParticipantWithItems(
    int index,
    String newName,
    List<Item> consumedItems,
  ) {
    final trimmedName = newName.trim();
    if (index < 0 || index >= _participants.length || trimmedName.isEmpty) return;

    final participant = _participants[index];
    participant.name = trimmedName;

    for (final item in _items) {
      final shouldContain = consumedItems.contains(item);
      if (shouldContain && !item.consumers.contains(participant)) {
        item.consumers.add(participant);
      } else if (!shouldContain && item.consumers.contains(participant)) {
        item.consumers.remove(participant);
      }
    }

    _splitBill();
    notifyListeners();
  }

  void removeParticipant(int index) {
    if (index >= 0 && index < _participants.length) {
      final removed = _participants.removeAt(index);
      for (final item in _items) {
        item.consumers.removeWhere((c) => c == removed);
      }
      _splitBill();
      notifyListeners();
    }
  }

  void addItem({required Item item}) {
    final participantMap = {
      for (final p in _participants) p.name.trim().toLowerCase(): p
    };
    final syncedConsumers = item.consumers
        .map((c) => participantMap[c.name.trim().toLowerCase()] ?? c)
        .toList();

    _items.add(
      Item(
        name: item.name,
        price: item.price,
        consumers: syncedConsumers,
      ),
    );
    _splitBill();
    notifyListeners();
  }

  void _resetParticipantTotals() {
    for (final participant in _participants) {
      participant.total = 0.0;
    }
  }

  void _distributeItemCosts() {
    for (final item in _items) {
      if (item.consumers.isEmpty) continue;
      final share = item.price / item.consumers.length;
      for (final consumer in item.consumers) {
        consumer.total += share;
      }
    }
  }

  void _splitBill() {
    _resetParticipantTotals();
    _distributeItemCosts();
  }

  void updateItem(
    int index,
    String name,
    double price,
    List<Participant> consumers,
  ) {
    if (index < 0 || index >= _items.length) {
      throw ArgumentError("Invalid index for editing item");
    }

    final participantMap = {
      for (final p in _participants) p.name.trim().toLowerCase(): p
    };
    final syncedConsumers = consumers
        .map((c) => participantMap[c.name.trim().toLowerCase()] ?? c)
        .toList();

    _items[index] = Item(
      name: name,
      price: price,
      consumers: syncedConsumers,
    );
    _splitBill();
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      _splitBill();
      notifyListeners();
    }
  }

  void loadCheck(Check check) {
    _id = check.id;
    _creationDate = check.creationDate;
    _items.clear();
    _participants.clear();

    _participants.addAll(check.participants);

    final participantMap = {
      for (final p in _participants) p.name.trim().toLowerCase(): p
    };

    for (final item in check.items) {
      final syncedConsumers = item.consumers
          .map((c) => participantMap[c.name.trim().toLowerCase()] ?? c)
          .toList();
      _items.add(
        Item(
          name: item.name,
          price: item.price,
          consumers: syncedConsumers,
        ),
      );
    }

    _splitBill();
    _saveInitialSnapshot();
    notifyListeners();
  }
}
