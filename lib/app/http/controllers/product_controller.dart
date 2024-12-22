import 'package:api_work/app/models/product.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> create(Request request) async {
    request.validate(
      {
        'vend_id': 'required',
        'prod_name': 'required',
        'prode_price': 'required',
        'prod_desc': 'required',
      },
      {
        'vend_id.required': 'nama tidak boleh kosong',
        'prod_name.required': 'deskripsi tidak boleh kosong',
        'rode_price.required': 'harga tidak boleh kosong',
        'prod_desc.required': ' tidak boleh kosong',
      },
    );

    final requestData = request.input();

    final product = await Product().query().insert(requestData);

    try {
      return Response.json(
        {
          "message": "product berhasil ditambahkan",
          "data": product,
        },
        201,
      );
    } catch (e) {
      return Response.json(
        {
          "message": "Error terjadi pada server, silahkan coba lagi nanti",
        },
        500,
      );
    }
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
}

final ProductController productController = ProductController();
