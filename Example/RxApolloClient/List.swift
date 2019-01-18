//
//  List.swift
//  RxApolloClient_Example
//
//  Created by Kanghoon on 18/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

struct List<Element> {
    
    let query: String
    var items: [Element]
    var after: String?
    
    init(query: String, items: [Element], after: String? = nil) {
        self.query = query
        self.items = items
        self.after = after
    }
}
