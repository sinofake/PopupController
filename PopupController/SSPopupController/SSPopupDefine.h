//
//  eLongPopupDefine.h
//  PopupController
//
//  Created by zhucuirong on 15/9/16.
//  Copyright (c) 2015年 SINOFAKE SINEP. All rights reserved.
//

#ifndef PopupController_eLongPopupDefine_h
#define PopupController_eLongPopupDefine_h

#define SS_SCREEN_WIDTH	  ([[UIScreen mainScreen] bounds].size.width)
#define SS_SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)
#define SS_SCREEN_SCALE   (1.0f/[UIScreen mainScreen].scale)


#define POPUP_CONTENT_HEIGHT 216.f
#define POPUP_TITLE_VIEW_HEIGHT 40.f
#define POPUP_TITLE_VIEW_BUTTON_WIDTH 80.f
#define POPUP_TITLE_VIEW_BUTTON_PADDING 14.f


#define SS_BundleImageWithName(name) [UIImage imageWithContentsOfFile:[[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SSPopupController.bundle"] stringByAppendingPathComponent:name]]


#endif
