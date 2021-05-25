class APIResponse<T>{
  T data;
  bool error;
  String errorMessage;

  APIResponse({required this.data, this.errorMessage = 'error', this.error=false});
}