import 'package:banni_tinni/features/home/data/models/shared_link_model.dart';
import 'package:banni_tinni/features/home/data/services/link_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LinkRepository {
  final LinkService _linkService;
  final SharedPreferences _prefs;
  static const String _cachedLinksKey = 'cached_links';

  LinkRepository(this._linkService, this._prefs);

  Future<bool> shareLink(String url) async {
    final success = await _linkService.shareLink(url);
    if (success) {
      // Add to local cache
      final newLink = SharedLinkModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        url: url,
        timestamp: DateTime.now(),
      );
      await _cacheLink(newLink);
    }
    return success;
  }

  Future<List<SharedLinkModel>> getSharedLinks() async {
    try {
      final remoteLinks = await _linkService.getSharedLinks();
      final links = remoteLinks.map((json) => SharedLinkModel.fromJson(json)).toList();
      
      // Update cache
      await _updateCache(links);
      return links;
    } catch (e) {
      // Return cached links if remote fetch fails
      return _getCachedLinks();
    }
  }

  Future<void> _cacheLink(SharedLinkModel link) async {
    final cachedLinks = _getCachedLinks();
    cachedLinks.insert(0, link);
    await _updateCache(cachedLinks);
  }

  List<SharedLinkModel> _getCachedLinks() {
    final cachedData = _prefs.getStringList(_cachedLinksKey) ?? [];
    return cachedData
        .map((data) => SharedLinkModel.fromJson(Map<String, dynamic>.from(
            Map<String, dynamic>.from(Map<String, dynamic>.from(
                Map<String, dynamic>.from(data as Map<String, dynamic>))))))
        .toList();
  }

  Future<void> _updateCache(List<SharedLinkModel> links) async {
    final linkData = links.map((link) => link.toJson().toString()).toList();
    await _prefs.setStringList(_cachedLinksKey, linkData);
  }
}