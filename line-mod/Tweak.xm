// Based on: https://qiita.com/SsS136/items/9b7a290ba98070dccfd0
%hook NLConfigurationManager

// ニュースタブを無効化（通話タブなどに置き換わる）
- (bool)useNewsTab {
    return false;
}

%end
