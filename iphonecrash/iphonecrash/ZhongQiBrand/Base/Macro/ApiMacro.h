//
//  ApiMacro.h
//  VoteCloud
//
//  Created by ios2 on 2019/8/15.
//  Copyright © 2019 CY. All rights reserved.
//

#ifndef ApiMacro_h
#define ApiMacro_h

//#define DEBUG_HOST            //注释代码切换服务器
#ifdef DEBUG_HOST
#define APPURL_prefix   @"http://apizhengyang.10brandcn.com:88"
#define APPVoteCer_prefix @"http://39.107.141.90:83"
#else
#define APPURL_prefix   @"http://apizhengyang.10brandcn.com:88"
#define APPVoteCer_prefix @"https://v.520wtp.com"
#endif

#define APP_ID @"123456"


#define Login_prefix @"/member/login.php" // 登录

//=================================================

#define Home_prefix @"/home/index.php"   //首页接口

#define Home_vote_prefix @"/home/vote.php" //首页快速投票接口

#define Brand_world_prefix @"/home/action.php?action=brandslist"   // 品搭世界列表接口

#define Brand_world_detail_prefix @"/home/action.php?action=brandsdetail"   // 品搭世界列表接口

#define Join_Brand_world__prefix @"/home/upload.php?action=joinbrands"   // 品搭世界列表接口

#define Brand_headLine_prefix @"/home/action.php" //品牌头条

#define Brand_listTable_prefix @"/home/action.php?action=hotlist" //热门榜单列表


#endif /* ApiMacro_h */
