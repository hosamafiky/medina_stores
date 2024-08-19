import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaginatedList<T extends Object> {
  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int itemsCount;

  final bool hasReachedEnd;

  const PaginatedList({
    this.data = const [],
    this.currentPage = 0,
    this.lastPage = 1,
    this.itemsCount = 1,
    this.hasReachedEnd = false,
  });

  factory PaginatedList.fromMap(
    Map<String, dynamic> map, {
    required T Function(Map<String, dynamic>) mapper,
  }) {
    return PaginatedList<T>(
      data: List<T>.from(map['data'].map((x) => mapper(x))),
      itemsCount: map['items_count'] ?? 1,
      currentPage: map['current_page'] ?? 1,
      lastPage: map['last_page'] ?? 1,
    );
  }

  PaginatedList<T> copyWith({
    List<T>? data,
    int? currentPage,
    int? lastPage,
    int? itemsCount,
    bool? hasReachedEnd,
  }) {
    return PaginatedList<T>(
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      itemsCount: itemsCount ?? this.itemsCount,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  factory PaginatedList.fromJson(
    String source, {
    required T Function(Map<String, dynamic>) mapper,
  }) =>
      PaginatedList.fromMap(jsonDecode(source), mapper: mapper);

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

class GetPaginatedListParams extends Equatable {
  final int page;
  final int perPage;

  const GetPaginatedListParams({
    this.page = 1,
    this.perPage = 10,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'per_page': perPage,
    };
  }

  @override
  String toString() => 'GetPaginatedListParams(page: $page, perPage: $perPage)';

  @override
  List<Object?> get props => [page, perPage];
}
