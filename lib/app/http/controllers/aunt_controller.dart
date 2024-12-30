import 'dart:io';
import 'package:api_work/app/models/user.dart';
import 'package:vania/vania.dart';


class AuthController extends Controller {
  Future<Response> register(Request request) async {
    request.validate({
      'name': 'required',
      'email': 'required|email',
      'password': 'required|min_length:6',
      'role': 'required'
    }, {
      'name.required': 'Name cannot be empty',
      'email.required': 'Email cannot be empty',
      'password.required': 'Password cannot be empty',
      'password.min_length': 'Password must be at least 6 characters',
      'role.required': 'Role cannot be empty'
    });

    final name = request.input('name');
    final email = request.input('email');
    final role = request.input('role');
    var password = request.input('password').toString();

    var users = await User().query().where('email', '=', email).first();
    if (users != null) {
      return Response.json({"message": "User already exists"}, 409);
    }

    password = Hash().make(password);
    var user = await User().query().insert({
      "name": name,
      "email": email,
      "password": password,
      "role": role,
      "created_at": DateTime.now().toIso8601String(),
    });

    final token = await Auth()
        .login(user)
        .createToken(expiresIn: Duration(days: 30), withRefreshToken: true);

    return Response.json({
      'message': 'Registration successful',
      'token': token
    }, 201);
  }
  

  Future<Response> login(Request request) async {
    request.validate({
      'email': 'required|email',
      'password': 'required'
    }, {
      'email.required': 'Email cannot be empty',
      'password.required': 'Password cannot be empty'
    });

    final email = request.input('email');
    var password = request.input('password').toString();

    var user = await User().query().where('email', '=', email).first();
    if (user == null) {
      return Response.json({"message": "User not found"}, 404);
    }

    if (!Hash().verify(password, user['password'])) {
      return Response.json({'message': 'Invalid password'}, 401);
    }

    final token = await Auth()
        .login(user)
        .createToken(expiresIn: Duration(days: 30), withRefreshToken: true);

    return Response.json({
      'message': 'Login successful',
      'token': token,
      'role': user['role']
    });
  }
Future<Response> logout(Request request) async {
  try {
    // Hapus token autentikasi pengguna
    User().logout();

    return Response.json({
      'message': 'Logout successful'
    });
  } catch (e) {
    // Tangani kesalahan dari Auth().logout()
    return Response.json({
      'message': 'Failed to logout',
      'error': e.toString(),
    }, HttpStatus.internalServerError);
  }
}


  Future<Response> me() async {
    Map? user = Auth().user();
    if (user != null) {
      user.remove('password');
      return Response.json({
        "message": "success",
        "data": user,
      }, HttpStatus.ok);
    }
    return Response.json({
      "message": "User not found",
      "data": null,
    }, HttpStatus.notFound);
  }

  Future<Response> updatePassword(Request request) async {
    request.validate({
      'old_password': 'required',
      'new_password': 'required|min_length:6'
    });

    Map? currentUser = Auth().user();
    if (currentUser == null) {
      return Response.json({
        "message": "Unauthorized"
      }, HttpStatus.unauthorized);
    }

    var user = await User().query().where('id', '=', currentUser['id']).first();
    if (user == null) {
      return Response.json({
        "message": "User not found"
      }, HttpStatus.notFound);
    }

    final oldPassword = request.input('old_password').toString();
    final newPassword = request.input('new_password').toString();

    if (!Hash().verify(oldPassword, user['password'])) {
      return Response.json({
        "message": "Invalid old password"
      }, HttpStatus.badRequest);
    }

    await User().query()
        .where('id', '=', user['id'])
        .update({'password': Hash().make(newPassword)});

    return Response.json({
      "message": "Password updated successfully"
    });
  }

  Future<Response> store(Request request) async {
    return Response.json({});
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    return Response.json({});
  }

  Future<Response> destroy(int id) async {
    return Response.json({});
  }

  Future<Response> profile() async {
    Map? user = Auth().user();
    if (user != null) {
      var userData = await User()
          .query()
          .where('id', '=', user['id'])
          .select(['name', 'email'])
          .first();
      
      if (userData != null) {
        return Response.json({
          "message": "success",
          "data": userData,
        }, HttpStatus.ok);
      }
    }
    
    return Response.json({
      "message": "User not found",
      "data": null,
    }, HttpStatus.notFound);
  }
}

final AuthController authController = AuthController();