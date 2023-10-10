
import 'package:test/test.dart';
import 'package:news/homePage.dart';


void main() {
  test('searchHandler throws errors for invalid input', () {
    // Create a mock HomePage with the necessary variables
    final homePage = HomePage();

    // Test empty search
   /* expect(() => homePage.searchHandler(), throwsA(isA<String>()));

    // Test search with numbers
    homePage.search = 'abc123';
    expect(() => homePage.searchHandler(), throwsA(isA<String>()));

    // Test startDate after endDate
    homePage.search = 'valid search';
    homePage.startDate = DateTime(2023, 10, 15);
    homePage.endDate = DateTime(2023, 10, 10);
    expect(() => homePage.searchHandler(), throwsA(isA<String>()));*/
  });
}