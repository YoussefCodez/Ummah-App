import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ummah/core/constants/app_const.dart';
import 'package:ummah/core/constants/app_endpoints.dart';
import 'package:ummah/features/home/data/models/timing_model.dart';

part 'api_client_service.g.dart';

@RestApi(baseUrl: AppConst.baseUrl)
abstract class ApiClientService {
  factory ApiClientService(Dio dio, {String? baseUrl}) = _ApiClientService;

  @GET(AppEndpoints.calendarByCity)
  Future<TimingModel> getCalendarByCity({
    @Query("city") required String city,
    @Query("country") required String country,
    @Query("month") required int month,
    @Query("year") required int year,
    @Query("method") int method = 5,
  });
}
