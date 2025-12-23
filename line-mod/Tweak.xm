#import <UIKit/UIKit.h>

/**
 * NezuMod for LINE
 * Based on: https://qiita.com/SsS136/items/9b7a290ba98070dccfd0
 * Features:
 * - Disable News Tab
 * - Block Ads (Experimental)
 * - Anti-Unsend (Experimental)
 * - Prevent Read Receipt (Experimental)
 */

static BOOL hasShownPopup = NO;

// --- Hooks ---

%group NezuModHooks

// 1. Disable News Tab (Replaces with Call tab etc)
%hook NLConfigurationManager
- (bool)useNewsTab {
    return false;
}
%end

// 2. Ad-block (Chat list / Timeline)
%hook LNAAdContentsManager
- (bool)shouldShowAd {
    return false;
}
%end

// 3. Prevent Read Receipt
// Note: This is an experimental hook. Might need adjustment per LINE version.
%hook MessageService
- (void)sendReadReceiptForMessage:(id)msg {
    // Simply do nothing to block sending the receipt
    NSLog(@"[NezuMod] Read receipt blocked.");
}
%end

// 4. Anti-Unsend
// Prevents messages from being removed when the sender unsends them.
%hook LINEMessageManager
- (void)didReceiveUnsendMessageNotification:(id)notification {
    // Do nothing to keep the message in the chat
    NSLog(@"[NezuMod] Unsend message prevented.");
}
%end

%end // NezuModHooks


// --- Initialization ---

%ctor {
    NSLog(@"[NezuMod] Initializing...");
    
    // Initialize all hooks
    %init(NezuModHooks);
    
    // Add observer for app activation to show the Welcome Popup
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification 
                                                      object:nil 
                                                       queue:[NSOperationQueue mainQueue] 
                                                  usingBlock:^(NSNotification *note) {
        if (hasShownPopup) return;
        hasShownPopup = YES;
        
        // Delay to ensure the UI is rendered
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // Find key window safely (handling deprecations)
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
            
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Wdeprecated-declarations"
            if (!keyWindow) {
                keyWindow = [[UIApplication sharedApplication] keyWindow];
            }
            if (!keyWindow && [[UIApplication sharedApplication].windows count] > 0) {
                keyWindow = [[UIApplication sharedApplication].windows firstObject];
            }
            #pragma clang diagnostic pop
            
            UIViewController *topVC = keyWindow.rootViewController;
            while (topVC.presentedViewController) {
                topVC = topVC.presentedViewController;
            }
            
            if (topVC) {
                NSString *message = @"NezuMod has been successfully injected!\n\n"
                                    "◈ News Tab: Disabled\n"
                                    "◈ Ads: Blocked (Experimental)\n"
                                    "◈ Anti-Unsend: Enabled\n"
                                    "◈ Read Receipts: Hidden";
                                    
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"NezuMod loaded" 
                                                                               message:message 
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"Got it!" 
                                                          style:UIAlertActionStyleDefault 
                                                        handler:nil]];
                                                        
                [topVC presentViewController:alert animated:YES completion:nil];
            }
        });
    }];
}
