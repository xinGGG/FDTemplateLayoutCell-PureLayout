//
//  TableViewCell.m
//  FDTemplateLayoutCell+PureLayout
//
//  Created by xing on 15/11/24.
//
//
#import "PureLayout.h"
#import <PureLayout/PureLayout.h>
#import "JXTableViewCell.h"
#import "FDFeedEntity.h"
@interface JXTableViewCell()
@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UILabel *contentLabel;
@property (nonatomic, strong)  UIImageView *contentImageView;
@property (nonatomic, strong)  UILabel *usernameLabel;
@property (nonatomic, strong)  UILabel *timeLabel;
@end

@implementation JXTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createView];
        [self setttingViewAtuoLayout];
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)createView {
    
    self.titleLabel = [UILabel newAutoLayoutView];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    
    self.contentLabel = [UILabel newAutoLayoutView];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    self.contentImageView = [UIImageView newAutoLayoutView];
    [self.contentView addSubview:self.contentImageView];
    
    self.usernameLabel = [UILabel newAutoLayoutView];
    self.usernameLabel.numberOfLines = 0;
    self.usernameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.usernameLabel];
    
    self.timeLabel = [UILabel newAutoLayoutView];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.numberOfLines = 0;
    [self.contentView addSubview:self.timeLabel];
    
}

- (void) setttingViewAtuoLayout {
    
    [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:10];
    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:10];
    [self.titleLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-10];
    
    [self.contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:10];
    [self.contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:10];
    [self.contentLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-10];

    [self.contentImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.contentLabel withOffset:10];
    [self.contentImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:10];
    
    [self.usernameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.contentImageView withOffset:10];
    [self.usernameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:10];
    [self.usernameLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-10];
    
    [self.timeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.contentImageView withOffset:10];
    [self.timeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:10];
    [self.timeLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-10];
    
    [self.timeLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.self.contentView withOffset:-20];

}

- (void)setFeedEntity:(FDFeedEntity *)FeedEntity{
    _FeedEntity = FeedEntity;
    
    self.titleLabel.text = FeedEntity.title;
    self.contentLabel.text = FeedEntity.content;
    self.contentImageView.image = FeedEntity.imageName.length > 0 ? [UIImage imageNamed:FeedEntity.imageName] : nil;
    self.usernameLabel.text = FeedEntity.username;
    self.timeLabel.text = FeedEntity.time;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
