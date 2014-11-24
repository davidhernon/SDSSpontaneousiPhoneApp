//
//  AppDelegate.m
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/11/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "AppDelegate.h"
#import "SpontanouesLobbyController.h"
//#import "SCSoundCloud.h"
//#import "SCUI.h"


@implementation AppDelegate

// Method for initializing SoundCloud functionality.
// Question of where/when to call this, does it belong here?
// Can we call it before we actually need it?
// also what do I swap sample project out with?
/*+ (void) initialize
{
    [SCSoundCloud setClientID:@"YOUR_CLIENT_ID"
                       secret:@"YOUR_CLIENT_SECRET"
                  redirectURL:[NSURL URLWithString:@"sampleproject://oauth"]];
}*/

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

	
	[self registerForNotifications:application];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SpontanouesLobbyController *viewController = [[SpontanouesLobbyController alloc] initWithNibName:@"SpontanouesLobbyController" bundle:nil];
	self.navControl = [[UINavigationController alloc] initWithRootViewController:viewController];
	[self.navControl setNavigationBarHidden:YES animated:YES];
	[self.window makeKeyAndVisible];
	[self.window addSubview:self.navControl.view];
    self.window.rootViewController = self.navControl;

	[self GetIndex];
    return YES;
}


-(BOOL) GetIndex
{
	NSURLSession *defaultSession = [NSURLSession sharedSession];
	
	NSURL * url = [NSURL URLWithString:@"http://silentdiscosquad.com/appindex.html/"];
	NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url
												   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
													   if(error == nil)
													   {
														   self.event = [NSJSONSerialization JSONObjectWithData:data
																										 options:kNilOptions
																										   error:&error];
														   for(NSDictionary *item in self.event) {
															   NSLog (@"nsdic = %@", item);
														   }
														   self.returned = TRUE;
													   }
												   }];
	[dataTask resume];
	self.returned = FALSE;
	while(self.returned == FALSE){
		[NSThread sleepForTimeInterval:0.1f];
	}
	return TRUE;
}

-(NSData*) sendHTTPGet:(NSString*)URL
{
	NSURLSession *defaultSession = [NSURLSession sharedSession];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]
														   cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
													   timeoutInterval:10];
	
	[request setHTTPMethod: @"GET"];
	
	NSError *requestError;
	NSURLResponse *urlResponse = nil;
	
	
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
	return response;
}

+(NSData *)sendHTTPPost:(NSString*)urlString:(NSString*)jsonString
{
	NSData* responseData = nil;
	NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	responseData = [NSMutableData data] ;
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
	NSString *bodydata=[NSString stringWithFormat:@"data=%@",jsonString];
	
	[request setHTTPMethod:@"POST"];
	NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
	[request setHTTPBody:req];
	NSURLResponse* response;
	NSError* error = nil;
	responseData = [NSURLConnection sendSynchronousRequest:request     returningResponse:&response error:&error];
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSLog(@"the final output is:%@",responseString);
	
	return responseData;
}



//This method is called upon succesful push notification registration. It parses the device token for this device, and sets it
//in user defualts. Then it calls the DataUpdater (I made it) protocol that the login screen fulfills.
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
	//Format token as you need:
	token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
	token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
	token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
	
	[[NSUserDefaults standardUserDefaults] setObject:token forKey:@"apnsToken"]; //save token to resend it if request fails
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"apnsTokenSentSuccessfully"]; // set flag for request status
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	NSLog(@"Did Fail to Register for Remote Notifications");
	NSLog(@"%@, %@", error, error.localizedDescription);
}

-(void)registerForNotifications: (UIApplication *)application{
	//This is a hack to register for push notifications. registerUserNotificationSettings is the ios 8 way, and
	//registerForRemoteNotificationTypes is the ios 7 and lower way.
	if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
		NSLog(@"registered for notifications in the ios8 way");
		[application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
		[application registerForRemoteNotifications];
	} else {
		[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
		 (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
	}
}

- (void)sessionDidChangeState
{
	NSLog(@"Multipeer Connectivity state changed");
	// Ensure UI updates occur on the main queue.
	//dispatch_async(dispatch_get_main_queue(), ^{
	//	[self.tableView reloadData];
	//});
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	//Start looking for other apps
	if([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
	{
		NSLog(@"Multitasking Supported");
		__block UIBackgroundTaskIdentifier background_task;
		background_task = [application beginBackgroundTaskWithExpirationHandler:^ {
			//Clean up code. Tell the system that we are done.
			[application endBackgroundTask: background_task];
			background_task = UIBackgroundTaskInvalid;
		}];
		
		//To make the code block asynchronous
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			
			//### background task starts
			NSLog(@"Running in the background\n");
			_sessionController = [[SessionController alloc] init];
			self.sessionController.delegate = self;
			while(TRUE)
			{
				NSLog(@"Background time Remaining: %f",[[UIApplication sharedApplication] backgroundTimeRemaining]);
				[NSThread sleepForTimeInterval:1]; //wait for 1 sec
			}
			//#### background task ends
			//Clean up code. Tell the system that we are done.
			[application endBackgroundTask: background_task];
			background_task = UIBackgroundTaskInvalid;
		});
	}
	else
	{
		    NSLog(@"Multitasking Not Supported");
	}
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
