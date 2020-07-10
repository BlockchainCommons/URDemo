# URDemo

## An app to demonstrate sending and receiving of URs using URKit

by Wolf McNally and Christopher Allen<br/>
© 2020 Blockchain Commons

---

### Introduction

This app is written in Swift using SwiftUI. It demonstrates the use of [URKit](https://github.com/BlockchainCommons/URKit) to send and receive single-part and multi-part [Uniform Resources (URs)](https://github.com/BlockchainCommons/Research/blob/master/papers/bcr-2020-005-ur.md) via QR codes. Multi-part QR codes are generated using [Luby Transform code](https://en.wikipedia.org/wiki/Luby_transform_code) (fountain codes).

### Requirements

* Swift 5, iOS 13, and Xcode 11.5

### Building

* Open `URDemo.xcodeworkspace`, wait for the dependencies to resolve, and build the `URDemo` target for your iOS device.

### Screen Shots

**Main screen.** Either select the scenario for the message you want to send (messages are generated randomly), or tap the button at the bottom to receive a message.

![](Images/1.jpg)

**Sending screen.** A LifeHash displays a hash of the message being sent for easy recognition on the receiving side. The blue bar beneath the animated QR code shows the segments mixed into the currently displayed part. This is part of the fountain codes technique. The buttons below the QR code can be adjusted to show frames at a higher or lower rate.

You can use the circular arrow button in the upper-right to choose a new message and restart the transmission.

![](Images/2.jpg)

**Receiving screen.** You're seeing the sending device through the viewfinder. The blue bar beneath the viewfinder lights up in white to signify the complete parts of the message received so far, and also shows in light blue the fragments mixed in to the last received part. The progress bar at the very bottom shows an estimate of the expected completion percent.

You can use the circular arrow button in the upper-right to abort and restart the current receive, or start a new receive after the last one completes.

![](Images/3.jpg)

**Proper distance and framing.** For optimal transmission, you should try to make the sending QR code fill as much of the viewfinder as possible.

![](Images/4.jpg)

**Acknowledgement screen.** Appears on successfully receiving a message. The LifeHash displayed on the sending and receiving devices should match.

![](Images/5.jpg)
