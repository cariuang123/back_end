import 'package:vania/vania.dart';

class CreatePickupRequestsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('pickup_requests', () {
      id();
      char("latitude");
      char("longitude");
      char("notes");
      char("status");
      char("waste_type");
      timeStamp("processed_at");
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('pickup_requests');
  }
}