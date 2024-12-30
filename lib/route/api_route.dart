import 'package:api_work/app/http/controllers/aunt_controller.dart';

import 'package:api_work/app/http/controllers/product_controller.dart';
import 'package:api_work/app/http/controllers/customer_controller.dart';
import 'package:api_work/app/http/controllers/waste_point_controller.dart';
import 'package:api_work/app/http/controllers/pickup_request_controller.dart';
import 'package:api_work/app/http/controllers/dashboard_controller.dart';

import 'package:vania/vania.dart';
import 'package:api_work/app/http/middleware/authenticate.dart';

class ApiRoute implements Route {
  @override
  void register() {
    Router.post('/create-product', productController.create);
    Router.get('/api/user/profile', authController.profile);
    Router.get('/daftar-product', productController.show);
    Router.put('/edit-product/{id}', productController.update);
    Router.delete('/delete-product/{id}', productController.destroy);
    Router.post('/create-customer', customerController.create);
    Router.get('/daftar-customer', customerController.show);
    Router.put('/edit-customer/{id}', customerController.update);
    Router.delete('/delete-customer/{id}', customerController.destroy);
    Router.post('/api/auth/register', authController.register);
    Router.post('/api/auth/login', authController.login);
    Router.post('/api/auth/logout', authController.logout);
    Router.get('/api/auth/me', authController.me);
    Router.put('/api/auth/password', authController.updatePassword);
    Router.get('/api/waste-points', wastePointController.index);
    Router.post('/api/waste-points', wastePointController.store);
    Router.delete('/api/waste-points/{id}', wastePointController.destroy);
    Router.get('/api/pickup-requests', pickupRequestController.index);
    Router.get('/api/pickup-requests/pending', pickupRequestController.getPending);
    Router.post('/api/pickup-requests', pickupRequestController.store);
    Router.put('/api/pickup-requests/{id}/status', pickupRequestController.update);
    Router.delete('/api/pickup-requests/{id}/status', pickupRequestController.destroy);
    Router.get('/api/dashboard', dashboardController.index);
  }
}