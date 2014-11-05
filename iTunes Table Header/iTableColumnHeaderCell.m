//
//  iTableColumnHeaderCell.m
//  iTableColumnHeader
//
//  Created by Matt Gemmell on Thu Feb 05 2004.
//  <http://iratescotsman.com/>
//

#import "iTableColumnHeaderCell.h"

@implementation iTableColumnHeaderCell

#define TRIANGLE_WIDTH	6
#define TRIANGLE_HEIGHT	5
#define MARGIN_X		8
#define MARGIN_Y		8
#define LINE_MARGIN_Y	2

- (id)initWithCell:(NSTableHeaderCell*)cell
{
    self = [super initTextCell:[cell stringValue]];
    if (self) {
        NSMutableAttributedString* attributedString =
        [[NSMutableAttributedString alloc] initWithAttributedString:
          [cell attributedStringValue]];
        [attributedString addAttributes:
         [NSDictionary dictionaryWithObject:[NSColor blackColor]
                                     forKey:NSForegroundColorAttributeName]
                                  range:NSMakeRange(0, [attributedString length])];
        [self setAttributedStringValue: attributedString];
        
        _ascending = YES;
        _priority = 1;
    }
    return self;
    
}

- (id)initTextCell:(NSString *)text
{
    
    
    if (self = [super initTextCell:text]) {
        
        if (text == nil || [text isEqualToString:@""]) {
            [self setTitle:@"Title"];
        }
        
        return self;
    }
    return nil;
}

- (NSRect)titleRectForBounds:(NSRect)theRect {
    NSRect titleFrame = [super titleRectForBounds:theRect];
    NSSize titleSize = [[self attributedStringValue] size];
    titleFrame.origin.y = theRect.origin.y + (theRect.size.height - titleSize.height) / 2.0;
    return titleFrame;
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)view {
    
    NSRect titleRect = [self titleRectForBounds:cellFrame];
    [[self attributedStringValue] drawInRect:titleRect];
    
    
}

- (id)copyWithZone:(NSZone *)zone
{
    id newCopy = [super copyWithZone:zone];
    return newCopy;
}

+ (void)drawBackgroundInRect:(NSRect)rect hilighted:(BOOL)hilighted
{
    CGFloat delta = hilighted ? -0.1 : 0;
    NSGradient *gradient = [[NSGradient alloc]
                            initWithStartingColor:[NSColor colorWithDeviceRed:(float)255/255 green:(float)255/255 blue:(float)255/255 alpha:1.0]
                            endingColor:[NSColor colorWithDeviceRed:(float)255/255 green:(float)255/255 blue:(float)255/255 alpha:1.0]];
    [gradient drawInRect:rect angle:90.0];
    
    NSGraphicsContext* gc = [NSGraphicsContext currentContext];
    [gc saveGraphicsState];
    [gc setShouldAntialias:NO];
    
    NSBezierPath* path = [NSBezierPath bezierPath];
    [path setLineWidth:1.0];
    NSPoint p = NSMakePoint(rect.origin.x, rect.origin.y+2.0);
    [path moveToPoint:p];
    
    p.y += rect.size.height-2.0;
    [path lineToPoint:p];
    p.x += rect.size.width;
    [path lineToPoint:p];
    
    p = NSMakePoint(rect.origin.x, rect.origin.y+1.0);
    [path moveToPoint:p];
    p.x += rect.size.width;
    [path lineToPoint:p];
    
    [[NSColor colorWithDeviceWhite:0.0 alpha:0.2] set];
    [path stroke];
    
    [gc restoreGraphicsState];
    
    
}

- (void)_drawInRect:(NSRect)rect hilighted:(BOOL)hilighted
{
    [iTableColumnHeaderCell drawBackgroundInRect:rect hilighted:hilighted];
    
    NSRect stringFrame = rect;
    if (_priority == 0) {
        stringFrame.size.width -= TRIANGLE_WIDTH;
    }
    stringFrame.origin.y += LINE_MARGIN_Y;
    [[self attributedStringValue] drawInRect:stringFrame];
}


