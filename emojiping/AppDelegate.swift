//
//  AppDelegate.swift
//  emojiping
//
//  Created by Steven Merrill on 6/7/14.
//  Copyright (c) 2014 Steven Merrill. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet var statusMenu : NSMenu

    var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        self.statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(CGFloat(NSVariableStatusItemLength))
        self.statusItem!.title = "😃";
        self.statusItem!.highlightMode = true;
        self.statusItem!.menu = self.statusMenu
    }
    
    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }
    
    //var str = "Hello, playground"
    //
    //var statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(CGFloat(NSVariableStatusItemLength))
    //
    //// The text that will be shown in the menu bar
    //
    //
    //// The image gets a blue background when the item is selected
}

