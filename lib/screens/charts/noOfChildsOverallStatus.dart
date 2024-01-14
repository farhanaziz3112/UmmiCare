import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/shared/function.dart';

class noOfChildsOverallStatus extends StatefulWidget {
  const noOfChildsOverallStatus({super.key, required this.parentId});
  final String parentId;

  @override
  State<noOfChildsOverallStatus> createState() =>
      _noOfChildsOverallStatusState();
}

class _noOfChildsOverallStatusState extends State<noOfChildsOverallStatus> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<childModel>>(
        stream: parentDatabase(parentId: widget.parentId).allChildData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<childModel>? childList = snapshot.data;
            return SfCircularChart(
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<CategoryData, String>(
                    dataSource: getCategoryData(childList!),
                    radius: '50%',
                    pointColorMapper: (CategoryData data, _) => data.color,
                    xValueMapper: (CategoryData data, _) => data.x,
                    yValueMapper: (CategoryData data, _) => data.y,
                    dataLabelSettings: const DataLabelSettings(
                        // Renders the data label
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 20)))
              ],
            );
          } else {
            return Container();
          }
        });
  }
}

class CategoryData {
  CategoryData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}

List<CategoryData> getCategoryData(List<childModel> childList) {
  int category1 = getNoOfChildStatus(childList, 'great');
  int category2 = getNoOfChildStatus(childList, 'normal');
  int category3 = getNoOfChildStatus(childList, 'needs attention');

  return <CategoryData>[
    CategoryData('Great', category1, const Color(0xff71CBCA)),
    CategoryData('Normal', category2, const Color(0xffF29180)),
    CategoryData('Needs Attention', category3, const Color(0xff8290F0))
  ];
}
