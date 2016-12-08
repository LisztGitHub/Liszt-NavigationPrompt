//
//  LisztNavigationPrompt.h
//  LisztNavigationPrompotExmaple
//
//  Created by Liszt on 16/12/2.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LisztNavigationPromptType) {
    /*正确的提醒*/
    Prompt_Right,
    /*错误的提醒*/
    Prompt_Error,
    /*警告的提醒*/
    Prompt_Warning
};
typedef void(^LisztNavigationPromptCompleteBlock)(void);

@interface LisztNavigationPrompt : UIView
+ (instancetype)showPromptString:(NSString *)promptString promptType:(LisztNavigationPromptType)type;
+ (instancetype)showPromptString:(NSString *)promptString promptType:(LisztNavigationPromptType)type druation:(NSTimeInterval)druation;
+ (instancetype)showPromptString:(NSString *)promptString promptType:(LisztNavigationPromptType)type druation:(NSTimeInterval)druation complete:(LisztNavigationPromptCompleteBlock)promptCompleteBlock;

+ (void)dismiss;
@end
