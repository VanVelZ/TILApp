//
//  File.swift
//  File
//
//  Created by Zach Vandervelden on 8/25/21.
//

import Foundation
import Fluent

final class AcronymCategoryPivot: Model{
    static let schema = "acronym-category"
    
    @ID
    var id: UUID?
    
    @Parent(key: "acronymID")
    var acronym: Acronym
    
    @Parent(key: "categoryID")
    var category: Category
    
    init(){}
    
    init(id: UUID? = nil, acronym: Acronym, category: Category) throws{
        self.id = id
        self.$acronym.id = try acronym.requireID()
        self.$acronym.id = try acronym.requireID()
    }
}
