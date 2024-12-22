import 'package:api_work/app/http/controllers/aunt_controller.dart';

import 'package:api_work/app/http/controllers/product_controller.dart';
import 'package:api_work/app/http/controllers/customer_controller.dart';

import 'package:vania/vania.dart';

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
    Router.basePrefix('api');
    Router.group(() {
      Router.post('register', authController.register);
      Router.post('login', authController.login);
    }, prefix: 'auth');
  }
}