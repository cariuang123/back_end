import 'dart:io';
import 'package:api_work/database/migrations/create_personal_acces_tokens_table.dart';
import 'package:vania/vania.dart';
import 'create_users_table.dart';
import 'cretae_products_table.dart';
import 'cretae_customers_table.dart';
import 'cretae_orders_table.dart';
import 'cretae_ordeiters_table.dart';
import 'cretae_productnotes_table.dart';
import 'cretae_vendors_table.dart';
import 'create_waste_points_table.dart';
import 'create_pickup_requests_table.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		 //  await CreateUserTable().up();
    await CretaeProductsTable().up();
    await CretaeCustomersTable().up();
    await CretaeOrdersTable().up();
    await CretaeOrdeitersTable().up();
    await CretaeProductnotesTable().up();
    await CretaeVendorsTable().up();
    await CreatePersonalAccessTokensTable().up();
    await CreateUserTable().up();
    await CreateWastePointsTable().up();
    await CreatePickupRequestsTable().up();

	}

  dropTables() async {
		 await CretaeVendorsTable().down();
    await CretaeProductnotesTable().down();
    await CretaeOrdeitersTable().down();
    await CretaeOrdersTable().down();
    await CretaeCustomersTable().down();
    await CretaeProductsTable().down();
    await CreateUserTable().down();
    await CreatePersonalAccessTokensTable().down();
    await CreateUserTable().down();
    await CreateWastePointsTable().down();
    await CreatePickupRequestsTable().down();
	 }
}
