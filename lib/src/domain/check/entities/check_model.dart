class CheckModel {
  DateTime? creationDate;
  // TODO: verificar a necessidade de colocar uma localização
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
}
