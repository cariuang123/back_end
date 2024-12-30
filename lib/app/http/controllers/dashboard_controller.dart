import 'dart:io';
import 'package:vania/vania.dart';
import 'package:api_work/app/models/waste_point.dart';
import 'package:api_work/app/models/pickup_request.dart';

class DashboardController extends Controller {
  Future<Response> index() async {
    try {
      // Get total waste points
      final totalWastePoints = await WastePoint()
          .query()
          .count() as int;

      // Get pending requests count
      final pendingRequests = await PickupRequest()
          .query()
          .where('status', '=', 'pending')
          .count() as int;

      // Get completed requests count
      final completedRequests = await PickupRequest()
          .query()
          .where('status', '=', 'completed')
          .count() as int;

      return Response.json({
        "message": "success",
        "data": {
          "total_waste_points": totalWastePoints,
          "pending_requests": pendingRequests,
          "completed_requests": completedRequests
        }
      }, HttpStatus.ok);
    } catch (e) {
      return Response.json({
        "message": "Failed to fetch dashboard data",
        "error": e.toString()
      }, HttpStatus.internalServerError);
    }
  }
}

final DashboardController dashboardController = DashboardController(); 