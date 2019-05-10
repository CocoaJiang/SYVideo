
#import "SYSearchChlidVc.h"
#import "SYHotSearchCell.h"


static NSString *hotSearchCell = @"SYHotSearchCell";

@interface SYSearchChlidVc ()

@end

@implementation SYSearchChlidVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREENH_HEIGHT-kTopHeight-40);
    self.tableView.bounces = NO;
    [self.tableView XJRegisCellWithNibWithName:hotSearchCell];
}

-(SYHotSearchCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYHotSearchCell *cell  = [tableView dequeueReusableCellWithIdentifier:hotSearchCell];
    cell.searchDetailModel = self.array[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array count];
}
-(void)setArray:(NSArray *)array{
    _array = array;
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    searchDetailModel *model = self.array[indexPath.row];
    if (self.saveItem) {
        self.saveItem(model.keyword);
    }
}



@end
