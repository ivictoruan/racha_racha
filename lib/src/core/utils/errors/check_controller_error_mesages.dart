/// Classe que define as mensagens de erro utilizadas pelo controller
/// responsável pela divisão de uma conta (check).
class CheckControllerErrorMessages {
  static const String errorMsgEmpty = "";

  /// Mensagem de erro para o valor total da conta não ser informado.
  static const String errorMsgTotalCheckPrice = "Digite o valor total da conta";

  /// Mensagem de erro para a quantidade total de pessoas não ser informada.
  static const String errorMsgTotalPeople =
      "Incluíndo você, digite a quantidade de pessoas dividindo a conta.";

  /// Mensagem de erro para haver mais pessoas bebendo do que rachando a conta.
  static const String errorMsgPeopleDrinking =
      "Mais pessoas bebendo do que rachando a conta!";

  /// Mensagem de erro para todos estarem bebendo quando ninguém está rachando a conta.
  static const String errorMsgPeopleDrinkingEveryone =
      "Se todos estão bebendo, toques em \"Não\"!";

  /// Mensagem de erro para não haver ninguém bebendo quando alguém está rachando a conta.
  static const String errorMsgNoPeopleDrinking =
      "Se não há ninguém bebendo, toques em \"Não\"!";

  /// Mensagem de erro para a quantidade de pessoas bebendo não ser informada.
  static const String errorMsgEmptyPeopleDrinking =
      "Incluíndo você, digite a quantidade de pessoas bebendo.";

  /// Mensagem de erro para um campo vazio não ser permitido.
  static const String errorMsgEmptyField = "O campo não pode ser vazio!";

  /// Mensagem de erro para o valor das bebidas ser maior do que o valor total da conta.
  static const String errorMsgTotalDrinkPrice =
      "Valor das bebidas maior do que o valor total!";

  /// Mensagem de erro para o valor das bebidas ser igual ao valor total da conta.
  static const String errorMsgTotalDrinkPriceEqual =
      "Valor das bebidas igual ao total, toque em \"Não\"";

  /// Mensagem de erro para não haver valor informado para as bebidas quando alguém está rachando a conta.
  static const String errorMsgNoDrinkPrice =
      "Se não há valor para bebidas toques em \"Não\"!";

  /// Mensagem de erro para campos inválidos ou preenchidos incorretamente.
  static const String errorMsgInvalidFields = "Prencha os campos corretamente!";

  static const String errorMsgFieldsMustBeFilled = "Os campos devem ser preenchidos";

  static const String numberOfPeopleCannotEqualToZero =  "❗️ A quantidade de pessoas não pode ser igual a zero!";
  
}
