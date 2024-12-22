import 'package:vania/vania.dart';

class CretaeVendorsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('cretae_vendors', () {
      id();
      char("vend_name");
      text("vend_address");
      text("vend_kota");
      char("vend_state");
      char("vend_zip");
      char("vend_country");
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('cretae_vendors');
  }
}
