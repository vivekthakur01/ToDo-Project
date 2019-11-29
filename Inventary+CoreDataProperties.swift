//
//  Inventary+CoreDataProperties.swift
//  ToDo Project
//
//  Created by Vivek Thakur on 22/11/19.
//  Copyright © 2019 Vivek Thakur. All rights reserved.
//
//

import Foundation
import CoreData


extension Inventary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Inventary> {
        return NSFetchRequest<Inventary>(entityName: "Inventary")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var item: String?
    @NSManaged public var person: String?

}
