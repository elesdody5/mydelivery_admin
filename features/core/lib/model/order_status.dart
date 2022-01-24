enum OrderStatus {
  waitingShopResponse,
  refusedFromShop,
  inProgress,
  withDelivery,
  delivered,
  waitingDelivery
}

extension EnumToString on OrderStatus {
  String enumToString() {
    switch (this) {
      case OrderStatus.waitingShopResponse:
        return "waitingShopResponse";
      case OrderStatus.delivered:
        return "delivered";
      case OrderStatus.inProgress:
        return "inProgress";
      case OrderStatus.withDelivery:
        return "withDelivery";
      case OrderStatus.refusedFromShop:
        return "refusedFromShop";
      case OrderStatus.waitingDelivery:
        return "waitingDelivery";
      default:
        return "waitingShopResponse";
    }
  }
}

OrderStatus? stringToEnum(String? status) {
  switch (status) {
    case "waitingShopResponse":
      return OrderStatus.waitingShopResponse;
    case "inProgress":
      return OrderStatus.inProgress;
    case "withDelivery":
      return OrderStatus.withDelivery;
    case "delivered":
      return OrderStatus.delivered;
    case "refusedFromShop":
      return OrderStatus.refusedFromShop;
    case "waitingDelivery":
      return OrderStatus.waitingDelivery;
    default:
      return OrderStatus.waitingShopResponse;
  }
}
