# SelfieIBK
SelfieFBK is framework for taking pictures specifc (selfie) 
for example to identify client image 
you don't need to learn about camera or avfoundation you just press the button or action 
then moduale will apper take your photo and set it or retake it if you don't like it as you set it the image will send to you
to use it wherever you want
[![CI Status](https://img.shields.io/travis/khaled bakar/SelfieIBK.svg?style=flat)](https://travis-ci.org/khaled bakar/SelfieIBK)
[![Version](https://img.shields.io/cocoapods/v/SelfieIBK.svg?style=flat)](https://cocoapods.org/pods/SelfieIBK)
[![License](https://img.shields.io/cocoapods/l/SelfieIBK.svg?style=flat)](https://cocoapods.org/pods/SelfieIBK)
[![Platform](https://img.shields.io/cocoapods/p/SelfieIBK.svg?style=flat)](https://cocoapods.org/pods/SelfieIBK)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SelfieIBK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SelfieIBK'
```
## Usage
-you drag the framework in your project and embed it and sign from general taget .
-in the plist put camera access permission (Privacy-Camera Usage Description).
-in your viewcontoller you will use it : 
first you should 
```ruby
import SelfieFBK
```
then,use delegate (CaptureOutputPhotoDelegate) to receive the image and implement the func that had.
at the end,in action or button you will use the frame work put that code 
```ruby
 { 
       let cap = CaptureVC()
        cap.cDelegate = self
        let nav = UINavigationController(rootViewController: cap)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
 }
```
that code is tied delgate your viewcontroller to framework to know that controller should had delgeation and implement it
Note:-
present or navigationcontroller is for example you can change it as you want


## Author

khaled bakar, khaledbakar7@gmail.com

## License

SelfieIBK is available under the MIT license. See the LICENSE file for more info.
