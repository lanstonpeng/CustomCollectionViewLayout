//
//  MainDataSource.h
//  ScrollViewTest
//
//  Created by Lanston Peng on 11/4/14.
//  Copyright (c) 2014 Vtm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CalendarEvent.h"
#import "CollectionViewCell.h"

typedef void (^ConfigureCellBlock)(CollectionViewCell *cell, NSIndexPath *indexPath, id<CalendarEvent> event);

@interface MainDataSource : NSObject<UICollectionViewDataSource>

@property (copy,nonatomic)ConfigureCellBlock configureCellBlock;

@property (strong, nonatomic) NSMutableArray *events;


- (id<CalendarEvent>)eventAtIndexPath:(NSIndexPath *)indexPath;

@end
