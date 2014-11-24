//
//  PlayerViewController.h
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/11/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerView.h"
@interface PlayerViewController : UIViewController
+ (PlayerViewController*) sharedPlayerViewController;
-(void)hideNavBar;
@end
