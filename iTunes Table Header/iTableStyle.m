//
//  iTableStyle.m
//  iTunes Table Header
//
//  Created by Jon Brown on 11/1/13.
//  Copyright (c) 2013 Jon Brown Designs. All rights reserved.
//

#import "iTableStyle.h"

@implementation iTableStyle

- (void)highlightSelectionInClipRect:(NSRect)theClipRect
{
    
    // this method is asking us to draw the hightlights for
    // all of the selected rows that are visible inside theClipRect
    
    // 1. get the range of row indexes that are currently visible
    // 2. get a list of selected rows
    // 3. iterate over the visible rows and if their index is selected
    // 4. draw our custom highlight in the rect of that row.
    
    NSRange aVisibleRowIndexes = [self rowsInRect:theClipRect];
    NSIndexSet* aSelectedRowIndexes = [self selectedRowIndexes];
    int aRow = aVisibleRowIndexes.location;
    int anEndRow = aRow + aVisibleRowIndexes.length;
    NSGradient* gradient;
    NSColor* pathColor;
    
    // if the view is focused, use highlight color, otherwise use the out-of-focus highlight color
    if (self == [[self window] firstResponder] && [[self window] isMainWindow] && [[self window] isKeyWindow])
    {
        
        gradient = [[[NSGradient alloc] initWithColorsAndLocations:
                     [NSColor colorWithDeviceRed:(float)128/255 green:(float)157/255 blue:(float)194/255 alpha:1.0], 0.0,
                     [NSColor colorWithDeviceRed:(float)128/255 green:(float)157/255 blue:(float)194/255 alpha:1.0], 1.0, nil] retain];
        
        pathColor = [[NSColor colorWithDeviceRed:(float)128/255 green:(float)157/255 blue:(float)194/255 alpha:1.0] retain];
        
    }
    else
    {
        
        gradient = [[[NSGradient alloc] initWithColorsAndLocations:
                     [NSColor colorWithDeviceRed:(float)186/255 green:(float)192/255 blue:(float)203/255 alpha:1.0], 0.0,
                     [NSColor colorWithDeviceRed:(float)186/255 green:(float)192/255 blue:(float)203/255 alpha:1.0], 1.0, nil] retain]; //160 80
        
        pathColor = [[NSColor colorWithDeviceRed:(float)186/255 green:(float)192/255 blue:(float)203/255 alpha:1.0] retain];
        
    }
    
    // draw highlight for the visible, selected rows
    
    for (aRow; aRow < anEndRow; aRow++) {
        
        if([aSelectedRowIndexes containsIndex:aRow])
        {
            NSRect aRowRect = NSInsetRect([self rectOfRow:aRow], 0, 0); //first is horizontal, second is vertical
            NSBezierPath * path = [NSBezierPath bezierPathWithRect:aRowRect]; //6.0
            
            [gradient drawInBezierPath:path angle:90];
            
        }
    }
    
}




- (id)_highlightColorForCell:(NSCell *)cell
{
    // we need to override this to return nil
    // or we'll see the default selection rectangle when the app is running
    // in any OS before leopard
    
    // you can also return a color if you simply want to change the table's default selection color
    return nil;
}


@end
