//
//  AppDelegate.swift
//  emojiping
//
//  Created by Steven Merrill on 6/7/14.
//  Copyright (c) 2014 Steven Merrill. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate, CDZPingerDelegate {
    @IBOutlet var statusMenu : NSMenu!
    var statusItem: NSStatusItem!

    var pinger = CDZPinger(host: "8.8.4.4")

    let goodEmoji = "😃"
    let okayEmoji = "😐"
    let badEmoji = "😡"

    let restartTimeout = 1.0
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
        self.statusItem.title = self.goodEmoji
        self.statusItem.highlightMode = true
        self.statusItem.menu = self.statusMenu

        self.pinger.delegate = self
        self.startPinging()
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        self.stopPinging()
    }

    func updateItem(seconds: NSTimeInterval) {
        // The pinger may come back before our NSStatusItem is ready. Don't let it.
        if let item = self.statusItem {
            // Under 300ms ping is good.
            if seconds < 0.3 {
                item.title = self.goodEmoji
            }
            else if seconds > 3.0 {
                item.title = self.badEmoji
            }
            else {
                item.title = self.okayEmoji
            }
        }
    }

    func startPinging() {
        self.pinger.startPinging()
    }

    func stopPinging() {
        self.pinger.stopPinging()
    }
    
    // CDZPingerDelegate protocol implementations

    /**
    * Called every time the pinger receives a ping back from the server.
    *
    * @param pinger This CDZPinger object
    * @param seconds The average ping time, in seconds
    */
    func pinger(pinger: CDZPinger, didUpdateWithAverageSeconds: NSTimeInterval) {
        self.updateItem(didUpdateWithAverageSeconds)
    }

    /**
    * Reports a ping error.
    *
    * Note: The pinger stops running after any error is encountered.
    *
    * @param pinger This CDZPinger object
    * @param error The NSError that was encountered
    */
    func pinger(pinger: CDZPinger, didEncounterError: NSError) {
        // Force a bad result.
        self.updateItem(100.0)

        // Wait 1 second, then restart the pinger.
        var timer = NSTimer.scheduledTimerWithTimeInterval(self.restartTimeout, target: self, selector: Selector("startPinging"), userInfo: nil, repeats: false)
    }
}
