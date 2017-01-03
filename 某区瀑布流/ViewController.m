//
//  ViewController.m
//  某区瀑布流
//
//  Created by 陈万里 on 2016/12/15.
//  Copyright © 2016年 万里. All rights reserved.
//

#import "ViewController.h"
#import "WLCollectionViewFlowLayout.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WLFlowCollectionViewLayoutDelegate>

@property(nonatomic, strong) UICollectionView   *collectionView;

@end

@implementation ViewController


static NSString * const HomeBaseCellReuseID = @"HomeBaseCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self cerateUI];
    
}


- (void)cerateUI{
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    WLCollectionViewFlowLayout *layout = [WLCollectionViewFlowLayout waterFallLayoutWithColumnCount:2];
    layout.columnSection = 2;
    layout.delegate = self;
    
    self.collectionView                 = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    //    [self.collectionView registerClass:[HomeBaseCellReuseID class] forCellWithReuseIdentifier:shopCellReuseID];
    
    [self.view addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)       return 1;
    else                    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    label.text = [NSString stringWithFormat:@"%ld  %ld",indexPath.section,indexPath.row];
    label.textAlignment = 1;
    [cell.contentView addSubview:label];
    
    if (arc4random() % 2 == 0) {
        cell.backgroundColor = [UIColor yellowColor];
    }else{
        cell.backgroundColor = [UIColor redColor];
    }
    
    return cell;
    
    
}

- (CGFloat)waterfallLayout:(WLCollectionViewFlowLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    
    //    HomeGoodslistModel *mode = self.goodsListArray[indexPath.row];
    
    NSInteger co = arc4random() % 100 + 100;
    
    CGFloat column = co / 100.0;
    
    return itemWidth / column + 70;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *headView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
//        headView.indexPath = indexPath;
        headView.backgroundColor = [UIColor blueColor];
    }
    
    return headView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(kScreenW, 50);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenW, 50);
}
@end
