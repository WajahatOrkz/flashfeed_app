import 'package:flashfeed_app/features/feed/data/feed_item_model.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {

  // Feed Controller

  var feedItems = <FeedItem>[].obs;
  var isLoading = false.obs;
  var selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadFeedItems();
  }

  void loadFeedItems() {
    isLoading.value = true;
    
    // Simulate loading feed items
    feedItems.value = [
      FeedItem(id: '1', type: FeedItemType.image, isSelected: true, imageUrl: 'https://picsum.photos/300/300?random=1'),
      FeedItem(id: '2', type: FeedItemType.video, hasOverlay: true, imageUrl: 'https://picsum.photos/300/300?random=2'),
      FeedItem(id: '3', type: FeedItemType.image, isSelected: true, imageUrl: 'https://picsum.photos/300/300?random=3'),
      FeedItem(id: '4', type: FeedItemType.video, imageUrl: 'https://picsum.photos/300/300?random=4'),
      FeedItem(id: '5', type: FeedItemType.video, hasOverlay: true, imageUrl: 'https://picsum.photos/300/300?random=5'),
      FeedItem(id: '6', type: FeedItemType.carousel, imageUrl: 'https://picsum.photos/300/300?random=6'),
      FeedItem(id: '7', type: FeedItemType.placeholder, isBlue: true),
      FeedItem(id: '8', type: FeedItemType.image, imageUrl: 'https://picsum.photos/300/300?random=8'),
      FeedItem(id: '9', type: FeedItemType.placeholder, isBlue: true),
      FeedItem(id: '10', type: FeedItemType.placeholder, isBlue: true),
      FeedItem(id: '11', type: FeedItemType.video, imageUrl: 'https://picsum.photos/300/300?random=11'),
      FeedItem(id: '12', type: FeedItemType.image, isSelected: true, imageUrl: 'https://picsum.photos/300/300?random=12'),
      FeedItem(id: '13', type: FeedItemType.image, isSelected: true, imageUrl: 'https://picsum.photos/300/300?random=13'),
      FeedItem(id: '14', type: FeedItemType.carousel, imageUrl: 'https://picsum.photos/300/300?random=14'),
      FeedItem(id: '15', type: FeedItemType.empty),
      FeedItem(id: '16', type: FeedItemType.carousel, imageUrl: 'https://picsum.photos/300/300?random=16'),
    ];
    
    isLoading.value = false;
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void toggleSelection(String id) {
    final index = feedItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final item = feedItems[index];
      feedItems[index] = FeedItem(
        id: item.id,
        type: item.type,
        imageUrl: item.imageUrl,
        isSelected: !item.isSelected,
        hasOverlay: item.hasOverlay,
        isBlue: item.isBlue,
      );
      feedItems.refresh();
    }
  }

  void refreshFeed() {
    loadFeedItems();
  }

  final RxInt selectedIndex = 0.obs;

  void onTabChanged(int index) {
    selectedIndex.value = index;
  }
}
