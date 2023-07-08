import 'package:flutter/material.dart';
import 'package:matgar/modules/login/login_screen.dart';
import 'package:matgar/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/styles/colors.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image,required this.title,required this.body});
}
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController=PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image:'assets/images/Order.jpg',
        title:'Order',
        body:'Easy Making Orders '
    ),
    BoardingModel(
        image:'assets/images/Pay.jpg',
        title:'Payment',
        body:'All Ways of Payment is Available'
    ),
    BoardingModel(
        image:'assets/images/Delivery.jpg',
        title:'Delivery ',
        body:'Flash Delivery'
    ),
  ];
  bool isLast= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: (){
                submitOnBoarding(context);
                navigateAndFinish(context,  ShopLoginScreen());
              },
              text: 'SKIP',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index==boarding.length-1){
                  setState(() {
                    isLast=true;
                  }
                  );
                  print('last');
                  }
                  else{
                    setState(() {
                      isLast = false;
                    });
                    print('not last');
                  }
                },
                controller: boardingController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children:  [
                const SizedBox(
                  width: 20,
                ),
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: defaultColor,
                    dotHeight: 11,
                    dotWidth: 11,
                    spacing: 5,
                    expansionFactor: 4
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submitOnBoarding(context);
                      navigateAndFinish(context, ShopLoginScreen());
                    }else {
                      boardingController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                    },
                  child: const Icon(
                    Icons.arrow_forward
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      )
    );
  }
}

Widget buildOnBoardingItem(BoardingModel model)=> Column(
crossAxisAlignment: CrossAxisAlignment.center,
children:  [
Expanded(
  child:Image(
    image: AssetImage(model.image),
  ),
),
const SizedBox(
height: 10
),
Text(
model.title,
style: const TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold
),
),
const SizedBox(
height: 20
),
Text(
model.body,
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 16,
),
),
],
);