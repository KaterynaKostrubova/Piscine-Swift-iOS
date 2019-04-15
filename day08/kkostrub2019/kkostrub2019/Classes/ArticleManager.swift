//
//  ArticleManager.swift
//  kkostrub2019
//
//  Created by Kateryna KOSTRUBOVA on 4/12/19.
//

import UIKit
import Foundation
import CoreData

public class ArticleManager: NSObject {
    var managedObjectContext: NSManagedObjectContext
    
    public override init() {

        guard let modelURL = Bundle.init(for: Article.self).url(forResource: "article", withExtension: "momd")
            else {
                fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        queue.async {
            guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                fatalError("Unable to resolve document directory")
            }
            let storeURL = docURL.appendingPathComponent("article.sqlite")
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
                //The callback block is expected to complete the User Interface and therefore should be presented back on the main queue so that the user interface does not need to be concerned with which queue this call is coming from.
//                DispatchQueue.main.sync(execute: completionClosure)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    
    public func newArticle()-> Article {
        let new = NSEntityDescription.insertNewObject(forEntityName: "Article", into: managedObjectContext) as! Article
        return new
    }
    
//    public func getAllArticle() -> [Article]{
//        return
//    }
//
//    public func getArticles(WithLang lang:String) -> [Article]{
//        return
//    }
//
//    public func getArticles(containString str:String) -> [Article]{
//       return
//    }
//
//    public func removeArticle(article:Article){
//       return
//    }
//
    public func save(){
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
}
