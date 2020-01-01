//
//  TodoListItem.swift
//  TodoListApp
//
//  Created by Md Sifat on 1/1/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import RealmSwift

class TodoListItem: Object {
    @objc dynamic var name = ""
    @objc dynamic var done = false
}
