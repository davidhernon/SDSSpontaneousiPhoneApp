//
//  SelectSongsViewController.h
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/11/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SelectSongsViewController : UIViewController{
    int sec;
    __weak IBOutlet UILabel *seconds;
}
@property NSTimer* donePickingTimer;
@property NSTimer* updateSecondsTimer;
@property Boolean isSelectSongsViewController;
//select Song and go to next view
-(IBAction)donePicking;
-(void)updateSecondsLabel;



@end
