import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseController extends GetxController {
  late List<Map<String, dynamic>> texts = [];
  RxString selectedText = ''.obs;

  late Database _db;

  init() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'TextData.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Texts (id INTEGER PRIMARY KEY AUTOINCREMENT, fidel TEXT,kutir TEXT,sirateNetib TEXT)');
        await db.transaction((txn) async {
          final batch = txn.batch();
          final data = [
            {
              'fidel':
                  'ክርስቶስ ኢየሱስ እንደሚሆን የሕይወት ተስፋ በእግዚአብሔር ፈቃድ የኢየሱስ ክርስቶስ ሐዋርያ የሆነ ጳውሎስ',
              'kutir':
                  'ክርስቶስ ኢየሱስ እንደሚሆን የሕይወት ተስፋ በእግዚአብሔር ፈቃድ የኢየሱስ ክርስቶስ ሐዋርያ የሆነ ጳውሎስ 21 ',
              'sirateNetib':
                  'ክርስቶስ ኢየሱስ እንደሚሆን የሕይወት ተስፋ፥ በእግዚአብሔር ፈቃድ የኢየሱስ ክርስቶስ ሐዋርያ የሆነ ጳውሎስ',
            },
            {
              'fidel':
                  'በክርስቶስ ኢየሱስ ባለ እምነትና ፍቅር አድርገህ ከእኔ የሰማኸውን ጤናማ ቃል ምሳሌ ያዝ',
              'kutir':
                  '12 በክርስቶስ ኢየሱስ ባለ እምነትና ፍቅር አድርገህ፥ ከእኔ የሰማኸውን ጤናማ ቃል ምሳሌ ያዝ',
              'sirateNetib':
                  'በክርስቶስ ኢየሱስ ባለ እምነትና ፍቅር አድርገህ፥ ከእኔ የሰማኸውን ጤናማ ቃል ምሳሌ ያዝ፤',
            },
          ];

          // Add insert operations to the batch
          for (final item in data) {
            batch.insert('Texts', item);
          }

          // Execute the batch
          await batch.commit();
        });
      },
    );
    if (texts.isNotEmpty) {
      selectedText.value = texts[0]['fidel'];
    }
  }

  closeDb() async {
    await _db.close();
  }

  fetch() async {
    final maps = await _db.query("Texts");
    if (maps.isNotEmpty) {
      texts = maps;
    } else
      print("Empty ok!");
  }

  dropTable() async {
    await _db.execute('DROP TABLE IF EXISTS Texts');
  }

  insertEveryThing() async {}
}
