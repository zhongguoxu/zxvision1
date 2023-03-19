import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zxvision1/utils/colors.dart';
import 'package:zxvision1/utils/dimensions.dart';
import 'package:zxvision1/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight=Dimensions.screenHeight/5.63; // here use text length to approximate the
  @override
  void initState() {
    super.initState();
    if (widget.text.length>textHeight) {
      firstHalf=widget.text.substring(0, textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1, widget.text.length);
    } else {
      firstHalf=widget.text;
      secondHalf="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty ? SmallText(text: firstHalf, size: Dimensions.font16, color: AppColors.paraColor, height: 1.5) : Column(
        children: [
          SmallText(text: hiddenText ? (firstHalf+"...") : (firstHalf+secondHalf), size: Dimensions.font16, color: AppColors.paraColor, height: 1.5,),
          InkWell(
            onTap: () {
              setState(() {
                hiddenText =! hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: hiddenText ? "Show more" : "Show less", color: AppColors.mainColor, size: Dimensions.font16),
                Icon(hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up, color: AppColors.mainColor,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
