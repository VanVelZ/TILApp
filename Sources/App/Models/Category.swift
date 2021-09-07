//
//  File.swift
//  File
//
//  Created by Zach Vandervelden on 8/25/21.
//

import Foundation
import Fluent
import Vapor

final class Category: Model, Content{
    static let schema: String = "categories"
    
    @Siblings(through: AcronymCategoryPivot.self, from: \.$category, to: \.$acronym)
    var acronyms: [Acronym]
    
    @ID
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    init(){}
    
    init(id: UUID? = nil, name: String){
        self.id = id
        self.name = name
    }
}
extension Category {
    static func addCategory(_ name: String,
                            to acronym: Acronym,
                            on req: Request)
    -> EventLoopFuture<Void> {
        //Search for category with the name provided
        return Category.query(on: req.db)
            .filter(\.$name == name)
            .first()
            .flatMap { foundCategory in
                if let existingCategory = foundCategory {
                    //If the category exists, set up the relationship
                    return acronym.$categories
                        .attach(existingCategory, on: req.db)
                } else {
                    //The category does not exists so create a new one and set relationship
                    let category = Category(name: name)
                    return category.save(on: req.db).flatMap {
                        acronym.$categories.attach(category, on: req.db)
                    }
                }
            }
    }
}
