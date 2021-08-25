//
//  File.swift
//  File
//
//  Created by Zach Vandervelden on 8/25/21.
//

import Foundation
import Fluent
import Vapor

final class User: Model, Content{
    static let schema: String = "users"
    
    @ID
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "username")
    var username: String
    
    @Children(for: \.$user)
    var acronyms: [Acronym]
    init(){}
    
    init(id: UUID? = nil, name: String, username: String){
        self.id = id
        self.name = name
        self.username = username
    }
}
