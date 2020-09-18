# OpenSSL Playground with Objective-C
Interfacing from Swift to OpenSSL was possible.  But it was also messy, compared to Objective-C.

## OpenSSL-Universal
This project leveraged the `OpenSSL-Universal` from `CocoaPods`.

`OpenSSL-Universal` sped up development as it allowed focus on `OpenSSL` and not writing build scripts to get   `OpenSSL` libraries building for `macOS`, `iOS Simulators` and `ios ARM phones`.

### Dependency setup
On MacOS 10.15 Catalina:
```
brew install cocoapods --build-from-source
brew link --overwrite cocoapods
pod init  ( inside folder with xCode project)
open Podfile
pod 'OpenSSL-Universal'
pod install
```
Alternatively, you could install `Cocoapods` with the `gem` package manager.
