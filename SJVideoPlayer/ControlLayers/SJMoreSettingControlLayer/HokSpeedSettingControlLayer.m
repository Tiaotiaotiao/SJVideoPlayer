//
//  HokSpeedSettingControlLayer.m
//  SJVideoPlayer
//
//  Created by chenjinhua on 2022/9/23.
//

#import "HokSpeedSettingControlLayer.h"

#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

#import "HokSpeedSettingCell.h"
#import "SJVideoPlayerConfigurations.h"

@interface HokSpeedSettingControlLayer () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITableView *tb;

@property (nonatomic, strong) NSArray<NSString *> *dataArray;

@end

@implementation HokSpeedSettingControlLayer

#pragma mark - dealloc Life circle

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubview];
    }
    return self;
}

- (void)initSubview {
    if (self.dataArray.count > 0) {
        self.selSpeed = self.dataArray[1];
    }
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;

    [self addSubview:self.tb];
    
    [self initSubviewFrame];
}

- (void)initSubviewFrame {
    [self.tb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([self tbTop]);
        make.left.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo([self tbBottom]);
    }];
}

#pragma mark - Public

- (void)show:(UIView * _Nullable)superV {
    if ([self superview]) {
        [self removeFromSuperview];
    }
    
    if (!superV) {
        superV = [UIApplication sharedApplication].keyWindow;
    }
    
    //self.bgView.frame = superV.bounds;
    
    //[superV addSubview:self.bgView];
    [superV addSubview:self];

    CGFloat h = [self allH];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //self.bgView.hidden = NO;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - h - HokRate(4) , self.frame.size.width, h);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    CGFloat h = self.frame.size.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //self.bgView.hidden = YES;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + h, self.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        //[self.bgView removeFromSuperview];
    }];
}

- (void)hide1 {
    [self hide];
    
    if (self.hideBlock) {
        self.hideBlock();
    }
}

- (CGFloat)allH {
    CGFloat count = self.dataArray.count;
    
    CGFloat allH = [self tbTop] + [self tbCellH] * count + [self tbBottom];
    
    return allH;
}

- (CGFloat)tbTop {
    return HokRate(4);
}

- (CGFloat)tbCellH {
    return HokRate(22);
}

- (CGFloat)tbBottom {
    return HokRate(4);
}

#pragma mark - Event response

#pragma mark - Delegate

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HokSpeedSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HokSpeedSettingCell class])];
    if (indexPath.row < self.dataArray.count) {
        NSString *speed = self.dataArray[indexPath.row];;
        cell.name = speed;
        cell.sel = [speed isEqualToString:self.selSpeed];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tbCellH];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row >= self.dataArray.count) {
        [tableView reloadData];
        return;
    }
    
    NSString *speed = self.dataArray[indexPath.row];
    
    if ([speed isEqualToString:self.selSpeed]) {
        return;
    }
    
    self.selSpeed = speed;
    [tableView reloadData];

    if (self.selBlock) {
        self.selBlock(speed);
    }
    
    [self hide1];
}

#pragma mark - Private

#pragma mark - Getter/Setter
    
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.hidden = YES;
    }
    return _bgView;
}

- (UITableView *)tb {
    if (!_tb) {
        _tb = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tb.backgroundColor = [UIColor clearColor];
        _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tb.showsVerticalScrollIndicator = NO;
        _tb.delegate = self;
        _tb.dataSource = self;
        _tb.scrollEnabled = NO;
        _tb.bounces = NO;
        
        if (@available(iOS 15.0, *)) {
            _tb.sectionHeaderTopPadding = 0;
        }
        
        if (@available(iOS 11.0, *)) {
            _tb.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_tb registerClass:[HokSpeedSettingCell class] forCellReuseIdentifier:NSStringFromClass([HokSpeedSettingCell class])];
    }
    return _tb;
}

- (NSArray<NSString *> *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"0.5X", @"1.0X", @"1.25X", @"1.5X", @"2.0X"];
    }
    return _dataArray;
}

#pragma mark - Super

#pragma mark - NSObject

@end
