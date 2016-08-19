//
//  MInePhoto.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/7.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "MinePhotoView.h"
#import "UIImageView+AFNetWorking.h"
#import "BaseViewController.h"

@implementation MinePhotoView {
    
    NSMutableArray *_selectedPhotos;

}


- (void)awakeFromNib {
    [super awakeFromNib];
    _iconView.layer.cornerRadius = _iconView.width/2;
    _iconView.layer.masksToBounds = YES;
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSURL *photoURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PIC_URL,dic[@"headPhoto"]]];
    UIImage *img = [UIImage imageNamed:@"我的_头像"];
    [_iconView setImageWithURL:photoURL placeholderImage:img];
    
    
    
}

- (IBAction)takePhotoAction:(UIButton *)sender {
     NSLogSFQ(@"拍照");
    //判断是否有可用的摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    
    if (!isCamera) {
        
        //弹出提示框
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                            message:@"没有可用的摄像头"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil , nil];
        [alertView show];
//        NSLogSFQ(@"没有可用的摄像头");
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [[self viewController] presentViewController:imagePicker animated:YES completion:nil];

}
- (IBAction)photographAlbumAction:(UIButton *)sender {
    NSLogSFQ(@"相册");
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    
    //设置资源来源
    imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    imgPicker.delegate = self;
    //模态效果弹出
    [[self viewController] presentViewController:imgPicker animated:YES completion:nil];

}

//取到视图控制器
- (UIViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}

#pragma  mark -- 完成选取资源调用此协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (_selectedPhotos == nil) {
        _selectedPhotos = [NSMutableArray array];
    }
    
    //    NSLog(@"选取完成...%@",info);
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {//图片
        
        //获取图片
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
//        _iconView.image = originalImage;
        [_selectedPhotos addObject:originalImage];
        //判断图片来源是否是来自摄像头
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            
            //保存图片到相册
            UIImageWriteToSavedPhotosAlbum(originalImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
       
    
    }
    //取消模态
    [picker dismissViewControllerAnimated:YES completion:^{
        //用户选好了图片就开始上传
        [self uploadPic];
        
    }];
}

//保存图片的监听方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        NSLogSFQ(@"保存成功");
    }else{
        
        NSLogSFQ(@"保存失败");
    }
}

//取消选取图片调用此协议方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    NSLogSFQ(@"取消");
    
    //取消模态
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//上传图片
- (void)uploadPic {
    if (_selectedPhotos.count == 0) {
        
    }else{
        NSLogSFQ(@"正在上传");
        [self uploadPicwithFile:_selectedPhotos withIndex:_selectedPhotos.count - 1];
        
    }
}
- (void)uploadPicwithFile:(NSMutableArray *)paths withIndex:(NSInteger)index{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    NSString *nameStr = [NSString stringWithFormat:@"image%ld.png",index];
    NSData *imageData = UIImageJPEGRepresentation(paths[index], 0.1);
    [dataDic setObject:imageData forKey:nameStr];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //取登录储存的数据
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    [params setObject:@1 forKey:@"fileType"];
    [params setObject:userDic[@"staffId"] forKey:@"businesId"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL,UpdataFileURL];
    
    [TestTool post:url
           params:params
             data:dataDic
          success:^(id result) {
              NSLogSFQ(@"返回数据:%@",result);
              BOOL resultFlag = [[result objectForKey:@"flag"] boolValue];
              if (resultFlag) {
                
                  if (index < paths.count - 1) {
                      [self uploadPicwithFile:_selectedPhotos withIndex:index + 1];
                  }else{
                      
                  }
                  [self modifyPhoto:result[@"data"][@"filePath"]];
                  [self setHidden:YES];
                  
              }else{
//                  [self hideFailHUD:@"上传失败"];
              }
          } failure:^(NSError *error) {
              
//              [self hideFailHUD:@"上传失败"];
              
          }];
    
}
//修改图片
- (void)modifyPhoto:(NSString *)filePath {
    
    NSURL *photoURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/epFile%@",BASE_URL,filePath]];
    UIImage *img = [UIImage imageNamed:@"我的_头像"];
    [_iconView setImageWithURL:photoURL placeholderImage:img];

    //修改已储存的图片路径
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSMutableDictionary *userDic = dic.mutableCopy;
    userDic[@"headPhoto"] = filePath;
    
    [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"userDic"];
    
    self.photoBlock(filePath);
}

- (IBAction)cancelAction:(UIButton *)sender {
    
    self.hidden = YES;
}

@end
