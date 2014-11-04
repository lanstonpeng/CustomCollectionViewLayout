//
//  MainDataSource.m
//  ScrollViewTest
//
//  Created by Lanston Peng on 11/4/14.
//  Copyright (c) 2014 Vtm. All rights reserved.
//

#import "MainDataSource.h"
#import "SampleCalendarEvent.h"

@interface MainDataSource()


@end

@implementation MainDataSource
- (void)awakeFromNib
{
    _events = [[NSMutableArray alloc] init];
    
    [self generateSampleData];
}

- (void)generateSampleData
{
    for (NSUInteger idx = 0; idx < 50; idx++) {
        SampleCalendarEvent *event = [SampleCalendarEvent randomEvent];
        [self.events addObject:event];
    }
}
- (id<CalendarEvent>)eventAtIndexPath:(NSIndexPath *)indexPath
{
    return self.events[indexPath.item];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.events count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<CalendarEvent> event = self.events[indexPath.item];
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseCell" forIndexPath:indexPath];
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, indexPath, event);
    }
    return cell;
}
@end
