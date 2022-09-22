import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';
import 'package:core/model/review.dart';

class DeliveryReviewsProvider extends BaseProvider {
  final DeliveryRepository _deliveryRepository;
  List<Review> reviews = [];
  double average = 0;

  DeliveryReviewsProvider({DeliveryRepository? deliveryRepository})
      : _deliveryRepository = deliveryRepository ?? DeliveryRepositoryImp();

  Future<void> getAllReviews(String? deliveryId) async {
    if (deliveryId == null) return;
    Result result = await _deliveryRepository.getAllDeliveryReviews(deliveryId);
    if (result.succeeded()) {
      reviews = result.getDataIfSuccess();
      if (reviews.isNotEmpty) _calculateAverage();
      notifyListeners();
    }
  }

  void _calculateAverage() {
    var sum = 0.0;
    for (var review in reviews) {
      sum += review.rating ?? 0;
    }
    average = sum / reviews.length;
  }
}
