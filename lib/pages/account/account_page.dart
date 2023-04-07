import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zxvision1/utils/colors.dart';
import 'package:zxvision1/utils/dimensions.dart';
import 'package:zxvision1/widgets/account_widget.dart';
import 'package:zxvision1/widgets/app_icon.dart';
import 'package:zxvision1/widgets/big_text.dart';

class Accountpage extends StatelessWidget {
  const Accountpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Profile", size: 24, color: Colors.white,),
        centerTitle: true,
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            AppIcon(icon: Icons.person, backgroundColor: AppColors.mainColor,iconColor: Colors.white, iconSize: Dimensions.height15*5, size: Dimensions.height15*10,),
            SizedBox(height: Dimensions.height30,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //name
                    AccountWidget(
                      appIcon: AppIcon(icon: Icons.person, backgroundColor: AppColors.mainColor,iconColor: Colors.white, iconSize: Dimensions.height10*2.5, size: Dimensions.height10*5,),
                      bigText: BigText(text: "Zhongguo"),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    //phone
                    AccountWidget(
                      appIcon: AppIcon(icon: Icons.phone, backgroundColor: AppColors.yellowColor,iconColor: Colors.white, iconSize: Dimensions.height10*2.5, size: Dimensions.height10*5,),
                      bigText: BigText(text: "1-7806910537"),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    //email
                    AccountWidget(
                      appIcon: AppIcon(icon: Icons.email, backgroundColor: AppColors.yellowColor,iconColor: Colors.white, iconSize: Dimensions.height10*2.5, size: Dimensions.height10*5,),
                      bigText: BigText(text: "zhongguo@ualberta.ca"),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    //address
                    AccountWidget(
                      appIcon: AppIcon(icon: Icons.location_on, backgroundColor: AppColors.yellowColor,iconColor: Colors.white, iconSize: Dimensions.height10*2.5, size: Dimensions.height10*5,),
                      bigText: BigText(text: "2733 Kirkland way"),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    //message
                    AccountWidget(
                      appIcon: AppIcon(icon: Icons.message_outlined, backgroundColor: AppColors.yellowColor,iconColor: Colors.white, iconSize: Dimensions.height10*2.5, size: Dimensions.height10*5,),
                      bigText: BigText(text: "Zhongguo"),
                    ),
                    SizedBox(height: Dimensions.height20,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
