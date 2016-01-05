//
//  FirstPageViewController.m
//
//  Created by 王春平 on 15/12/22.
//  Copyright © 2015年 wang. All rights reserved.
//

#import "FirstViewController.h"

#define  GrayColor [UIColor colorWithWhite:0.600 alpha:1.000]
#define RedColor [UIColor colorWithRed:0.973 green:0.412 blue:0.392 alpha:1.000]
#define MainBgColor [UIColor colorWithRed:0.929 green:0.918 blue:0.914 alpha:1.000]
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define StatusHeight [UIApplication sharedApplication].statusBarFrame.size.height

@interface FirstViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *rootScrollView;
@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, strong) UIButton *carefullyChoiceBtn;
@property (nonatomic, strong) UIButton *nearByBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UITableView *choiceTableView;

@end

@implementation FirstViewController

static CGFloat navigationBarHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    [self setupSubViews];
    [self configureNavigationBar];
}

- (void)configureNavigationBar {
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth / 2, navigationBarHeight)];
    self.topScrollView.backgroundColor = [UIColor whiteColor];
    self.carefullyChoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.carefullyChoiceBtn.frame = CGRectMake(0, 0, ScreenWidth / 4, navigationBarHeight);
    [self.carefullyChoiceBtn addTarget:self action:@selector(handleSelect:) forControlEvents:UIControlEventTouchDown];
    [self.carefullyChoiceBtn setTitle:@"按钮1" forState:UIControlStateNormal];
    [self.carefullyChoiceBtn setTitleColor:RedColor forState:UIControlStateNormal];
    self.carefullyChoiceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.topScrollView addSubview:self.carefullyChoiceBtn];
    
    self.nearByBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nearByBtn.frame = CGRectMake(ScreenWidth / 4, 0, ScreenWidth / 4, navigationBarHeight);
    [self.nearByBtn addTarget:self action:@selector(handleNearBy:) forControlEvents:UIControlEventTouchDown];
    [self.nearByBtn setTitle:@"按钮2" forState:UIControlStateNormal];
    [self.nearByBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    self.nearByBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.topScrollView addSubview:self.nearByBtn];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, navigationBarHeight - 2, ScreenWidth / 4, 2)];
    self.lineView.backgroundColor = RedColor;
    [self.topScrollView addSubview:self.lineView];
    self.navigationItem.titleView = self.topScrollView;
}

- (void)setupSubViews {
    CGFloat height = ScreenHeight - StatusHeight - navigationBarHeight;
    self.rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    self.rootScrollView.contentSize = CGSizeMake(2 * ScreenWidth, height);
    self.rootScrollView.delegate = self;
    self.rootScrollView.showsHorizontalScrollIndicator = NO;
    self.rootScrollView.pagingEnabled = YES;
    self.rootScrollView.backgroundColor = MainBgColor;
    self.rootScrollView.bounces = NO;
    self.choiceTableView = [[UITableView alloc] initWithFrame:self.rootScrollView.bounds style:UITableViewStylePlain];
    self.choiceTableView.dataSource = self;
    self.choiceTableView.delegate = self;
    self.choiceTableView.backgroundColor = MainBgColor;
    self.choiceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.rootScrollView addSubview:self.choiceTableView];

    SecondViewController *secondVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SecondViewController"];
    secondVC.view.frame = CGRectMake(ScreenWidth, 0, self.rootScrollView.bounds.size.width, self.rootScrollView.bounds.size.height);
    [self.rootScrollView addSubview:secondVC.view];
    [self.view addSubview:self.rootScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && self.view.window) {
        self.view = nil;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.rootScrollView) {
        CGPoint point = scrollView.contentOffset;
        if (point.x < ScreenWidth) {
            [self clickCarefullyChoiceBtn];
        } else {
            [self clickNearByBtn];
        }
        [self.lineView setOrigin:CGPointMake(point.x / 4, navigationBarHeight - 2)];
    }
}

#pragma mark - handle action

- (void)clickCarefullyChoiceBtn {
    [self.carefullyChoiceBtn setTitleColor:RedColor forState:UIControlStateNormal];
    [self.nearByBtn setTitleColor:GrayColor forState:UIControlStateNormal];
}

- (void)clickNearByBtn {
    [self.carefullyChoiceBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    [self.nearByBtn setTitleColor:RedColor forState:UIControlStateNormal];
}

- (void)handleSelect:(UIButton *)button {
    [self clickCarefullyChoiceBtn];
    [self.rootScrollView setContentOffset:CGPointZero animated:YES];
}

- (void)handleNearBy:(UIButton *)button {
    [self clickNearByBtn];
    [self.rootScrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
