//
//  CustomSearchBar.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/23/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    var preferredFont: UIFont = UIFont.systemFont(ofSize: 34)
    
    var preferredTextColor = UIColor(red: 20/270, green: 23/270, blue: 26/270, alpha: 1)
    
    init(frame: CGRect, font: UIFont, textColor: UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        preferredFont = font
        preferredTextColor = textColor
        barTintColor = UIColor.black
        
        
        searchBarStyle = UISearchBarStyle.prominent
        isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        // Find the index of the search field in the search bar subviews.
        if let index = indexOfSearchFieldInSubviews() {
            // Access the search field
            let searchField: UITextField = (subviews[0]).subviews[index] as! UITextField
            
            // Set its frame.
            
            searchField.frame = CGRect(x: 5, y: 5, width: frame.size.width - 10, height: 75)
            
            // Set the font and text color of the search field.
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            searchField.tintColor = UIColor.black
            
            
            // Set the background color of the search field.
            searchField.backgroundColor = barTintColor
        }
        
        super.draw(rect)
    }
    
    
    func indexOfSearchFieldInSubviews() -> Int! {
        var index: Int!
        let searchBarView = self.subviews[0]
        
        for i in 0 ..< searchBarView.subviews.count {
            if searchBarView.subviews[i].isKind(of: UITextField.self){
                index = i
                break
            }
        }
        
        return index
        

}
}
