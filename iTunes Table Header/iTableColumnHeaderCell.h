//
//  iTableColumnHeaderCell.h
//  iTableColumnHeader
//
//  Created by Matt Gemmell on Thu Feb 05 2004. 
//
//

#import <Cocoa/Cocoa.h>


@interface iTableColumnHeaderCell : NSTableHeaderCell {

    BOOL _ascending;
    NSInteger _priority;
}

- (id)initWithCell:(NSTableHeaderCell*)cell;
- (void)setSortAscending:(BOOL)ascending priority:(NSInteger)priority;

+ (void)drawBackgroundInRect:(NSRect)rect hilighted:(BOOL)hilighted;

@end
