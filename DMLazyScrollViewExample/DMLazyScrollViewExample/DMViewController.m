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
@property (nonatomic, strong) UITableView *nearbyTableView;
@property (nonatomic, strong) UITableView *recentTableView;
@property (nonatomic, strong) UITableView *popularTableView;
@end

@implementation DMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nearbyTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.recentTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.popularTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    NSUInteger numberOfPages = 3;
    viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [viewControllerArray addObject:[NSNull null]];
    }
    
    // PREPARE LAZY VIEW
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:rect];
    
    __weak __typeof(&*self)weakSelf = self;
    lazyScrollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    lazyScrollView.numberOfPages = numberOfPages;
   // lazyScrollView.controlDelegate = self;
    [self.view addSubview:lazyScrollView];
    [lazyScrollView setPage:1 animated:NO];
}

- (UIViewController *) controllerAtIndex:(NSInteger) index
{
    if (index > viewControllerArray.count || index < 0) return nil;
    id res = [viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        UIViewController *contr = [[UIViewController alloc] init];
        switch (index) {
            case 0:
                [contr.view addSubview:self.nearbyTableView];
                self.nearbyTableView.dataSource = self;
                self.nearbyTableView.delegate = self;
                break;
            case 1:
                [contr.view addSubview:self.recentTableView];
                self.recentTableView.dataSource = self;
                self.recentTableView.dataSource = self;
                break;
            case 2:
                [contr.view addSubview:self.popularTableView];
                self.popularTableView.dataSource = self;
                self.popularTableView.delegate = self;
                break;
        }
        [viewControllerArray replaceObjectAtIndex:index withObject:contr];
        return contr;
    }
    return res;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    return cell;
}

/*
- (void)lazyScrollViewDidEndDragging:(DMLazyScrollView *)pagingView 
{
    NSLog(@"Now visible: %@",lazyScrollView.visibleViewController);
}
*/
@end
