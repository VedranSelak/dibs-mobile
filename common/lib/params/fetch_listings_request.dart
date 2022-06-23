class FetchListingsRequestParams {
  const FetchListingsRequestParams({
    required this.filters,
    required this.sort,
  });

  final List<String> filters;
  final String sort;
}
