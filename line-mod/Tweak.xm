// Based on: https://qiita.com/SsS136/items/9b7a290ba98070dccfd0
%hook NLConfigurationManager

// ニュースタブを無効化（通話タブなどに置き換わる）
- (bool)useNewsTab {
    return false;
}

%end


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
