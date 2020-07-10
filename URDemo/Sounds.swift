//
//  Sounds.swift
//  URDemo
//
//  Created by Wolf McNally on 7/7/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import Foundation

let beep1 = FeedbackGenerator(haptic: .heavy, soundFile: "beep1.mp3", subdirectory: "Sounds")
let beep2 = FeedbackGenerator(haptic: .heavy, soundFile: "beep2.mp3", subdirectory: "Sounds")
let beep3 = FeedbackGenerator(haptic: .heavy, soundFile: "beep3.mp3", subdirectory: "Sounds")
let beep4 = FeedbackGenerator(haptic: .success, soundFile: "beep4.mp3", subdirectory: "Sounds")
let beepError = FeedbackGenerator(haptic: .error, soundFile: "beepError.mp3", subdirectory: "Sounds")
let click = FeedbackGenerator(haptic: .light, soundFile: "click.caf", subdirectory: "Sounds")
