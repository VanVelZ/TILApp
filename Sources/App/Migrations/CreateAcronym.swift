//
//  File.swift
//  File
//
//  Created by Zach Vandervelden on 8/25/21.
//

import Fluent

struct CreateAcronym: Migration{
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("acronyms")
            .id()
            .field("short", .string, .required)
            .field("long", .string, .required)
            .field("userID", .uuid, .required, .references(User.schema, "id"))
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("acronyms").delete()
    }
}
