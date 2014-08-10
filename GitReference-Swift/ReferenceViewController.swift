//
//  ReferenceViewController.swift
//  GitReference-Swift
//
//  Created by Joshua Howland on 8/10/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

import UIKit

class ReferenceViewController: UIViewController {
    
    let margin: CGFloat = 15
    let Command: String = "command"
    let Reference: String = "reference"
    
    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: CGRectMake(0, 20.0, self.view.frame.size.width, self.view.frame.size.height - 20.0))
        self.view.addSubview(scrollView!)
        
        var topMargin: CGFloat = 20.0
        var widthMinusMargin: CGFloat = self.view.frame.size.width - (2.0 * margin)
        
        var title: UILabel = UILabel(frame: CGRectMake(margin, topMargin, widthMinusMargin, 20));
        title.font = UIFont.boldSystemFontOfSize(20)
        title.text = "GitReference"
        scrollView?.addSubview(title)
        
        var top: CGFloat = topMargin + 20.0 + margin * 2.0
        
        for gitCommand in self.gitCommands() {
            
            var command = gitCommand[Command]
            var reference = gitCommand[Reference]
            
            var gitCommand: UILabel = UILabel(frame: CGRectMake(margin, top, widthMinusMargin, 20))
            gitCommand.font = self.commandFont()
            gitCommand.text = command
            scrollView?.addSubview(gitCommand)
            
            top += (20.0 + margin)
            
            var gitReference: UILabel = UILabel(frame: CGRectMake(margin, top, widthMinusMargin, self.heightOfReferenceString(reference!, constrainedToWidth: widthMinusMargin)))
            gitReference.font = self.referenceFont()
            gitReference.numberOfLines = 0
            gitReference.text = reference
            scrollView?.addSubview(gitReference)
            
            top += (self.heightOfReferenceString(reference!, constrainedToWidth: widthMinusMargin) + (margin * 2.0))
            
        }
        
        scrollView?.contentSize = CGSizeMake(self.view.frame.size.width, top)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gitCommands() -> Array<[String: String]> {
        
        var commands = [[String: String]]()
        
        commands.append([Command: "git status", Reference: ": shows changed files"])
        commands.append([Command: "git diff", Reference: ": shows actual changes"])
        commands.append([Command: "git add .", Reference: ": adds changed files to the commit"])
        commands.append([Command: "git commit -m \"notes\"", Reference: ": commits the changes"])
        commands.append([Command: "git push origin _branch_", Reference: ": pushes commits to branch named _branch_"])
        commands.append([Command: "git log", Reference: ": displays progress log"])
        commands.append([Command: "git comment --amend", Reference: ": re-enter last commit message"])
        
        return commands
    }
    
    
    func heightOfReferenceString(string: String, constrainedToWidth width: CGFloat) -> CGFloat {
        return (string as NSString).boundingRectWithSize(CGSize(width: width, height: 100.0),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: self.referenceFont()],
            context: nil).size.height
    }
    
    func commandFont() -> UIFont {
        return UIFont.boldSystemFontOfSize(17)
    }
    
    func referenceFont() -> UIFont {
        return UIFont.systemFontOfSize(15)
    }
    
}

