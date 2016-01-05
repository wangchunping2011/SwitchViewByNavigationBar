//
//  UIView+ModifyAttributeValue.m
//  ScrollNavigationBar
//
//  Created by 王春平 on 16/1/4.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "UIView+ModifyAttributeValue.h"

@implementation UIView (ModifyAttributeValue)

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

@end
