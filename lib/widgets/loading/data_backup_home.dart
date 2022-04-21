import '../../commons.dart';
import 'package:flutter/services.dart';


import 'data_backup_cloud_page.dart';
import 'data_backup_completed_page.dart';
import 'data_backup_initial_page.dart';


class DataBackupHome extends StatefulWidget {
  
  const DataBackupHome({Key? key}) : super(key: key);

  static const routeName = './data_backup_home';


  @override
  State<DataBackupHome> createState() => _DataBackupHomeState();
}

class _DataBackupHomeState extends State<DataBackupHome> with SingleTickerProviderStateMixin  {

  AnimationController? _animationController;
  Animation<double>? _progressAnimation;
  Animation<double>? _cloudOutAnimation;
  Animation<double>? _endingAnimation;
  Animation<double>? _bubblesAnimation;

  @override
  void initState() {

     SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    
    _animationController = AnimationController(
      vsync: this, 
      duration: const Duration(
        seconds: 7,
      ) 
    );
    _progressAnimation = CurvedAnimation(
      parent: _animationController!, 
      curve: const Interval(
        0.0, 
        0.65
      ),
    );
     _cloudOutAnimation = CurvedAnimation(
      parent: _animationController!, 
      curve: const Interval(
        0.7, 
        0.85,
        curve: Curves.easeOut,
      ),
    );
    _bubblesAnimation = CurvedAnimation(
      parent: _animationController!, 
      curve: const Interval(
        0.0, 
        1.0,
        curve: Curves.decelerate,
      ),
    );
     _endingAnimation = CurvedAnimation(
      parent: _animationController!, 
      curve: const Interval(
        0.8, 
        1.0,
        curve: Curves.decelerate,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          DataBackupInitialPage(
            progressAnimation: _progressAnimation,
            onAnimationStarted: () {
              _animationController!.forward();
            },
          ),
          DataBackupCloudPage(
            progressAnimation: _progressAnimation,
            cloudOutAnimation: _cloudOutAnimation,
            bubblesAnimation: _bubblesAnimation
          ),
          DataBackupCompletedPage(
            endingAnimation: _endingAnimation
          )

        ],
      ),
    );
  }
}