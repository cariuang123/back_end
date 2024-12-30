import 'dart:io';
import 'package:vania/vania.dart';
import '../../models/waste_point.dart';

class WastePointController extends Controller {
  // GET /api/waste-points
  Future<Response> index() async {
    try {
      final wastePoints = await WastePoint().query().get();
      return Response.json({
        "message": "success",
        "data": wastePoints
      }, HttpStatus.ok);
    } catch (e) {
      return Response.json({
        "message": "Failed to fetch waste points",
        "error": e.toString()
      }, HttpStatus.internalServerError);
    }
  }

  // POST /api/waste-points
  Future<Response> store(Request request) async {
    request.validate({
      'name': 'required|string',
      'type': 'required|string',
      'latitude': 'required|numeric',
      'longitude': 'required|numeric',
    }, {
      'name.required': 'Name cannot be empty',
      'type.required': 'Type cannot be empty',
      'latitude.required': 'Latitude cannot be empty',
      'longitude.required': 'Longitude cannot be empty'
    });

    try {
      final wastePoint = await WastePoint().query().insert({
        'name': request.input('name'),
        'type': request.input('type'),
        'latitude': request.input('latitude'),
        'longitude': request.input('longitude'),
        'created_at': DateTime.now().toIso8601String(),
      });

      return Response.json({
        "message": "Waste point created successfully",
        "data": wastePoint
      }, HttpStatus.created);
    } catch (e) {
      return Response.json({
        "message": "Failed to create waste point",
        "error": e.toString()
      }, HttpStatus.internalServerError);
    }
  }

  // DELETE /api/waste-points/:id
  Future<Response> destroy(Request request, String id) async {
    try {
      final wastePoint = await WastePoint().query().where('id', '=', id).first();
      
      if (wastePoint == null) {
        return Response.json({
          "message": "Waste point not found",
          "data": null
        }, HttpStatus.notFound);
      }

      await WastePoint().query().where('id', '=', id).delete();
      return Response.json({
        "message": "Waste point deleted successfully"
      }, HttpStatus.ok);
    } catch (e) {
      return Response.json({
        "message": "Failed to delete waste point",
        "error": e.toString()
      }, HttpStatus.internalServerError);
    }
  }
}

final WastePointController wastePointController = WastePointController(); 