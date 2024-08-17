import 'dart:convert';

class PaginatedList<T extends Object> {
  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int itemsCount;

  const PaginatedList({
    this.data = const [],
    this.currentPage = 1,
    this.lastPage = 1,
    this.itemsCount = 1,
  });

  factory PaginatedList.fromMap(Map<String, dynamic> map, {T Function(Map<String, dynamic>)? mapper}) {
    return PaginatedList<T>(
      data: mapper == null ? map['data'] : List<T>.from(map['data']['data'].map((x) => mapper(x))),
      itemsCount: map['data']['items_count'] ?? 1,
      currentPage: map['data']['current_page'] ?? 1,
      lastPage: map['data']['last_page'] ?? 1,
    );
  }

  factory PaginatedList.fromJson(String source) => PaginatedList.fromMap(jsonDecode(source));

  Map<String, dynamic> toMap(Map<String, dynamic> Function(T) mapper) => {
        "data": List<Map<String, dynamic>>.from(data.map((x) => mapper(x))),
        "current_page": currentPage,
        "last_page": lastPage,
        "items_count": itemsCount,
      };

  String toJson(Map<String, dynamic> Function(T) mapper) => jsonEncode(toMap(mapper));

  @override
  String toString() {
    return 'PaginatedList(data: $data, currentPage: $currentPage, lastPage: $lastPage, itemsCount: $itemsCount)';
  }
}
