//
//  AppDelegate.m
//  MyPet
//
//  Created by 袁立康 on 17/3/26.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
static SystemSoundID soundID = 0;

@interface AppDelegate ()<UNUserNotificationCenterDelegate,EMChatManagerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //图标
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc]initWithType:@"one" localizedTitle:@"社区" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] userInfo:nil];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc]initWithType:@"two" localizedTitle:@"发布" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];
    //显示顺序.
    [UIApplication sharedApplication].shortcutItems = @[item1, item2];
    
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    //注册消息回调
    
    //注册bmob
    //启动基本SDK
//    [[PgyManager sharedPgyManager] startManagerWithAppId:@"16e9996a6781ae3ffe8d55f877dabe12"];
    //获取夜间模式状态
    [ThemeManage shareThemeManage].isNight = [[NSUserDefaults standardUserDefaults] boolForKey:@"night"];
    [Bmob registerWithAppKey:@"5edb7a137c535854844cb92b8c1b2149"];
    [SMSSDK registerApp:@"133daf526d52f" withSecret:@"0541ccfbdab6bc6b97575558b0fdb3cc"];
    //注册环信
    
    //获取夜间模式状态
    EMOptions *options = [EMOptions optionsWithAppkey:@"1834751360#pan"];
    [[EMClient sharedClient]initializeSDKWithOptions:options];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];

    [self _registerRemoteNotification];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
#pragma mark 创建TabBar
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        //第一次启动
        self.window.rootViewController = [[ViewController alloc]init];
    }else{
        DLTabBarController *myTabBar = [[DLTabBarController alloc]init];
        [myTabBar.tabBar NightWithType:UIViewColorTypeNormal];
        self.window.rootViewController = myTabBar;
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {

    if ([shortcutItem.type isEqualToString:@"one"]) {
        //跳转社区
        
    }else if([shortcutItem.type isEqualToString:@"two"]) {
        
        PB_vc *vc = [[PB_vc alloc]init];
        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
        NSLog(@"进入");
    }
    
}


//收到消息时，添加本地推送
- (void)didReceiveMessages:(NSArray *)aMessages {
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        NSLog(@"在前台收到消息");
        dispatch_async(dispatch_get_main_queue(), ^{
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            
        });
        
    }
    
    EMMessage *mes = [aMessages lastObject];
    
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = mes;
    if (lastMessage) {
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
                if ([lastMessage.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
                    latestMessageTitle = @"[动画表情]";
                }
                NSLog(@"latestMessTitle%@", latestMessageTitle);
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    
    //添加本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc]init];
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.5];
//    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    localNote.soundName = UILocalNotificationDefaultSoundName;
        //判断类型更改样式
        NSString *didReceiveText2 = [EaseConvertToCommonEmoticonsHelper convertToSystemEmoticons:latestMessageTitle];
        switch (lastMessage.body.type) {
            case EMMessageBodyTypeText:
                localNote.alertBody = [NSString stringWithFormat:@"%@:%@", mes.from, didReceiveText2];   break;
            case EMMessageBodyTypeImage:{
                localNote.alertBody = [NSString stringWithFormat:@"%@发来一张图片", mes.from];
            } break;
            case EMMessageBodyTypeVoice:{
                localNote.alertBody = [NSString stringWithFormat:@"%@发来一段语音", mes.from];
            } break;
                
            default:
                break;
        }
    
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];


}



#pragma mark -  本地通知回调函数 接受本地通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    

}

#pragma mark - 闹铃重复播放
void playFinished(SystemSoundID  ssID, void* clientData)
{
    //    unsigned long ID = ssID; // ssID 不能直接作为参数打印出来，需要中转一次
    //    NSLog(@"播放完成-传入ID为-%lu,传入的参数为%@", ID, clientData);
    // 播放
    AudioServicesPlayAlertSound((SystemSoundID)soundID);
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)_registerRemoteNotification
{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError *error) {
            if (granted) {
#if !TARGET_IPHONE_SIMULATOR
                [application registerForRemoteNotifications];
#endif
            }
        }];
        return;
    }
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
#endif
}


- (BOOL) isFirstLoad{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
    
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
    }
    else if (![lastRunVersion isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;  
    }  
    return NO;  
}

@end
