class HttpBaseResponse <T>{

    int? code;
    bool? isSuccess;
    String? message;
    T? data;


    HttpBaseResponse({this.code,this.isSuccess,this.message,this.data});



}