//
//  TabController.m
//  LightIsAwesome
//
//  Created by Kenneth Siu on 12/2/14.
//  Copyright (c) 2014 Kenneth Siu. All rights reserved.
//

#import "TabController.h"
#import "ViewController.h"
#import "AppDelegate.h"
@interface TabController ()

@end

@implementation TabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.tag==2) {
        ViewController *vc= [self.viewControllers objectAtIndex:0];
        [vc.colorWheel setHidden:YES];
       // ViewController *pc=[self.viewControllers objectAtIndex:1]; [pc.colorWheel setHidden:YES];
        
    }
    else if (item.tag == 1){
        ViewController *vc= [self.viewControllers objectAtIndex:0];
        [vc.colorWheel setHidden:NO];
    }
    self.selectedViewController = [self.viewControllers objectAtIndex:0];
    
    //TODO: Insert code here
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
