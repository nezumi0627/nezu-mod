#import <UIKit/UIKit.h>

// Based on: https://qiita.com/SsS136/items/9b7a290ba98070dccfd0

static BOOL hasShownPopup = NO;

%group NezuModHooks
%hook NLConfigurationManager

// ニュースタブを無効化（通話タブなどに置き換わる）
- (bool)useNewsTab {
    return false;
}

%end
%end // NezuModHooks


%ctor {
    // Initialize hooks
    %init(NezuModHooks);
    
    // Add observer for app launch/activation to show popup
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification 
                                                      object:nil 
                                                       queue:[NSOperationQueue mainQueue] 
                                                  usingBlock:^(NSNotification *note) {
        if (hasShownPopup) return;
        hasShownPopup = YES;
        
        // 3 second delay to ensure UI is fully loaded
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // Find the top-most view controller
            UIWindow *keyWindow = nil;
            if (@available(iOS 13.0, *)) {
                for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
                    if (scene.activationState == UISceneActivationStateForegroundActive) {
                        for (UIWindow *w in scene.windows) {
                            if (w.isKeyWindow) {
                                keyWindow = w;
                                break;
                            }
                        }
                    }
                    if (keyWindow) break;
                }
            }
            
            if (!keyWindow) {
                keyWindow = [[UIApplication sharedApplication] keyWindow];
            }
            
            if (!keyWindow && [[UIApplication sharedApplication].windows count] > 0) {
                keyWindow = [[UIApplication sharedApplication].windows firstObject];
            }
            
            UIViewController *topVC = keyWindow.rootViewController;
            while (topVC.presentedViewController) {
                topVC = topVC.presentedViewController;
            }
            
            if (topVC) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"NezuMod" 
                                                                               message:@"Successfully Injected!\n(News Tab Disabled)" 
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Nice!" 
                                                                   style:UIAlertActionStyleDefault 
                                                                 handler:nil];
                
                [alert addAction:okAction];
                [topVC presentViewController:alert animated:YES completion:nil];
            }
        });
    }];
}

/* --- Advanced Feature Ideas (Need verification with headers/FLEX) ---

// 1. Adblock (Chat list / Timeline)
%hook LNAAdContentsManager
- (bool)shouldShowAd {
    return false;
}
%end

// 2. Prevent Read Receipt (Concept)
// Note: Blocking this might stop you from seeing others' read receipts too.
%hook MessageService
- (void)sendReadReceiptForMessage:(id)msg {
    // Simply do nothing to block sending the receipt
    NSLog(@"[NezuMod] Read receipt blocked.");
}
%end

// 3. Anti-Unsend (Concept)
%hook LINEMessageManager
- (void)didReceiveUnsendMessageNotification:(id)notification {
    // Do nothing to keep the message in the chat
    NSLog(@"[NezuMod] Unsend message prevented.");
}
%end

*/
