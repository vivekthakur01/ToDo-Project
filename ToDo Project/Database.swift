//
//  Database.swift
//  ToDo Project
//
//  Created by Vivek Thakur on 21/11/19.
//  Copyright © 2019 Vivek Thakur. All rights reserved.
//

import Foundation
import UIKit
import CoreData



class Database {
    static var shareInstance = Database()
    private init() {
        
    }
    
    func getContext() -> NSManagedObjectContext? {
        guard  let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return nil
        }
        return context
    }
    
    func save(object:[String:Any]) {
        let invent = NSEntityDescription.insertNewObject(forEntityName: "Inventary", into: getContext()!) as? Inventary
        
        invent?.person = object["person"] as? String
        invent?.item = object["item"] as? String
        
        invent?.image = object["image"] as? NSData
        do{
           try getContext()!.save()
            print("success")
        }catch{
            print("failed")
        }
        
    }
    
    func fetchData() -> [Inventary] {
        
        var invent = [Inventary]()
        let request = NSFetchRequest<NSManagedObject>(entityName: "Inventary")
        do{
            invent = try getContext()?.fetch(request) as! [Inventary]
        }catch{
            print("failed in save")
        }
        return invent
        
    }
    
    func deleteData(index:Int) -> [Inventary]{
        
        var invent = fetchData()
        getContext()?.delete(invent[index])
        invent.remove(at: index)
        do{
           try getContext()?.save()
        }catch{
            print("failed")
        }
        return invent
    }
    
    func editData(object:[String:Any],i:Int){
        
       var invent = fetchData()
        invent[i].person = object["person"] as? String
        invent[i].item = object["item"] as? String
        invent[i].image = object["image"] as? NSData
        do{
           try getContext()?.save()
        }catch{
            print("data not save")
        }
    }
    
}
