//
//  iHeaderStyle.m
//  iTunes Table Header
//
//  Created by Jon Brown on 11/1/13.
//  Copyright (c) 2013 Jon Brown Designs. All rights reserved.
//

#import "iHeaderStyle.h"

@implementation iHeaderStyle

- (id)initTextCell:(NSString *)text
{
    if (self = [super initTextCell:text]) {
        
        if (text == nil || [text isEqualToString:@""]) {
            [self setTitle:@"Title"];
        }
        
        attrs = [[NSMutableDictionary dictionaryWithDictionary:
                  [[self attributedStringValue]
                   attributesAtIndex:0
                   effectiveRange:NULL]]
                 mutableCopy];
        return self;
    }
    return nil;
}

- (void)drawWithFrame:(CGRect)cellFrame
          highlighted:(BOOL)isHighlighted
               inView:(NSView *)view
{
    
    CGRect fillRect, borderRect;
    CGRectDivide(cellFrame, &borderRect, &fillRect, 1.0, CGRectMaxYEdge);
    
    NSGradient *gradient = [[NSGradient alloc]
                            initWithStartingColor:[NSColor whiteColor]
                            endingColor:[NSColor colorWithDeviceWhite:0.9 alpha:1.0]];
    [gradient drawInRect:fillRect angle:90.0];
    [gradient release];
    
    
    if (isHighlighted) {
        [[NSColor colorWithDeviceWhite:0.0 alpha:0.1] set];
        NSRectFillUsingOperation(fillRect, NSCompositeSourceOver);
    }
    
    [[NSColor colorWithDeviceWhite:0.8 alpha:1.0] set];
    NSRectFill(borderRect);
    
    
    [self drawInteriorWithFrame:CGRectInset(fillRect, 0.0, 1.0) inView:view];
    
    
    // Draw the column divider.
    [[NSColor lightGrayColor] set];
    NSRect	_dividerRect = NSMakeRect(cellFrame.origin.x + cellFrame.size.width -1, 0, 1,cellFrame.size.height);
    NSRectFill(_dividerRect);
    
    
}


- (void)drawWithFrame:(CGRect)cellFrame inView:(NSView *)view
{
    [self drawWithFrame:cellFrame highlighted:NO inView:view];
}

- (void)highlight:(BOOL)isHighlighted
        withFrame:(NSRect)cellFrame
           inView:(NSView *)view
{
    [self drawWithFrame:cellFrame highlighted:isHighlighted inView:view];
}

@end
