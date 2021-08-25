//
//  File.swift
//  File
//
//  Created by Zach Vandervelden on 8/25/21.
//

import Foundation
import FluentKit

struct CreateAcronymCategoryPivot: Migration{
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(AcronymCategoryPivot.schema)
            .id()
            .field("acronymID", .uuid, .required, .references("acronyms", "id", onDelete: .cascade))
            .field("categoryID", .uuid, .required, .references("categories", "id", onDelete: .cascade))
            .create()
        
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(AcronymCategoryPivot.schema).delete()
    }
}
