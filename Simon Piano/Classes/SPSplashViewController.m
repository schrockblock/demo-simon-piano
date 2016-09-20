//
//  ViewController.m
//  Simon Piano
//
//  Created by Elliot Schrock on 9/13/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import "SPSplashViewController.h"
#import "SPPianoViewController.h"
#import "SPGetSongsCall.h"
#import "SPSong.h"

@interface SPSplashViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *songTableView;
@property (nonatomic, strong) NSArray *songs;
@property (nonatomic, strong) SPSong *selectedSong;

@end

@implementation SPSplashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.songTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [[[SPGetSongsCall alloc] init] fetchSongsWithCompletionBlock:^(NSArray *songs, NSError *error) {
        self.songs = songs;
        self.songTableView.dataSource = self;
        self.songTableView.delegate = self;
        [self.songTableView reloadData];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showKeyboard"]) {
        ((SPPianoViewController *)segue.destinationViewController).song = self.selectedSong;
    }
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPSong *song = self.songs[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = song.songDescription;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedSong = self.songs[indexPath.row];
    [self performSegueWithIdentifier:@"showKeyboard" sender:self];
}

@end
