#import <UIKit/UIKit.h>

// 汎用的なUIViewControllerフック
// LINEアプリ内のどの画面が表示されても、最初の1回だけアラートを出す
%hook UIViewController

- (void)viewDidAppear:(BOOL)animated {
    %orig;

    // 一度だけ実行するためのフラグ
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // アラートの作成
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nezu Mod"
                                                                       message:@"Injection Successful!\nMod is active."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        // OKボタンのアクション
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" 
                                                  style:UIAlertActionStyleDefault 
                                                handler:nil]];
        
        // アラートの表示
        // 現在のViewControllerから提示する
        [self presentViewController:alert animated:YES completion:nil];
        
        NSLog(@"[NezuMod] Welcome alert shown.");
    });
}

%end

%ctor {
    NSLog(@"[NezuMod] Loaded into process.");
}
