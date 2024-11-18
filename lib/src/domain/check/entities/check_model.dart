class CheckModel {
  DateTime? creationDate;
  String? id;
  // TODO: verificar a necessidade de adicionar uma localização
  // TODO: verificar a necessidade de adicionar um título
  // TODO: verificar a necessidade de adicionar uma lista de participantes
  // TODO: verificar a necessidade de adicionar uma foto
  // TODO: verificar a necessidade de adicionar uma descrição
  // TODO: verificar a necessidade de adicionar uma uid
  double totalValue;
  double individualPrice;
  double waiterPercentage;
  double totalWaiterValue;
  bool isSomeoneDrinking;
  double totalDrinkPrice;
  int totalPeopleDrinking;
  double individualPriceWhoIsDrinking;
  int totalPeople;

  CheckModel({
    this.creationDate,
    this.id,
    this.totalValue = 0,
    this.individualPrice = 0,
    this.waiterPercentage = 0,
    this.totalWaiterValue = 0,
    this.isSomeoneDrinking = false,
    this.totalDrinkPrice = 0,
    this.totalPeopleDrinking = 0,
    this.individualPriceWhoIsDrinking = 0,
    this.totalPeople = 1,
  });

  factory CheckModel.reseted() => CheckModel();
}
