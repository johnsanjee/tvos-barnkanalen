//
//  ViewController.m
//  Barnkanalen
//
//  Created by Johan Kanflo on 2015-12-28.
//  Copyright © 2015 Johan Kanflo. All rights reserved.
//

#import "ViewController.h"
@import AVKit;

// See http://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http


@interface ViewController ()
@property (nonatomic, retain) AVPlayerViewController *avPlayerViewcontroller;
@end

static AVPlayerViewController *gPVC;

// Attempt to resume playing after background/aTV sleep
void resume_playing(void)
{
  if (gPVC.player.rate == 0) {
    [gPVC.player play];
  }
}

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  UIView *view = self.view;
  
  // Get URL from http://www.svtplay.se/kanaler/barnkanalen?output=json
  NSURL *fileURL = [NSURL URLWithString:@"https://svt13-lh.akamaihd.net/i/svt13_0@77508/master.m3u8?__b__=563"];
  
  AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
  playerViewController.player = [AVPlayer playerWithURL:fileURL];
  self.avPlayerViewcontroller = playerViewController;
  [self resizePlayerToViewSize];
  [view addSubview:playerViewController.view];
  view.autoresizesSubviews = TRUE;

  [playerViewController.player play];
  gPVC = playerViewController; // Yes, this is a hack
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void) resizePlayerToViewSize
{
  CGRect frame = self.view.frame;
  NSLog(@"frame size %d, %d", (int)frame.size.width, (int)frame.size.height);
  self.avPlayerViewcontroller.view.frame = frame;
}

@end