#pragma mark -
#pragma mark Overridden methods (NSCell)
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    CGRect fillRect, borderRect;
    CGRectDivide(cellFrame, &borderRect, &fillRect, 1.0, CGRectMaxYEdge);
    
    NSGradient *gradient = [[NSGradient alloc]
                            initWithStartingColor:[NSColor colorWithDeviceRed:(float)255/255 green:(float)255/255 blue:(float)255/255 alpha:1.0]
                            endingColor:[NSColor colorWithDeviceRed:(float)255/255 green:(float)255/255 blue:(float)255/255 alpha:1.0]];
    [gradient drawInRect:fillRect angle:90.0];
    
    
    if (NSOnState == [self state]) {
        [[NSColor colorWithDeviceRed:(float)240/255 green:(float)240/255 blue:(float)240/255 alpha:1.0] set];
        NSRectFillUsingOperation(fillRect, NSCompositeSourceOver);
    }
    
   
    [[NSColor colorWithDeviceRed:(float)240/255 green:(float)240/255 blue:(float)240/255 alpha:1.0] set];
    NSRectFill(borderRect);
    
    
    // Draw the column divider.
    [[NSColor colorWithDeviceRed:(float)226/255 green:(float)226/255 blue:(float)226/255 alpha:1.0] set];
    NSRect	_dividerRect = NSMakeRect(cellFrame.origin.x + cellFrame.size.width - 1, 3, 1,(cellFrame.size.height - 7));
    NSRectFill(_dividerRect);
    
    [self drawInteriorWithFrame:CGRectInset(fillRect, 0.0, 1.0) inView:controlView];
    
    [self drawSortIndicatorWithFrame:cellFrame
                              inView:controlView
                           ascending:_ascending
                            priority:_priority];
}

- (void)highlight:(BOOL)flag withFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    [self _drawInRect:cellFrame hilighted:YES];
    [self drawSortIndicatorWithFrame:cellFrame
                              inView:controlView
                           ascending:_ascending
                            priority:_priority];
}


- (void)drawSortIndicatorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView ascending:(BOOL)ascending priority:(NSInteger)priority
{
    NSBezierPath* path = [NSBezierPath bezierPath];
    
    if (ascending) {
        NSPoint p = NSMakePoint(cellFrame.origin.x + cellFrame.size.width - TRIANGLE_WIDTH - MARGIN_X,
                                cellFrame.origin.y + cellFrame.size.height - MARGIN_Y);
        [path moveToPoint:p];
        
        
        p.x += TRIANGLE_WIDTH/2.0;
        p.y -= TRIANGLE_HEIGHT;
        [path lineToPoint:p];
        
        p.x += TRIANGLE_WIDTH/2.0;
        p.y += TRIANGLE_HEIGHT;
        [path lineToPoint:p];
        
    } else {
        NSPoint p = NSMakePoint(cellFrame.origin.x + cellFrame.size.width - TRIANGLE_WIDTH - MARGIN_X,
                                cellFrame.origin.y + MARGIN_Y);
        [path moveToPoint:p];
        
        
        p.x += TRIANGLE_WIDTH/2.0;
        p.y += TRIANGLE_HEIGHT;
        [path lineToPoint:p];
        
        p.x += TRIANGLE_WIDTH/2.0;
        p.y -= TRIANGLE_HEIGHT;
        [path lineToPoint:p];
        
    }
    
    [path closePath];
    
    if (_priority == 0) {
        [[NSColor colorWithCalibratedRed:0.828 green:0.828 blue:0.828 alpha:1.0f] set];
    } else {
        [[NSColor clearColor] set];
    }
    [path fill];
}

- (void)setSortAscending:(BOOL)ascending priority:(NSInteger)priority
{
    _ascending = ascending;
    _priority = priority;
}

@end
