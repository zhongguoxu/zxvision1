import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zxvision1/utils/colors.dart';
import 'package:zxvision1/utils/dimensions.dart';
import 'package:zxvision1/widgets/app_icon.dart';
import 'package:zxvision1/widgets/big_text.dart';
import 'package:zxvision1/widgets/expandable_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(15,),
              child: Container(
                child: Center(child: BigText(text: "Sliver App Bar", size: Dimensions.font26,)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/test3.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                    child: ExpandableTextWidget(text: "The main intuition consists in considering each target box a supplier of k positive label assignments and each predicted box a demander of either one positive label assignment or one background assignment. k is dynamic and depends on each target box. Then, transporting one positive label assignment from target box to predicted box has a cost based on classification and regression. Finally, the goal is to find a transportation plan (label assignment) that minimizes the total cost over the image. The main intuition consists in considering each target box a supplier of k positive label assignments and each predicted box a demander of either one positive label assignment or one background assignment. k is dynamic and depends on each target box. Then, transporting one positive label assignment from target box to predicted box has a cost based on classification and regression. Finally, the goal is to find a transportation plan (label assignment) that minimizes the total cost over the image.The main intuition consists in considering each target box a supplier of k positive label assignments and each predicted box a demander of either one positive label assignment or one background assignment. k is dynamic and depends on each target box. Then, transporting one positive label assignment from target box to predicted box has a cost based on classification and regression. Finally, the goal is to find a transportation plan (label assignment) that minimizes the total cost over the image. The main intuition consists in considering each target box a supplier of k positive label assignments and each predicted box a demander of either one positive label assignment or one background assignment. k is dynamic and depends on each target box. Then, transporting one positive label assignment from target box to predicted box has a cost based on classification and regression. Finally, the goal is to find a transportation plan (label assignment) that minimizes the total cost over the image.The main intuition consists in considering each target box a supplier of k positive label assignments and each predicted box a demander of either one positive label assignment or one background assignment. k is dynamic and depends on each target box. Then, transporting one positive label assignment from target box to predicted box has a cost based on classification and regression. Finally, the goal is to find a transportation plan (label assignment) that minimizes the total cost over the image. The main intuition consists in considering each target box a supplier of k positive label assignments and each predicted box a demander of either one positive label assignment or one background assignment. k is dynamic and depends on each target box. Then, transporting one positive label assignment from target box to predicted box has a cost based on classification and regression. Finally, the goal is to find a transportation plan (label assignment) that minimizes the total cost over the image.The main intuition consists in considering each target box a supplier of k positive label assignments and each predicted box a demander of either one positive label assignment or one background assignment. k is dynamic and depends on each target box. Then, transporting one positive label assignment from target box to predicted box has a cost based on classification and regression. Finally, the goal is to find a transportation plan (label assignment) that minimizes the total cost over the image. The main intuition consists in considering each target box a supplier of k positive label assignments and each predicted box a demander of either one positive label assignment or one background assignment. k is dynamic and depends on each target box. Then, transporting one positive label assignment from target box to predicted box has a cost based on classification and regression. Finally, the goal is to find a transportation plan (label assignment) that minimizes the total cost over the image.The main intuition consists in considering each target box a supplier of k positive label assignments and each predicted box a demander of either one positive label assignment or one background assignment. k is dynamic and depends on each target box. Then, transporting one positive label assignment from target box to predicted box has a cost based on classification and regression. Finally, the goal is to find a transportation plan (label assignment) that minimizes the total cost over the image. The main intuition consists in considering each target box a supplier of k positive label assignments and each predicted box a demander of either one positive label assignment or one background assignment. k is dynamic and depends on each target box. Then, transporting one positive label assignment from target box to predicted box has a cost based on classification and regression. Finally, the goal is to find a transportation plan (label assignment) that minimizes the total cost over the image.The main intuition consists in considering each target box a supplier of k positive label assignments and each predicted box a demander of either one positive label assignment or one background assignment. k is dynamic and depends on each target box. Then, transporting one positive label assignment from target box to predicted box has a cost based on classification and regression. Finally, the goal is to find a transportation plan (label assignment) that minimizes the total cost over the image. The main intuition consists in considering each target box a supplier of k positive label assignments and each predicted box a demander of either one positive label assignment or one background assignment. k is dynamic and depends on each target box. Then, transporting one positive label assignment from target box to predicted box has a cost based on classification and regression. Finally, the goal is to find a transportation plan (label assignment) that minimizes the total cost over the image.",),
                  )
                ],
              ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: Dimensions.width20*2.5,
            right: Dimensions.width20*2.5,
            top: Dimensions.height10,
            bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.remove, backgroundColor: AppColors.mainColor, iconColor: Colors.white, iconSize: Dimensions.iconSize24,),
                BigText(text: "\$12.88 " + " * " + " 0", color: AppColors.mainBlackColor, size: Dimensions.font26,),
                AppIcon(icon: Icons.add, backgroundColor: AppColors.mainColor, iconColor: Colors.white, iconSize: Dimensions.iconSize24)
              ],
            ),
          ),
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.favorite, color: AppColors.mainColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  child: BigText(text: "\$10 | Add to cart", color: Colors.white,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
