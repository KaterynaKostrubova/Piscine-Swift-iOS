//
//  Article+CoreDataProperties.swift
//  kkostrub2019
//
//  Created by Kateryna KOSTRUBOVA on 4/12/19.
//
//

import UIKit
import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var content: String?
    @NSManaged public var create: NSDate?
    @NSManaged public var image: NSData?
    @NSManaged public var language: String?
    @NSManaged public var modification: NSDate?
    @NSManaged public var title: String?
    
    override public var description: String{
        return "[\(title!): \(content!) Created:\(create!) Language:\(language!) Modification:\(modification!)]"
    }

}
