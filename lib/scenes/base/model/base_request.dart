class BaseRequest<T> {
  final T data;

  BaseRequest({
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'data': data
    };
  }
}