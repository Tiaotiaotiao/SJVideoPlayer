//
//  HokSpeedSettingHorizontalScreenControlLayer.m
//  SJVideoPlayer
//
//  Created by chenjinhua on 2022/12/22.
//

#import "HokSpeedSettingHorizontalScreenControlLayer.h"
#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

#import "HokSpeedSettingHSCell.h"
#import "SJVideoPlayerConfigurations.h"

@interface HokSpeedSettingHorizontalScreenControlLayer () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITableView *tb;

@property (nonatomic, strong) NSArray<NSString *> *dataArray;

@end

@implementation HokSpeedSettingHorizontalScreenControlLayer

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
    [self addSubview:self.tb];
    
    [self initSubviewFrame];
}

- (void)initSubviewFrame {
    [self.tb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([self tbTop]);
        make.left.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-[self tbBottom]);
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
    
    [superV addSubview:self.bgView];
    [superV addSubview:self];
    
    self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, HokRate(120), [UIScreen mainScreen].bounds.size.height);
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.bgView.hidden = NO;
        self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - self.frame.size.width -  HokRate(52), self.frame.origin.y , self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
    
    }];
}

- (void)hide {
    //CGFloat h = self.frame.size.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.bgView.hidden = YES;
        self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, self.frame.origin.y , self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.bgView removeFromSuperview];
    }];
}

#pragma mark - Event response

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture {
    if (self.hideBlock) {
        self.hideBlock();
    }
    
    [self hide];
}

#pragma mark - Delegate

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HokSpeedSettingHSCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HokSpeedSettingHSCell class])];
    if (indexPath.row < self.dataArray.count) {
        NSString *speed = self.dataArray[indexPath.row];;
        cell.name = speed;
        cell.sel = [speed isEqualToString:self.selSpeed];
        
        __weak typeof(self) weakSelf = self;
        cell.selBlock = ^(NSString * _Nonnull speed) {
            if (weakSelf.selBlock) {
                weakSelf.selBlock(speed);
            }
            
            [weakSelf hide];
        };
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tbCellH];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.row >= self.dataArray.count) {
//        [tableView reloadData];
//        return;
//    }
//    
//    NSString *speed = self.dataArray[indexPath.row];
//    
//    if ([speed isEqualToString:self.selSpeed]) {
//        return;
//    }
//    
//    self.selSpeed = speed;
//    [tableView reloadData];
//
//    if (self.selBlock) {
//        self.selBlock(speed);
//    }
//    
//    [self hide1];
}

#pragma mark - Private

- (CGFloat)allH {
    //CGFloat count = self.dataArray.count;
    
    //CGFloat allH = [self tbTop] + [self tbCellH] * count + [self tbBottom];
    
    CGFloat allH = [UIScreen mainScreen].bounds.size.height - [self tbTop] - [self tbBottom];

    return allH;
}

- (CGFloat)tbTop {
    return HokRate(12);
}

- (CGFloat)tbCellH {
    if (self.dataArray.count == 0) {
        return 0;
    }
    
    return [self allH] / self.dataArray.count;
}

- (CGFloat)tbBottom {
    return HokRate(12);
}

#pragma mark - Getter/Setter
    
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.hidden = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [_bgView addGestureRecognizer:tap];
        
        // gradient
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = _bgView.bounds;
        gl.startPoint = CGPointMake(0, 0.5);
        gl.endPoint = CGPointMake(0.5, 0.5);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4000].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        [_bgView.layer insertSublayer:gl atIndex:0];
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
        
        [_tb registerClass:[HokSpeedSettingHSCell class] forCellReuseIdentifier:NSStringFromClass([HokSpeedSettingHSCell class])];
    }
    return _tb;
}

- (NSArray<NSString *> *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"0.5X", @"1.0X", @"1.25X", @"1.5X", @"2.0X"];
    }
    return _dataArray;
}

- (void)setSelSpeed:(NSString *)selSpeed {
    if ((!selSpeed || ![selSpeed containsString:@"X"]) && self.dataArray.count > 1) {
        selSpeed = self.dataArray[1];
    }
    _selSpeed = selSpeed;
    
    [self.tb reloadData];
}

#pragma mark - Super

#pragma mark - NSObject

@end
