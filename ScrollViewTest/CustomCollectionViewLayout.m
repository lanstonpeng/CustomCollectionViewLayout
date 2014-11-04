//
//  CustomCollectionViewLayout.m
//  ScrollViewTest
//
//  Created by Lanston Peng on 11/4/14.
//  Copyright (c) 2014 Vtm. All rights reserved.
//

#import "CustomCollectionViewLayout.h"
#import "MainDataSource.h"

#define CellPadding 20
#define CellWidth 130

@interface CustomCollectionViewLayout()

@property (strong,nonatomic)MainDataSource* dataSource;

@end

@implementation CustomCollectionViewLayout


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.dataSource =  (MainDataSource*)self.collectionView.dataSource;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];

    // Cells
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    id<CalendarEvent> event = [self.dataSource eventAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [event eventFrame];
    return attributes;
}

- (CGSize)collectionViewContentSize
{
    // Don't scroll horizontally
    CGFloat contentWidth = self.collectionView.bounds.size.width;

    //divide screen into 2 parts
    MainDataSource* dataSource = (MainDataSource*)self.collectionView.dataSource;
    
    CGFloat contentHeight = 0;
    __block CGFloat leftSideHeight = 0;
    __block CGFloat rightSideHeight = 0;
    
    //NSMutableArray* leftArr = [NSMutableArray new];
    //NSMutableArray* rightArr = [NSMutableArray new];
    //NSLog(@"called");
    
    [dataSource.events enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id<CalendarEvent> item = obj;
        NSUInteger duration = item.durationInHours * 50;
        if (idx % 2 == 0) {
            item.eventFrame = CGRectMake(CellPadding, leftSideHeight , CellWidth, duration);
            leftSideHeight += duration + CellPadding;
        }
        //odd
        else
        {
            item.eventFrame = CGRectMake(CellPadding * 2 + CellWidth, rightSideHeight , CellWidth, duration);
            rightSideHeight += duration + CellPadding ;
        }
    }];
    
    /*
    for (int idx = 0 ; idx < dataSource.events.count ; idx++) {
     
        id<CalendarEvent> item = dataSource.events[idx];
        NSUInteger duration = item.durationInHours * 50;
        
        if (leftArr.count > 0) {
            if (rightArr.count > 0) {
                NSUInteger leftLastIdx = leftArr.count - 1;
                NSUInteger rightLastIdx= rightArr.count - 1;
                id<CalendarEvent> leftLastItem = leftArr[leftLastIdx];
                id<CalendarEvent> rightLastItem= rightArr[rightLastIdx];
                //start frome the 3rd item
                //even
                NSLog(@"%d : %@    %@" ,idx,leftLastItem,rightLastItem);
                if (idx % 2 == 0) {
                    if ([rightLastItem eventFrame].origin.y < [leftLastItem eventFrame].origin.y) {
                        item.eventFrame = CGRectMake(CellPadding * 2 + CellWidth, rightSideHeight , CellWidth, duration);
                        rightSideHeight += duration + CellPadding ;
                        [rightArr addObject:item];
                    }
                    else
                    {
                        item.eventFrame = CGRectMake(CellPadding, leftSideHeight , CellWidth, duration);
                        leftSideHeight += duration + CellPadding;
                        [leftArr addObject:item];
 
                    }
                }
                //odd
                else
                {
                    if ([leftLastItem eventFrame].origin.y < [rightLastItem eventFrame].origin.y) {
                        item.eventFrame = CGRectMake(CellPadding, leftSideHeight , CellWidth, duration);
                        leftSideHeight += duration + CellPadding;
                        [leftArr addObject:item];
                    }
                    else
                    {
                        item.eventFrame = CGRectMake(CellPadding * 2 + CellWidth, rightSideHeight , CellWidth, duration);
                        rightSideHeight += duration + CellPadding ;
                        [rightArr addObject:item];
                    }
                }
            }
            // add right first item
            else
            {
                item.eventFrame = CGRectMake(CellPadding * 2 + CellWidth, rightSideHeight , CellWidth, duration);
                rightSideHeight += duration + CellPadding ;
                [rightArr addObject:item];
            }
        }
        //add left first item
        else
        {
            item.eventFrame = CGRectMake(CellPadding, leftSideHeight , CellWidth, duration);
            leftSideHeight += duration + CellPadding;
            [leftArr addObject:item];
        }
        
    };
     */
    
    contentHeight = MAX(leftSideHeight,rightSideHeight);
    
    
    // Scroll vertically to display a full day
    //CGFloat contentHeight = DayHeaderHeight + (HeightPerHour * HoursPerDay);
    
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    return contentSize;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    if (newBounds.size.width == self.collectionView.frame.size.width) {
        return NO;
    }
    return YES;
}

#pragma mark - Helpers
- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect
{
    NSMutableArray* indexPaths = [NSMutableArray new];
    [self.dataSource.events enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id<CalendarEvent> item = obj;
        //NSLog(@"%@", NSStringFromCGRect([item eventFrame]));
        if (CGRectIntersectsRect(rect, item.eventFrame)) {
            [indexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:0]];
        }
    }];
    
    return indexPaths;
}
@end
