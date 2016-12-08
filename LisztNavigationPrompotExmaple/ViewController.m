//
//  ViewController.m
//  LisztNavigationPrompotExmaple
//
//  Created by Liszt on 16/12/2.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "ViewController.h"
#import "LisztNavigationPrompt.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)buttonAction:(UIButton *)sender {
    [LisztNavigationPrompt showPromptString:@"我去你妈的" promptType:Prompt_Warning druation:2.0f];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
