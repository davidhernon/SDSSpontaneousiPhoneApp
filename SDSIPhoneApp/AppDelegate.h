//
//  AppDelegate.h
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/11/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,NSURLSessionDelegate,NSURLSessionDownloadDelegate,NSURLSessionDataDelegate>
@property (nonatomic, retain) NSArray *event;
@property (strong, nonatomic) UIWindow *window;
@property BOOL returned;

@end
