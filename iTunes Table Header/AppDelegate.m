//
//  AppDelegate.m
//  iTunes Table Header
//
//  Created by Jon Brown on 11/1/13.
//  Copyright (c) 2013 Jon Brown Designs. All rights reserved.
//

#import "AppDelegate.h"
//#import "iHeaderStyle.h"
#import "iTableColumnHeaderCell.h"
#import "iArrayController.h"

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

-(void)awakeFromNib
{
    /* set preference defaults */
    [[NSUserDefaults standardUserDefaults] registerDefaults:
     [NSDictionary dictionaryWithObject: [NSNumber numberWithBool: YES]
                                 forKey: @"NSDisabledCharacterPaletteMenuItem"]];
   
    NSArray *columns = [tableView tableColumns];
    NSEnumerator *cols = [columns objectEnumerator];
    NSTableColumn *col = nil;
    
    NSRect frame_head = tableView.headerView.frame;
    frame_head.size.height = 20;
    tableView.headerView.frame = frame_head;
}

#pragma mark -
#pragma mark NSTableViewDelegate
- (void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn
{
    iTableColumnHeaderCell* cell = nil;
    BOOL ascending;
    NSInteger priority;
    
    for (NSTableColumn* column in [tableView_ tableColumns]) {
        
        cell  = (iTableColumnHeaderCell*)[column headerCell];
        
        if (column == tableColumn) {
            ascending = [[[arrayController_ sortDescriptors] objectAtIndex:0] ascending];
            priority = 0;
        } else {
            priority = 1;
        }
        
        [cell setSortAscending:ascending priority:priority];
    }
}



@end
