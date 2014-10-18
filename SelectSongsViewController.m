//
//  SelectSongsViewController.m
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/11/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
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
    // Do any additional setup after loading the view from its nib.
    MPMediaQuery *mediaPlayer = [[MPMediaQuery alloc] init];
	NSArray *itemsFromQuery = [mediaPlayer items];
    self.songsFromMediaPlayer = [NSMutableArray arrayWithArray:itemsFromQuery];
    [self.tableView reloadData];
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
     
 - (void)updateSecondsLabel
 {
     sec--;
     seconds.text = [NSString stringWithFormat:@"%d", sec];
 }

- (void)timerFireMethod:(NSTimer *)timer
{
    [self donePicking];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Go to next view
-(IBAction)donePicking
{
    PlayerViewController *playerViewController = [[PlayerViewController alloc]initWithNibName:@"PlayerViewController" bundle:nil];
    [self presentViewController:playerViewController animated:YES completion:nil];
}

@end
