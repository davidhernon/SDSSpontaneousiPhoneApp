//
//  LoginViewController.m
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/11/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.nextScreenButton.layer.cornerRadius = 10;
}

- (IBAction)testNotification {
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"apnsTokenSentSuccessfully"]) {
		NSLog(@"apnsTokenSentSuccessfully already");
		return;
	}
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://54.186.255.157/ios-notifications/device/"]];
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
	[urlRequest setHTTPMethod:@"POST"];
	NSString *postString = [NSString stringWithFormat:@"token=%@&service=%d", [[NSUserDefaults standardUserDefaults] objectForKey:@"apnsToken"],1];
	[urlRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	
	
	[NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
	 {
		 if (error == nil) {
			 [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"apnsTokenSentSuccessfully"];
			 NSLog(@"Token is being sent successfully");
			 
			 //you can check server response here if you need
			 NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
			 int responseStatusCode = [httpResponse statusCode];
			 if(responseStatusCode == 201){
				 NSLog(@"Device succesfully created");
			 }
			 else if(responseStatusCode == 200){
				 NSLog(@"Device already exists");
			 }
		 }
	 }];
	
	NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://54.186.255.157/sendTestNotification/?token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"apnsToken"]]]; //set here your URL
	
	NSURLRequest *urlRequest2 = [NSURLRequest requestWithURL:url2];
	NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
	
	[NSURLConnection sendAsynchronousRequest:urlRequest2 queue:queue2 completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
	 {
		 if (error == nil) {
			 [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"apnsTokenSentSuccessfully"];
			 NSLog(@"Token is being sent successfully");
		 }
	 }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker
   didPickMediaItems: (MPMediaItemCollection *) collection {
	[[Playlist sharedPlaylist] addMediaCollection:collection];
	PlaylistViewController *playlistViewController = [[PlaylistViewController alloc]initWithNibName:@"PlaylistViewController" bundle:nil];
	[self.navigationController pushViewController:playlistViewController animated:YES];
}

- (IBAction)nextScreen
{
	//if there's nothing in the media library, just skip to the player
	MPMediaQuery *everything = [MPMediaQuery songsQuery];
	if (everything.items == nil || [everything.items count] == 0){
		PlaylistViewController *playlistViewController = [[PlaylistViewController alloc]initWithNibName:@"PlaylistViewController" bundle:nil];
		[self.navigationController pushViewController:playlistViewController animated:YES];
	}
	
	//else, show a picker so they can give us songs
	MPMediaPickerController* picker = [[MPMediaPickerController alloc]initWithMediaTypes: MPMediaTypeAnyAudio];
	[picker setDelegate: self];                                         // 2
	[picker setAllowsPickingMultipleItems: YES];                        // 3
	picker.prompt =
	NSLocalizedString (@"Add songs to play",
					   "Prompt in media item picker");
	[self.navigationController pushViewController:picker animated: YES];    // 4
}

@end
