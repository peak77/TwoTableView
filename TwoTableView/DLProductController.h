//
//  DLProductController.h
//  TwoTableView
//
//  Created by dev on 16/6/13.
//  Copyright © 2016年 donglian@eastunion.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLProductControllerDelegate <NSObject>

@optional

- (void)willDisplayHeaderView:(NSInteger)section;
- (void)didEndDisplayingHeaderView:(NSInteger)section;

@end

@interface DLProductController : UIViewController

- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, weak) id <DLProductControllerDelegate> delegate;

@end
