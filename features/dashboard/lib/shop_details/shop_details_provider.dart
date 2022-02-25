import 'package:core/base_provider.dart';
import 'package:core/domain/navigation.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/cart_item.dart';
import 'package:core/model/category.dart';
import 'package:core/model/product.dart';
import 'package:core/model/shop.dart';
import 'package:dashboard/data/repository/repository.dart';
import 'package:dashboard/data/repository/repository_imp.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetailsProvider extends BaseProvider {
  final Repository _repository;
  Shop? shop;

  List<Category>? subCategories;
  Category? selectedSubCategory;
  List<CartItem> _allShopProducts = [];
  List<CartItem> currentSubCategoryProducts = [];
  List<CartItem> selectedProductsItems = [];
  bool isAuthenticated = false;

  ShopDetailsProvider({Repository? repository})
      : _repository = repository ?? MainRepository();

  Future<void> init(String? shopId) async {
    await getShopDetailsById(shopId);
    await Future.wait([
      getShopSubCategories(shopId),
      getShopProducts(shopId),
    ]);
  }

  Future<void> getShopDetailsById(String? id) async {
    if (id == null) return;
    Result result = await _repository.getShopById(id);
    if (result.succeeded()) {
      shop = result.getDataIfSuccess();
    }
  }

  Future<void> getShopSubCategories(String? shopId) async {
    if (shopId == null) return;
    Result result = await _repository.getShopSubCategories(shopId);
    if (result.succeeded()) {
      subCategories = result.getDataIfSuccess();
      selectedSubCategory = subCategories?.first;
    }
  }

  Future<void> getShopProducts(String? shopId) async {
    if (shopId == null && shop != null) return;
    Result<List<Product>> result = await _repository.getShopProducts(shopId!);
    if (result.succeeded()) {
      if (shop != null) {
        _allShopProducts = result.getDataIfSuccess().toCartItem(shop!);
        onSubCategorySelected(selectedSubCategory);
      }
    }
  }

  void onSubCategorySelected(Category? subCategory) {
    selectedSubCategory = subCategory;
    currentSubCategoryProducts = _allShopProducts
        .where((element) => element.product?.subCategoryId == subCategory?.id)
        .toList();
    notifyListeners();
  }

  Future<void> openWhatsapp() async {
    var whatsappUrl = "whatsapp://send?phone=+2${shop?.phone}";
    bool foundWhatsapp = await canLaunch(whatsappUrl);
    if (foundWhatsapp) launch(whatsappUrl);
  }

  Future<void> openMap() async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${shop?.latitude},${shop?.longitude}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
