# NezuLineMod

This is a simple LINE tweak based on an [example Qiita article](https://qiita.com/SsS136/items/9b7a290ba98070dccfd0).

## Features
- Disables the "News" tab in LINE, replacing it with the "Call" tab (or simply removing it).

## How to Install (Using GitHub Actions Artifacts)

1. **Download the Tweak**:
   - Go to the [Actions tab](https://github.com/nezumi0627/nezu-mod/actions) in this repository.
   - Click on the latest successful workflow run.
   - Scroll down to the **Artifacts** section and download `NezuLineMod_DEB`.
   - Extract the zip file to find the `.deb` file (e.g., `com.yourcompany.nezulinemod_0.0.1_iphoneos-arm.deb`).

2. **For Jailbroken Devices (Rootful/Rootless)**:
   - Transfer the `.deb` file to your device (via AirDrop, iCloud Drive, or SSH).
   - Install it using a package manager like **Filza**, **Sileo**, or **Zebra**.
   - Respring your device.

3. **For Non-Jailbroken Devices (Sideloading)**:
   - You need to inject this tweak into the LINE IPA.
   - **Tools needed**: [Sideloadly](https://sideloadly.io/), [Esddsign](https://github.com/khcrysalis/Esddsign), or [Feather](https://github.com/khcrysalis/Feather).
   - **Steps**:
     1. Get a decrypted LINE `.ipa` file (you may need to decrypt it yourself or find one).
     2. Open Sideloadly (or your preferred tool).
     3. Select the LINE IPA.
     4. In the "Tweaks/Dylibs" section, add the `NezuLineMod.dylib` (you might need to extract the `.deb` to find the `.dylib` inside `Library/MobileSubstrate/DynamicLibraries/`).
        - *Note*: Sideloadly can often accept `.deb` files directly.
     5. Start the signing/installation process.

## Building from Cource
This project uses Theos.
```bash
make package
```
