//
//  DMViewController.m
//  DMLazyScrollViewExample
//
//  Created by Daniele Margutti (me@danielemargutti.com) on 24/11/12.
//  Copyright (c) 2012 http://www.danielemargutti.com. All rights reserved.
//

#import "DMViewController.h"
#import "DMLazyScrollView.h"

@interface DMViewController () <DMLazyScrollViewDelegate> {
    DMLazyScrollView* lazyScrollView;
    NSMutableArray*    viewControllerArray;
}
@end

@implementation DMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // PREPARE PAGES
    NSUInteger numberOfPages = 3;
    viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [viewControllerArray addObject:[NSNull null]];
    }
    
    // PREPARE LAZY VIEW
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50);
    lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:rect];
    
    __weak __typeof(&*self)weakSelf = self;
    lazyScrollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    lazyScrollView.numberOfPages = numberOfPages;
   // lazyScrollView.controlDelegate = self;
    [self.view addSubview:lazyScrollView];
}

- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > viewControllerArray.count || index < 0) return nil;
    id res = [viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        UIViewController *contr = [[UIViewController alloc] init];
        
        [viewControllerArray replaceObjectAtIndex:index withObject:contr];
        return contr;
    }
    return res;
}

/*
- (void)lazyScrollViewDidEndDragging:(DMLazyScrollView *)pagingView {
    NSLog(@"Now visible: %@",lazyScrollView.visibleViewController);
}
*/
@end
