# NezuLineMod

This is a simple LINE tweak based on an [example Qiita article](https://qiita.com/SsS136/items/9b7a290ba98070dccfd0).

## Features
- Disables the "News" tab in LINE, replacing it with the "Call" tab (or simply removing it).

## How to Install (Using GitHub Actions Artifacts)

### 1. Download the Tweak
- Go to the [Actions tab](https://github.com/nezumi0627/nezu-mod/actions) in this repository.
- Click on the latest successful workflow run.
- Scroll down to the **Artifacts** section and download `NezuLineMod_DEB`.
- Extract the zip file to find the `.deb` file (e.g., `com.yourcompany.nezulinemod_0.0.1_iphoneos-arm.deb`).

### 2. Installation on Device

#### For Jailbroken Devices (Rootful/Rootless):
- Transfer the `.deb` file to your device (via AirDrop, iCloud Drive, or SSH).
- Install it using a package manager like **Filza**, **Sileo**, or **Zebra**.
- Respring your device.

#### For Non-Jailbroken Devices (Sideloading):
1. **Get a Decrypted LINE IPA**: 
   - To analyze or inject tweaks, you need a decrypted version of the binary (FairPlay removal).
   - **For Research Purposes**: Tools like [ARMConverter Decrypted App Store](https://armconverter.com/decryptedappstore/jp) are often used by security researchers to obtain binaries for static analysis. 
2. **Inject and Sign**:
   - Use tools like [Sideloadly](https://sideloadly.io/), [Esddsign](https://github.com/khcrysalis/Esddsign), or [Feather](https://github.com/khcrysalis/Feather).
   - Add the `NezuLineMod.deb` (or the extracted `.dylib`) to the IPA and start the signing process.

---

## Cloud Injection (Automated IPA Injection)
You can inject this tweak into your IPA using GitHub's servers without needing a local Mac/PC.

### Detailed Steps to Run the Runner:

1. **Prepare a Direct IPA URL**:
   - Upload your decrypted IPA to a service like [bashupload.com](https://bashupload.com/).
   - Copy the link. 
   - **Verification**: Test the URL in your browser. If the download starts immediately without showing any website, it is a valid "Direct Link".

2. **Trigger the GitHub Action**:
   - At the top of this GitHub repository, click on the **"Actions"** tab.
   - In the left sidebar, click on the workflow named **"Build and Inject LINE Tweak"**.
   - You will see a blue bar. Click the **"Run workflow"** dropdown button on the right.
   - In the **"URL to your decrypted LINE IPA (Direct Link)"** field, paste your IPA URL.
   - Click the green **"Run workflow"** button.

3. **Retrieve your IPA**:
   - Wait a few minutes for the run to complete (green checkmark).
   - Click on the run name, then scroll down to **"Artifacts"**.
   - Download **`NezuLineMod_Injected_IPA`**. 

---

## Building from Source
This project uses Theos.
```bash
make package
```

## Customization & Research
If you want to add more features, you can modify `line-mod/Tweak.xm`. 

### 1. Ad Blocking (Concept)
Research targets: `LineAdsManager`, `LINEAdView`, `LNAAdContentsManager`.
```objectivec
%hook LNAAdContentsManager
- (BOOL)shouldShowAd { return NO; }
%end
```

### 2. No Read Receipt (Concept)
Research targets: `MessageService`, `sendReadReceipt`, `MessageCenter`.

### 3. Disable Message Unsending (Antidelete)
Research targets: `LINEMessageManager`, `didReceiveUnsendMessageNotification`.

## Using FLEX for Analysis
1. Build and inject **FLEX** into LINE.
2. Use the FLEX explorer to browse `jp.naver.line`'s internal classes and methods at runtime to find your own hooks.

## Disclaimer
This project is for educational and research purposes only. Using modified versions of apps may violate the terms of service of the original application creator. The developer is not responsible for any account bans or issues that may occur. Use at your own risk.
