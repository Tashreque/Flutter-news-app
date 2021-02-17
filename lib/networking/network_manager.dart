class NetworkManager {
  // Make the constructor private.
  NetworkManager._privateContructor();

  // Declare single one time only instance.
  static final NetworkManager instance = NetworkManager._privateContructor();
  final String _apiKey = "3191677734b945dd866141a14f66c780";

  Future<void> getTopHeadlines() {}
}
