//
//  GridViewController.swift
//  InkKit
//
//  Created by Shahpour Benkau on 11/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import AppKit

final class GridViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        /**
         Lets define the problem domain first.
         
         Its cumbersome to always have to create a new collection view layout, even if its based on a flow layout.
         Also, what if I wanted to extend this kind of layout abstraction to other parts of my user interface?
         
         It would be great to have some Convenience methods for generating common grid based layouts.
         With the ease of generating new ones as well.
         
         Lets focus on column based layouts first since they are the most common.s
         
         DSL:
         
         layout.appendSection { section in
             section.headerHeight = 20
             section.footerHeight = 20
             section.itemCount = 41
         }
         
         let attributes = layout.attributes { indexPath in
             return 44
         }
         
         attributes[0].frame
         
         */
        
    }
    
}
