import 'dart:async';
import 'package:rajkumarpractice/app_config/app_constant.dart';
import 'package:rajkumarpractice/data/respository/repo.dart';
import 'package:rajkumarpractice/data/webservice/http_service.dart';
import 'package:rajkumarpractice/data/webservice/http_service_impl.dart';
import 'dart:convert' as convert;
class RepoImpl implements Repo {
   HttpService _httpService=HttpServiceImplementation();

  RepoImpl() {
    this._httpService.init();
  }

  @override
  Future<dynamic> getList(int pagination) async {
    try {
      final response = await _httpService.getRequest(
          "${AppConstant.BASEURL}/$pagination${AppConstant.LIST_API}");


      if (response.statusCode == 200) {
        var jsonResponse =
        convert.jsonDecode(response.body);
        return jsonResponse;
      }
    } on Exception catch (e) {}
  }
}
