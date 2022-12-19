
class Result{
   int code;
   String msg;
   late int dataCount;
   dynamic  data;
   Result( this.code, this.msg, this.data,  this.dataCount);

   Result.fromJson(Map<String, dynamic> json)
       : code = json['code'],
        dataCount=json['dataCount'],
        data= json['data'],
         msg = json['msg'];

   Map<String, dynamic> toJson() => {
     'code': code,
     'msg': msg,
     'data':data,
     'dataCount':dataCount
   };
}