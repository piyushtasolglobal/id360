import 'dart:async';
import 'package:flutter/material.dart';
import 'package:id_360/others/constants.dart';
import 'package:id_360/screens/institutionsearchscreen.dart';
import 'package:id_360/screens/loginregisterscreen.dart';
import 'package:id_360/screens/registercompany.dart';
import 'package:id_360/screens/registerselfid.dart';

class RegisterOptionsScreen extends StatefulWidget {
  @override
  _RegisterOptionsScreenState createState() => _RegisterOptionsScreenState();
}

class _RegisterOptionsScreenState extends State<RegisterOptionsScreen>
    with TickerProviderStateMixin {
  /*AnimationController _controller;
  Animation<double> _animation;*/

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height,widthorig,widthone;
    double space=20.0;
    MediaQueryData mediaQueryData=MediaQuery.of(context);
    widthorig=mediaQueryData.size.width;
    widthone=(widthorig-(3*space))/2;
    height=widthone;

    return Scaffold(
      backgroundColor: AppColors.bg_reg,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0,
        bottomOpacity: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          AppConstants.txt_register,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          /*decoration: BoxDecoration(
            color: AppColors.bg_reg
          ),*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                AppConstants.txt_selcat,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                      width: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RegisterCompanyScreen()));
                    },
                    child: Container(
                      height: height,
                      width: widthone,
                      decoration: BoxDecoration(
                          color: AppColors.bg_reg_options,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              height: widthone/3,
                              width: widthone/3,
                              image: AssetImage(AppImages.imgreg2),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              AppConstants.txt_insti,
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RegisterSelfIdScreen()));
                    },
                    child: Container(
                      height: height,
                      width: widthone,
                      decoration: BoxDecoration(
                          color: AppColors.bg_reg_options,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              height: widthone/3,
                              width: widthone/3,
                              image: AssetImage(AppImages.imgreg1),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              AppConstants.txt_selfid,
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppConstants.txt_already_inst,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InstitutionSearchScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Container(
                    padding: EdgeInsets.only(top: 45,bottom: 45),
                    width: widthorig,
                    decoration: BoxDecoration(
                        color: AppColors.bg_reg_options,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(
                      child: Text(
                          AppConstants.txt_instiid,
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}



