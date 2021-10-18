import 'size_config.dart';

extension ResponsiveSize on num{
  double get w => SizeConfig.setWidth(this);
  double get h => SizeConfig.setHeight(this);
  double get sp => SizeConfig.setTextSp(this);
  double get spByWidth => SizeConfig.setTextSpWithWidth(this);
}