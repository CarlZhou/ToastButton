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
    toastBtn = [ToastButton showToastTo:self.view animated:YES];
//    [toastBtn setToastImage:[[UIImage imageNamed:@"radiation.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:11]];
    [toastBtn setToastText:@"hiddsafasdfasdfasdfasdfasdfe"];
    [toastBtn setPositionMode:ToastButtonBottomPositionMode];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [customView setBackgroundColor:[UIColor redColor]];
    [toastBtn setCustomView:customView];
    
    [toastBtn setTarget:toastBtn Action:@selector(Hide)];
}


@end