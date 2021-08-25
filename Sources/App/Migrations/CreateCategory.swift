//
//  File.swift
//  File
//
//  Created by Zach Vandervelden on 8/25/21.
//

import Foundation
import FluentKit

struct CreateCategory: Migration{
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Category.schema)
            .id()
            .field("name", .string, .required)
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Category.schema).delete()
    }
}
