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


/*- (void)viewDidLoad
{
    [super viewDidLoad];
	MPMediaQuery *everything = [[MPMediaQuery alloc] init];
	NSArray *itemsFromGenericQuery = [everything items];
	self.songsList = [NSMutableArray arrayWithArray:itemsFromGenericQuery];
	//3
	[self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.songsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"MusicCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	self->song = [self.songsList objectAtIndex:indexPath.row];
	NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
	NSString *durationLabel = [song valueForProperty: MPMediaItemPropertyGenre];
	cell.textLabel.text = songTitle;
	cell.detailTextLabel.text = durationLabel;
	return cell;
}

#pragma mark - TableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	self->song = [self.songsList objectAtIndex:indexPath.row];
	[[self delegate] setTrack:self->song];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillDisappear:(BOOL) animated {
}


@end*/
