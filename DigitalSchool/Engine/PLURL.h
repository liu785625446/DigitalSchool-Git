    //
    //  PLURL.h
    //  PersistenceLayer
    //
    //  Created by 刘军林 on 15/1/7.
    //  Copyright (c) 2015年 刘军林. All rights reserved.
    //

#ifndef PersistenceLayer_PLURL_h
#define PersistenceLayer_PLURL_h

    //#define ALL_URL @"211.153.74.60"

#define ALL_URL @"hnay20.vicp.cc"

    //#define ALL_URL @"211.153.74.60"

#define COURSE_MAIN(url) [NSString stringWithFormat:@"/DSApp/course/main/%@.json",url]

#define COLUMNS_TITLE_LIST(url) [NSString stringWithFormat:@"/DSApp/mmodule/titles/%@.json",url]

#define COLUMNS_PAGE_LIST(url) [NSString stringWithFormat:@"/DSApp/mmodule/page/%@.json",url]

#define COURSE_HOTS(url) [NSString stringWithFormat:@"/DSApp/course/hots/%@.json",url]

#define WORK_AWARD(url) [NSString stringWithFormat:@"/DSApp/work/award/%@.json",url]

#define COURSE_TYPE(url) [NSString stringWithFormat:@"/DSApp/course/type/%@.json",url]

#define COURSE_FILTER(url) [NSString stringWithFormat:@"/DSApp/course/screen/%@.json",url]

#define COURSE_SEARCH(url) [NSString stringWithFormat:@"/DSApp/course/fuzzy/%@.json",url]

#define COURSE_CONDITION(url) [NSString stringWithFormat:@"/DSApp/grade/list/%@.json",url]

#define COURSE_SAVE_WATCH [NSString stringWithFormat:@"/DSApp/course/save_watch.json"]

#define COURSE_GET_WATCH(url) [NSString stringWithFormat:@"/DSApp/course/watchs/%@.json",url]

#define COURSE_ATTENTION [NSString stringWithFormat:@"/DSApp/course/attention.json"]

#define COURSE_CANCEL_ATTENTION [NSString stringWithFormat:@"/DSApp/course/cancel_attention.json"]

#define COURSE_GET_ATTENTIONS(url) [NSString stringWithFormat:@"/DSApp/course/attentions/%@.json",url]

#define DISCUSS_GET_LIST(url) [NSString stringWithFormat:@"/DSApp/cdiscuss/discussions/%@.json",url]

#define NOTE_GET_LIST(url) [NSString stringWithFormat:@"/DSApp/cnote/list/%@.json",url]

#define NOTE_PRAISE [NSString stringWithFormat:@"/DSApp/cnote/praise.json"]

#define LAUNCH_DISCUSS [NSString stringWithFormat:@"/DSApp/cdiscuss/discuss.json"]

#define REPLY_DISCUSS [NSString stringWithFormat:@"/DSApp/cdiscuss/reply.json"]

#define WRITE_NOTE [NSString stringWithFormat:@"/DSApp/cnote/write.json"]

#define ACTIVITY_GET_LIST(url) [NSString stringWithFormat:@"/DSApp/activity/page/%@.json",url]

#define ACTIVITY_COOLECT [NSString stringWithFormat:@"/DSApp/activity/collect.json"]

#define ACTIVITY_CANCEL_COOLECT [NSString stringWithFormat:@"/DSApp/activity/cancel_collect.json"]

#define ACTIVITY_GET_ATTENTIONS_LIST(url) [NSString stringWithFormat:@"/DSApp/activity/attentions/%@.json",url]

#define ACTIVITY_WORKS(url) [NSString stringWithFormat:@"/DSApp/work/page/%@.json",url]

#define GET_ACTIVITY_COMMENT(url) [NSString stringWithFormat:@"/DSApp/adiscuss/page/%@.json",url]

#define ACTIVITY_COMMENT [NSString stringWithFormat:@"/DSApp/adiscuss/comment.json"]

#define CHAPTER_VOLUMES(url) [NSString stringWithFormat:@"/DSApp/course/volumes/%@.json",url]

#define USER_REGISTER [NSString stringWithFormat:@"/DSApp/register.json"]

#define USER_LOGIN [NSString stringWithFormat:@"/DSApp/app-login.json"]

#define USER_MODIFY [NSString stringWithFormat:@"/DSApp/modify.json"]

#define USER_MODIFY_PASSWORD [NSString stringWithFormat:@"/DSApp/modify-password.json"]

#define USER_UPLOAD_IMG [NSString stringWithFormat:@"/DSApp/upload-img.json"]

#define NAV_NAVS(url) [NSString stringWithFormat:@"/DSApp/nav/navs/%@.json",url]

#define NAV_NAVS_DATA(url) [NSString stringWithFormat:@"/DSApp/nav/nav-data/%@.json",url]

#define WORK_UPLOAD [NSString stringWithFormat:@"/DSApp/work/upload.json"]

#define ReplysDiscuss(url) [NSString stringWithFormat:@"/DSApp/cdiscuss/replys/%@.json",url]

#define ActivieReplysDiscuss(url) [NSString stringWithFormat:@"/DSApp/adiscuss/replys/%@.json",url]

#define Praise @"/DSApp/cdiscuss/praise.json"

#define MyUploadWork(url) [NSString stringWithFormat:@"/DSApp/work/my/%@.json",url]

#define REQUEST_ERROR @"请求失败"

#endif