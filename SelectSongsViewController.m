//
//  SelectSongsViewController.m
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/11/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//
//
// To do:
//          - Add functionality to save song selected
//

#import "SelectSongsViewController.h"
#import "PlayerViewController.h"

@interface SelectSongsViewController ()

@property NSArray *songsFromMediaPlayer;
//@property UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SelectSongsViewController
//int secondsLeft;

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
    
    // Set up songs in table View and display it
    MPMediaQuery *mediaPlayer = [[MPMediaQuery alloc] init];
	NSArray *itemsFromMediaPlayer = [mediaPlayer items];
    self.songsFromMediaPlayer = [NSMutableArray arrayWithArray:itemsFromMediaPlayer];
    [self.tableView reloadData];
    
    //set up variables for label and counter
    seconds.text = @"15";
    sec = 15;
    
    //Call next view after 15 seconds
    [NSTimer scheduledTimerWithTimeInterval:15.0
                                    target:self
                                   selector:@selector(donePicking)
                                    userInfo:nil
                                    repeats:NO];
    
    //Timer to update seconds val on screen
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(updateSecondsLabel)
                                   userInfo:nil
                                    repeats:YES];
    
}

//Called whenever the one-second timer goes off
//Decrement our seconds count and set the string accordinly
 - (void)updateSecondsLabel
 {
     sec--;
     seconds.text = [NSString stringWithFormat:@"%d", sec];
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Go to next view, called when song selection timer goes off
-(IBAction)donePicking
{
    PlayerViewController *playerViewController = [[PlayerViewController alloc]initWithNibName:@"PlayerViewController" bundle:nil];
    [self presentViewController:playerViewController animated:YES completion:nil];
}

@end
