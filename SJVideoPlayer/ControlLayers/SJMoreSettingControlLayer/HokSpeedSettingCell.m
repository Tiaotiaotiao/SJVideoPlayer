//
//  HokSpeedSettingCell.m
//  SJVideoPlayer
//
//  Created by chenjinhua on 2022/9/23.
//

#import "HokSpeedSettingCell.h"
#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

#import "SJVideoPlayerConfigurations.h"

@interface HokSpeedSettingCell ()

@property (nonatomic, strong) UILabel *speedLbl;

@end

@implementation HokSpeedSettingCell

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
    
    [self.contentView addSubview:self.speedLbl];
    
    [self initSubviewFrame];
}

- (void)initSubviewFrame {
    [self.speedLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(HokRate(10));
        make.centerX.centerY.mas_equalTo(0);
    }];
}

#pragma mark - Public

#pragma mark - Event response

#pragma mark - Delegate

#pragma mark - Private

#pragma mark - Getter/Setter

- (UILabel *)speedLbl {
    if (!_speedLbl) {
        _speedLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _speedLbl.textColor = [UIColor whiteColor];
        _speedLbl.font = [UIFont fontWithName:@"PingFangSC-Regular" size:HokRate(10)];
    }
    return _speedLbl;
}

#pragma mark - Super

#pragma mark - NSObject

- (void)setName:(NSString *)name {
    self.speedLbl.text = name;
}

- (void)setSel:(BOOL)sel {
    _sel = sel;
    
    self.speedLbl.textColor = sel ? [UIColor colorWithRed:0/255.0 green:145/255.0 blue:255/255.0 alpha:1.0] : UIColor.whiteColor;
}

@end
