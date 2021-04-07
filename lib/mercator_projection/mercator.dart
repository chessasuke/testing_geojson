//import 'package:vector_math/vector_math.dart';
//import 'dart:math' as math;
//import 'package:flutter/material.dart';
//
//class Mercator {
//  static final double RADIUS_MAJOR = 6378137.0;
//  static final double RADIUS_MINOR = 6356752.3142;
//
//  static double xAxisProjection(double input) {
//    return radians(input) * Mercator.RADIUS_MAJOR;
//  }
//
//  static double yAxisProjection(double input) {
//    return math.log(math.tan(math.pi / 4 + radians(input) / 2)) *
//        Mercator.RADIUS_MAJOR;
//  }
//
//  /// Convert longitude to X value
//  static double webMecatorXProj(Size mapSize, double long) {
//    return (long + 180) * (mapSize.width / 360);
//  }
//
//  /// Convert latitude to Y value
//  static double webMecatorYProj(Size mapSize, double lat) {
//    double latRad = lat * math.pi / 180;
//    var mercN = math.log(math.tan((math.pi / 4) + (latRad / 2)));
//    return (mapSize.height / 2) - (mapSize.width * mercN / (2 * math.pi));
//  }
//}
