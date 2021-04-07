//import 'package:flutter/services.dart';
//import 'package:testing_geojson/constant.dart';
//import 'package:testing_geojson/mercator_projection/mercator.dart';
//import 'package:flutter/material.dart';
//
//class Logic {
////  static Future<String> loadAsset(String file) async {
////    String str;
////    str = await rootBundle.loadString(file);
////    print('load');
////    return str;
////  }
//
////  static List<GeoObjectModel> processData(String loadedData) {
////    List<GeoObjectModel> data = [];
////    final List<dynamic> parsed =
////        jsonDecode(loadedData)['features'] as List<dynamic>;
////    for (int i = 0; i < parsed.length; i++) {
////      Map<String, dynamic> properties = parsed[i]['properties'];
////      print('coordinates');
////      print(parsed[i]['geometry']['coordinates']);
////      List<List<List<double>>> coordinates =
////          parsed[i]['geometry']['coordinates'] as List<List<List<double>>>;
////      print(properties.runtimeType);
////      print(coordinates.runtimeType);
////      data.add(
////          GeoObjectModel(properties: properties, coordinates: coordinates));
////    }
////    print('data: ${data.length}');
////    return data;
////  }
//
//  /// Apply a function to the values of a list/ List of List
//  static List convertListElements2XY(Size screenSize, List list) {
//    _util(screenSize, list) {
//      for (int i = 0; i < list.length; i++) {
//        /// Points
//        if (list[i][0].runtimeType != List) {
//          List<double> temp = list[i].cast<double>();
//          list[i] = projectToXY(screenSize, temp);
//        } else {
//          _util(screenSize, list[i]);
//        }
//      }
//    }
//
//    _util(screenSize, list);
//    print('buidl');
//    return list;
//  }
//
//  /// Function to calculate the
//  /// Projection of the long/lat coordinates into X/Y system
//  static List<double> projectToXY(Size screenSize, List<double> point) {
//    /// Projection into X,Y coordinate
//    double x = Mercator.xAxisProjection(point[0]);
//    double y = Mercator.yAxisProjection(point[1]);
//
//    /// Offset from screen center
//    List<double> rectified = [
//      x - convertedCenterX,
//      y - convertedCenterY,
//    ];
//    return rectified;
//  }
//}
