//
//  LisztNavigationPrompt.m
//  LisztNavigationPrompotExmaple
//
//  Created by Liszt on 16/12/2.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "LisztNavigationPrompt.h"
#import <POP.h>

static LisztNavigationPrompt *prompt = nil;
static dispatch_once_t onceToken;
@interface LisztNavigationPrompt()
/*提醒View*/
@property (strong, nonatomic) UIView *promptView;
/*label*/
@property (strong, nonatomic) UILabel *promptLabel;
/*icon*/
@property (strong, nonatomic) UIImageView *iconImageView;
/*提示标题*/
@property (strong, nonatomic) NSString *promptText;
/*提醒类型*/
@property (assign, nonatomic) LisztNavigationPromptType promptType;
@end

@implementation LisztNavigationPrompt
+ (instancetype)shareNavigationPrompt{
    dispatch_once(&onceToken, ^{
        prompt = [[self alloc]initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.bounds.size.width,  [UIApplication sharedApplication].keyWindow.bounds.size.height)];
    });
    return prompt;
}
+ (instancetype)showPromptString:(NSString *)promptString promptType:(LisztNavigationPromptType)type{
    return [self showPromptString:promptString promptType:type druation:1.0f];
}
+ (instancetype)showPromptString:(NSString *)promptString promptType:(LisztNavigationPromptType)type druation:(NSTimeInterval)druation{
    return [self showPromptString:promptString promptType:type druation:druation complete:nil];
}
+ (instancetype)showPromptString:(NSString *)promptString promptType:(LisztNavigationPromptType)type druation:(NSTimeInterval)druation complete:(LisztNavigationPromptCompleteBlock)promptCompleteBlock{
    LisztNavigationPrompt *navPrompt = [LisztNavigationPrompt shareNavigationPrompt];
    navPrompt.promptText = promptString;
    navPrompt.promptType = type;
    [navPrompt showNavPrompt];
    if(druation>0.0){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(druation * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LisztNavigationPrompt dismiss];
        });
    }
    return navPrompt;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.promptView];
    }
    return self;
}

- (void)showNavPrompt{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    self.promptView.transform = CGAffineTransformMakeTranslation(0, -64);
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:8 options:UIViewAnimationOptionCurveLinear animations:^{
        self.promptView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
    
}
+ (void)dismiss{
    [LisztNavigationPrompt shareNavigationPrompt].promptView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.3f animations:^{
        [LisztNavigationPrompt shareNavigationPrompt].promptView.transform = CGAffineTransformMakeTranslation(0, -64);
    } completion:^(BOOL finished) {
        [[self shareNavigationPrompt] removeFromSuperview];
        prompt = nil;
        onceToken = 0;
    }];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.promptLabel.text = self.promptText;
    if(self.promptType == Prompt_Right){
        self.iconImageView.image = [UIImage imageNamed:@"lisztNavigationprompt_right_icon"];
    }
    else if (self.promptType == Prompt_Error)
    {
        self.iconImageView.image = [UIImage imageNamed:@"lisztNavigationprompt_right_icon"];
    }
    else if (self.promptType == Prompt_Warning){
        self.iconImageView.image = [UIImage imageNamed:@"lisztNavigationprompt_waring_icon"];
    }
}
#pragma mark - 懒加载
- (UIView *)promptView{
    if(!_promptView){
        _promptView = [[UIView alloc]initWithFrame:CGRectMake(2.5, 0, [UIApplication sharedApplication].keyWindow.bounds.size.width-5, 64)];
        _promptView.backgroundColor = [UIColor redColor];
        _promptView.layer.cornerRadius = 10;
        _promptView.clipsToBounds = YES;
        
        /*1.图片*/
        [_promptView addSubview:self.iconImageView];
        
        /*2.标题*/
        [_promptView addSubview:self.promptLabel];
    }
    return _promptView;
}
- (UILabel *)promptLabel{
    if(!_promptLabel){
        _promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(45 + 10, 0, self.promptView.frame.size.width - 30, self.promptView.frame.size.height)];
        _promptLabel.text = self.promptText;
        _promptLabel.font = [UIFont systemFontOfSize:16.f];
        _promptLabel.numberOfLines = 0;
        _promptLabel.textColor = [UIColor whiteColor];
    }
    return _promptLabel;
}
- (UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (self.promptView.frame.size.height - 45)/2, 45, 45)];
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    return _iconImageView;
}

@end
