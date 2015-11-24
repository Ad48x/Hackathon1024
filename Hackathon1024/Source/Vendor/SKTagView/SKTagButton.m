//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTagButton.h"
#import "SKTag.h"

@implementation SKTagButton

+ (instancetype)buttonWithTag:(SKTag *)tag
{
	SKTagButton *btn = [super buttonWithType:UIButtonTypeCustom];
	
	if (tag.attributedText) {
		[btn setAttributedTitle:tag.attributedText forState:UIControlStateNormal];
	} else {
		[btn setTitle:tag.text forState:UIControlStateNormal];
		[btn setTitleColor:tag.textColor forState:UIControlStateNormal];
		btn.titleLabel.font = tag.font ?: [UIFont systemFontOfSize:tag.fontSize];
	}
	
	btn.backgroundColor = tag.bgColor;
	btn.contentEdgeInsets = tag.padding;
	btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
	
    if (tag.bgImg)
    {
        [btn setBackgroundImage:tag.bgImg forState:UIControlStateNormal];
    }
    
    if (tag.borderColor)
    {
        btn.layer.borderColor = tag.borderColor.CGColor;
    }
    
    if (tag.borderWidth)
    {
        btn.layer.borderWidth = tag.borderWidth;
    }
    
    btn.userInteractionEnabled = tag.enable;
    
    btn.layer.cornerRadius = tag.cornerRadius;
    btn.layer.masksToBounds = YES;
    
    return btn;
}

- (void)setChecked:(BOOL)checked {
    _checked = checked;
    if (_checked) {
        self.layer.borderWidth = 2.0f;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
    } else {
        self.layer.borderWidth = 0.0f;
        self.layer.borderColor = [[UIColor clearColor] CGColor];
    }
}

@end
