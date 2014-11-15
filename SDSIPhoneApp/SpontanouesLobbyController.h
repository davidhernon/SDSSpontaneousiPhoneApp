//
//  LoginViewController.h
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/11/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaylistViewController.h"
#import "LoginViewController.h"
@interface SpontanouesLobbyController : UIViewController<MPMediaPickerControllerDelegate>
-(IBAction)nextScreen;
-(IBAction)testNotification:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIButton *nextScreenButton;
- (IBAction)testLogin:(id)sender;
@property PlaylistViewController *playlistViewController;
@property LoginViewController *loginViewController;
@end
