//
//  ViewController.m
//  ToastButton
//
//  Created by Carl on 2013-04-05.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import "ViewController.h"
#import "ToastButton.h"

@interface ViewController ()

@end

@implementation ViewController
{
    ToastButton *toastBtn;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showToastButton:(id)sender
{
    toastBtn = [ToastButton showToastTo:self.view animated:YES hideAfter:1];
    [toastBtn setToastText:@"H"];
    [toastBtn Show];
}

- (IBAction)showWithImagePressed:(id)sender
{
    toastBtn = [ToastButton showToastTo:self.view animated:YES hideAfter:1];
    [toastBtn setToastImage:[[UIImage imageNamed:@"imageView.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25]];
    [toastBtn Show];
}

- (IBAction)showWithCustomViewPressed:(id)sender
{
    UIImageView *customView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [customView setImage:[[UIImage imageNamed:@"customView8bit.png"] stretchableImageWithLeftCapWidth:100 topCapHeight:100]];
    toastBtn = [ToastButton showToastTo:self.view animated:YES hideAfter:1];
    [toastBtn setCustomView:customView];
    [toastBtn Show];
}

- (IBAction)showWithTapAction:(id)sender
{
    toastBtn = [ToastButton showToastTo:self.view animated:YES];
    [toastBtn setToastText:@"Tap to hide"];
    [toastBtn setToastImage:[[UIImage imageNamed:@"imageView.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:25]];
    [toastBtn setPositionMode:ToastCenterPositionMode];
    [toastBtn setTarget:toastBtn Action:@selector(Hide)];
    [toastBtn Show];
}

- (IBAction)topPressed:(id)sender
{
    toastBtn = [ToastButton showToastTo:self.view animated:YES hideAfter:1];
    [toastBtn setToastText:@"Top Mode"];
    [toastBtn setPositionMode:ToastTopPositionMode];
    [toastBtn Show];
}

- (IBAction)bottomPressed:(id)sender
{
    toastBtn = [ToastButton showToastTo:self.view animated:YES hideAfter:1];
    [toastBtn setToastText:@"Bottom Mode"];
    [toastBtn setPositionMode:ToastBottomPositionMode];
    [toastBtn Show];
}


@end
