import 'package:vania/vania.dart';

class CretaeProductsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('cretae_products', () {
      id();
      char("vend_id");
      char("prod_name");
      integer("prode_price");
      text("prod_desc");
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('cretae_products');
  }
}
