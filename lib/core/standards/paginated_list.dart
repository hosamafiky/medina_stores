import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaginatedList<T extends Object> {
  final List<T> list;
  final int currentPage;
  final int lastPage;
  final int itemsCount;
  final bool hasReachedEnd;

  const PaginatedList({
    this.list = const [],
    this.currentPage = 0,
    this.lastPage = 1,
    this.itemsCount = 1,
    this.hasReachedEnd = false,
  });

  PaginatedList<T> copyWith({
    List<T>? list,
    int? currentPage,
    int? lastPage,
    int? itemsCount,
    bool? hasReachedEnd,
  }) {
    return PaginatedList<T>(
      list: list ?? this.list,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      itemsCount: itemsCount ?? this.itemsCount,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  PaginatedList<R> map<R extends Object>(R Function(T) mapper) {
    return PaginatedList<R>(
      list: list.map((item) => mapper(item)).toList(),
      currentPage: currentPage,
      lastPage: lastPage,
      itemsCount: itemsCount,
      hasReachedEnd: hasReachedEnd,
    );
  }

  @override
  String toString() {
    return 'PaginatedList(data: $list, currentPage: $currentPage, lastPage: $lastPage, itemsCount: $itemsCount)';
  }
}

class PaginatedListModel<T extends Object> extends PaginatedList<T> {
  const PaginatedListModel({
    super.list,
    super.currentPage,
    super.lastPage,
    super.itemsCount,
    super.hasReachedEnd = false,
  });

  factory PaginatedListModel.fromMap(
    Map<String, dynamic> map, {
    required T Function(Map<String, dynamic>) mapper,
  }) {
    return PaginatedListModel<T>(
      list: List<T>.from(map['data'].map((x) => mapper(x))),
      itemsCount: map['items_count'] ?? 1,
      currentPage: map['current_page'] ?? 1,
      lastPage: map['last_page'] ?? 1,
      hasReachedEnd: map['current_page'] == map['last_page'],
    );
  }

  factory PaginatedListModel.from(PaginatedList<T> paginatedList) {
    return PaginatedListModel<T>(
      list: paginatedList.list,
      itemsCount: paginatedList.itemsCount,
      currentPage: paginatedList.currentPage,
      lastPage: paginatedList.lastPage,
      hasReachedEnd: paginatedList.currentPage == paginatedList.lastPage,
    );
  }

  @override
  PaginatedListModel<T> copyWith({
    List<T>? list,
    int? currentPage,
    int? lastPage,
    int? itemsCount,
    bool? hasReachedEnd,
  }) {
    return PaginatedListModel<T>(
      list: list ?? this.list,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      itemsCount: itemsCount ?? this.itemsCount,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  factory PaginatedListModel.fromJson(
    String source, {
    required T Function(Map<String, dynamic>) mapper,
  }) =>
      PaginatedListModel.fromMap(jsonDecode(source), mapper: mapper);

  Map<String, dynamic> toMap(Map<String, dynamic> Function(T) mapper) => {
        "data": List<Map<String, dynamic>>.from(list.map((x) => mapper(x))),
        "current_page": currentPage,
        "last_page": lastPage,
        "items_count": itemsCount,
      };

  String toJson(Map<String, dynamic> Function(T) mapper) => jsonEncode(toMap(mapper));
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
