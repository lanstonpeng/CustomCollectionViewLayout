//
//  MainCollectionViewController.m
//  ScrollViewTest
//
//  Created by Lanston Peng on 11/4/14.
//  Copyright (c) 2014 Vtm. All rights reserved.
//

#import "MainCollectionViewController.h"
#import "SampleCalendarEvent.h"
#import "CollectionViewCell.h"
#import "CalendarEvent.h"
#import "MainDataSource.h"

@interface MainCollectionViewController()<UICollectionViewDelegate>

@property (strong, nonatomic)  MainDataSource* customDataSource;

@end

@implementation MainCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MainDataSource* dataSource = (MainDataSource*)self.collectionView.dataSource;
    dataSource.configureCellBlock = ^(CollectionViewCell* cell, NSIndexPath* indexPath, id<CalendarEvent>event)
    {
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    };
}


@end
