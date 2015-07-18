//
//  ViewModeManager.swift
//  Evdel
//
//  Created by Sash Zats on 7/18/15.
//  Copyright © 2015 Sash Zats. All rights reserved.
//

import AppKit


public let ViewModeManagerDidChangeModeNotification = "ViewModeManagerDidChangeModeNotification"

public enum ViewMode: Int {
    case Left = 0, Both = 1, Right = 2
}

public class ViewModeManager {
    public static let sharedManager = ViewModeManager()
    
    internal(set) public var mode: ViewMode = .Both {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(ViewModeManagerDidChangeModeNotification, object: self)
        }
    }
}


extension WindowController {
    
    @IBAction func viewModeSegmentedControlAction(sender: NSSegmentedControl) {
        if let mode = ViewMode(rawValue: sender.selectedSegment) {
            ViewModeManager.sharedManager.mode = mode
            selectMenuWithTag(sender.selectedSegment)
        }
    }
    
    @IBAction func viewModeMenuAction(menu: NSMenuItem) {
        selectMenuItem(menu)
        menu.state = NSOnState
        viewModeSegmentedControl.selectedSegment = menu.tag
        if let mode = ViewMode(rawValue: menu.tag) {
            ViewModeManager.sharedManager.mode = mode
        }
    }
    
    private func selectMenuWithTag(tag: Int) {
        for menu in viewMenu.submenu!.itemArray {
            menu.state = menu.tag == tag ? NSOnState : NSOffState
        }
    }
    
    private func selectMenuItem(selectedMenuItem: NSMenuItem) {
        for menu in viewMenu.submenu!.itemArray {
            menu.state = menu == selectedMenuItem ? NSOnState : NSOffState
        }
    }
    
}