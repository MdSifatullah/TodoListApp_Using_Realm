//
//  Task.swift
//  TodoListApp
//
//  Created by Md Sifat on 3/4/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import RealmSwift

class Task : Object{
    @objc dynamic var id = Int()
    @objc dynamic var name = String()
    @objc dynamic var isDone = Bool()
   // let catagory = LinkingObjects(fromType: Catagory.self, property: "tasks")
}
