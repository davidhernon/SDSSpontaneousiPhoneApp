//
//  PlayerViewController.m
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/11/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "PlayerViewController.h"
#import "SelectSongsViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickMoreSongs
{
    SelectSongsViewController *selectSongsViewController = [[SelectSongsViewController alloc]initWithNibName:@"SelectSongsViewController" bundle:nil];
    //self.selectSongsViewController = selectSongsViewController;
    [self presentViewController:selectSongsViewController animated:YES completion:nil];
}

@end
