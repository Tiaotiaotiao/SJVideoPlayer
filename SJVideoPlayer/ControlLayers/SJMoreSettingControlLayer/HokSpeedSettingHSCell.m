//
//  HokSpeedSettingHSCell.m
//  SJVideoPlayer
//
//  Created by chenjinhua on 2022/12/22.
//

#import "HokSpeedSettingHSCell.h"
#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

#import "SJVideoPlayerConfigurations.h"

@interface HokSpeedSettingHSCell ()

@property (nonatomic, strong) UIButton *speedBtn;

//@property (nonatomic, strong) UILabel *speedLbl;

@end

@implementation HokSpeedSettingHSCell

#pragma mark - dealloc Life circle

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubview];
    }
    return self;
}

- (void)initSubview {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.speedBtn];
//    [self.contentView addSubview:self.speedLbl];
    
    [self initSubviewFrame];
}

- (void)initSubviewFrame {
    [self.speedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
        make.width.mas_equalTo(HokRate(120));
        make.height.mas_equalTo(HokRate(42));
    }];
}

#pragma mark - Public

#pragma mark - Event response

- (void)speedClickAction:(UIButton *)x {
    if (self.selBlock) {
        self.selBlock(self.name);
    }
}

#pragma mark - Delegate

#pragma mark - Private

#pragma mark - Getter/Setter

- (UIButton *)speedBtn {
    if (!_speedBtn) {
        _speedBtn = [[UIButton alloc] init];
        [_speedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_speedBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:145/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateSelected];
        _speedBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:HokRate(16)];
        [_speedBtn addTarget:self action:@selector(speedClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _speedBtn;
}

//- (UILabel *)speedLbl {
//    if (!_speedLbl) {
//        _speedLbl = [[UILabel alloc] initWithFrame:CGRectZero];
//        _speedLbl.textColor = [UIColor whiteColor];
//        _speedLbl.font = [UIFont fontWithName:@"PingFangSC-Regular" size:HokRate(16)];
//    }
//    return _speedLbl;
//}

#pragma mark - Super

#pragma mark - NSObject

- (void)setName:(NSString *)name {
    _name = name;
    
    [_speedBtn setTitle:name forState:UIControlStateNormal];
}

- (void)setSel:(BOOL)sel {
    _sel = sel;
    
    self.speedBtn.selected = sel;
    
    if (sel) {
        self.speedBtn.layer.borderWidth = 1;
        self.speedBtn.layer.borderColor = [UIColor colorWithRed:0/255.0 green:145/255.0 blue:255/255.0 alpha:1.0].CGColor;
        self.speedBtn.titleLabel.font =[UIFont fontWithName:@"PingFangSC-Semibold" size:HokRate(16)];
        self.speedBtn.layer.cornerRadius = 4;
    } else {
        self.speedBtn.layer.borderWidth = 0;
        self.speedBtn.layer.borderColor = nil;
        self.speedBtn.titleLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size:HokRate(16)];
        self.speedBtn.layer.cornerRadius = 0;
    }
}

@end
