//
//  File.swift
//  File
//
//  Created by Zach Vandervelden on 8/25/21.
//

import Foundation
import Vapor

struct UserController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        let userRoute = routes.grouped("api", "users")
        userRoute.post(use: createHandler)
        userRoute.get(use: getAllHandler)
        userRoute.get(":userID", use: getHandler)
        userRoute.get(":userID", "acronyms", use: getAcronymsHandler)
    }
    
    func createHandler(_ req: Request) throws -> EventLoopFuture<User>{
        let user = try req.content.decode(User.self)
        return user.save(on: req.db).map{user}
    }
    func getAllHandler(_ req: Request) throws -> EventLoopFuture<[User]>{
        User.query(on: req.db).all()
    }
    func getHandler(_ req: Request) throws -> EventLoopFuture<User>{
        User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    func getAcronymsHandler(_ req: Request) throws -> EventLoopFuture<[Acronym]>{
        User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { user in
                user.$acronyms.get(on: req.db)
            }
    }
}
