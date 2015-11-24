//
//  ViewController.m
//  FDTemplateLayoutCell+PureLayout
//
//  Created by xing on 15/11/24.
//
//

#import "ViewController.h"
#import "JXTableViewCell.h"
#import "PureLayout.h"
#import <PureLayout/PureLayout.h>
#import "UITableView+FDTemplateLayoutCell.h"
#import "FDFeedEntity.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

//pureLayout属性
@property (nonatomic, assign) BOOL           didSetupConstraints;
//FDTemplateLayoutCell配置属性
@property (nonatomic, strong) NSMutableArray *feedEntitySections; // 2d array
@property (nonatomic, assign) BOOL cellHeightCacheEnabled;
//tableView
@property (nonatomic,strong) UITableView    *tableView;
@property (nonatomic,strong) NSMutableArray     *dataArray;
@end

@implementation ViewController

-(void)loadView
{
    [super loadView];
    [self.view addSubview:self.tableView];

}

-(void)updateViewConstraints
{
    if(!self.didSetupConstraints){
        
        [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view];
        [self.tableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
        [self.tableView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
        [self.tableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    

    self.tableView.fd_debugLogEnabled = YES;
    self.cellHeightCacheEnabled = YES;
    
    // 给一个标识符，告诉tableView要创建哪个类
    [self.tableView registerClass:[JXTableViewCell class] forCellReuseIdentifier:@"cell"];

    //数据加载
    [self loadData:^{

        [self.tableView reloadData];
        
    }];
    
}

-(void)loadData:(void(^)()) then
{
    // Simulate an async request
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Data from `data.json`
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        
        // Convert to `FDFeedEntity`
        NSMutableArray *entities = @[].mutableCopy;
        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[FDFeedEntity alloc] initWithDictionary:obj]];
        }];
        
        self.dataArray = [NSMutableArray array];

        self.dataArray = entities;
        
        // Callback
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [self setupModelOfCell:cell atIndexPath:indexPath];
    return cell;
}



- (void) setupModelOfCell:(JXTableViewCell *) cell atIndexPath:(NSIndexPath *) indexPath {
    
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
//        cell.fd_enforceFrameLayout = YES;
    cell.FeedEntity = self.dataArray[indexPath.row];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.cellHeightCacheEnabled) {
        return [tableView fd_heightForCellWithIdentifier:@"cell" cacheByIndexPath:indexPath configuration:^(JXTableViewCell *cell) {
            [self setupModelOfCell:cell atIndexPath:indexPath];
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:@"cell" configuration:^(JXTableViewCell *cell) {
            [self setupModelOfCell:cell atIndexPath:indexPath];
        }];
    }
}


#pragma  mark - Setup
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView newAutoLayoutView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}


@end
