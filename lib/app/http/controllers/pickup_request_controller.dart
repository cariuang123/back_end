import 'dart:io';
import 'package:vania/vania.dart';
import 'package:api_work/app/models/pickup_request.dart';

class PickupRequestController extends Controller {
  // GET /api/pickup-requests
  Future<Response> index() async {
    try {
      final requests = await PickupRequest().query().get();
      return Response.json({
        "message": "success",
        "data": requests
      }, HttpStatus.ok);
    } catch (e) {
      return Response.json({
        "message": "Failed to fetch pickup requests",
        "error": e.toString()
      }, HttpStatus.internalServerError);
    }
  }

  // GET /api/pickup-requests/pending
  Future<Response> getPending() async {
    try {
      final pendingRequests = await PickupRequest()
          .query()
          .where('status', '=', 'pending')
          .get();
      
      return Response.json({
        "message": "success",
        "data": pendingRequests
      }, HttpStatus.ok);
    } catch (e) {
      return Response.json({
        "message": "Failed to fetch pending requests",
        "error": e.toString()
      }, HttpStatus.internalServerError);
    }
  }

  // POST /api/pickup-requests
  Future<Response> store(Request request) async {
    request.validate({
      'latitude': 'required|numeric',
      'longitude': 'required|numeric',
      'notes': 'required|string',
      'waste_type': 'required|string'
    }, {
      'latitude.required': 'Latitude cannot be empty',
      'longitude.required': 'Longitude cannot be empty',
      'notes.required': 'Notes cannot be empty',
      'waste_type.required': 'Waste type cannot be empty'
    });

    try {
      final pickupRequest = await PickupRequest().query().insert({
        'latitude': request.input('latitude'),
        'longitude': request.input('longitude'),
        'notes': request.input('notes'),
        'waste_type': request.input('waste_type'),
        'status': 'pending',
        'created_at': DateTime.now().toIso8601String(),
      });

      return Response.json({
        "message": "Pickup request created successfully",
        "data": pickupRequest
      }, HttpStatus.created);
    } catch (e) {
      return Response.json({
        "message": "Failed to create pickup request",
        "error": e.toString()
      }, HttpStatus.internalServerError);
    }
  }

  // PUT /api/pickup-requests/:id
  Future<Response> update(Request request, int id) async {
    try {
      final existingRequest = await PickupRequest()
          .query()
          .where('id', '=', id)
          .first();

      if (existingRequest == null) {
        return Response.json({
          "message": "Pickup request not found"
        }, HttpStatus.notFound);
      }

      final updateData = {
        'status': 'completed',
        'processed_at': DateTime.now().toIso8601String(),
      };

      await PickupRequest()
          .query()
          .where('id', '=', id)
          .update(updateData);

      final updatedRequest = await PickupRequest()
          .query()
          .where('id', '=', id)
          .first();

      return Response.json({
        "message": "Pickup request updated successfully",
        "data": updatedRequest
      });
    } catch (e) {
      return Response.json({
        "message": "Failed to update pickup request",
        "error": e.toString()
      }, HttpStatus.internalServerError);
    }
  }

  // DELETE /api/pickup-requests/:id
  Future<Response> destroy(Request request, int id) async {
    try {
      final existingRequest = await PickupRequest()
          .query()
          .where('id', '=', id)
          .first();

      if (existingRequest == null) {
        return Response.json({
          "message": "Pickup request not found"
        }, HttpStatus.notFound);
      }

      await PickupRequest()
          .query()
          .where('id', '=', id)
          .delete();

      return Response.json({
        "message": "Pickup request deleted successfully"
      });
    } catch (e) {
      return Response.json({
        "message": "Failed to delete pickup request",
        "error": e.toString()
      }, HttpStatus.internalServerError);
    }
  }
}

final PickupRequestController pickupRequestController = PickupRequestController(); 