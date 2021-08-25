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
