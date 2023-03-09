# Config

Three APK download websites are supported and adding a new app is as easy as this:
```toml
[Some-App]
apkmirror-dlurl = "https://www.apkmirror.com/apk/inc/app"
```
or:
```toml
[Some-App]
uptodown-dlurl = "https://app.en.uptodown.com/android"
```
or:
```toml
[Some-App]
apkmonk-dlurl = "https://www.apkmonk.com/app/com.app.app/"
```

## If you'd like to get to know more about other options:

There exists an example below with all defaults shown and all the keys explicitly set.  
**All keys are optional** (except download urls) and are assigned to their default values if not set explicitly.  

```toml
patches-source = "inotia00/revanced-patches" # where to fetch patches bundle from. default: "inotia00/revanced-patches"
integrations-source = "inotia00/revanced-integrations" # where to fetch integrations from. default: "inotia00/revanced-integrations"
rv-brand = "ReVanced Extended" # rebrand from 'ReVanced' to something different. default: "ReVanced Extended"

patches-version = "v2.160.1" # locks the patches version. default: latest available
integrations-version = "v0.95.1" # locks the integrations version. default: latest available

[Some-App]
app-name = "SomeApp" # if set, release name becomes SomeApp instead of Some-App. default is same as table name, which is 'Some-App' here.
enabled = true # whether to build the app. default: true
build-mode = "both" # 'both', 'apk' or 'module'. default: apk
allow-alpha-version = false # allow downloading alpha versions from apkmirror. default: false
excluded-patches = "some-patch" # whitespace seperated list of patches to exclude. default: "" (empty)
included-patches = "patch-name" # whitespace seperated list of patches to include, all default patches are included by default. default: "" (empty)
version = "auto" # 'auto', 'latest' or a custom one e.g. '17.45.36'. 'auto' option gets the latest version that is supported by the patches. default: auto
exclusive-patches = false # exclude all patches by default. default: false
apkmirror-dlurl = "https://www.apkmirror.com/apk/inc/app" # download url. if not set, uptodown dl url is used.
uptodown-dlurl = "https://spotify.en.uptodown.com/android" # uptodown url. if not set, apkmirror dl url is used. apkmirror is prioritized
module-prop-name = "some-app-magisk" # magisk module prop name. not required.
merge-integrations = false # merge integrations. used if cant be auto detected. default: false
dpi = "360-480dpi" # used to select apk variant from apkmirror. default: nodpi
arch = "arm64-v8a" # 'arm64-v8a', 'arm-v7a' or 'all'. default: all
# arch option is sometimes needed to be able to download the apks from apkmirror.
# and does not affect anything else
```

# Building ReVanced
Use the [original project](https://github.com/j-hc/revanced-magisk-module) instead of my fork.
