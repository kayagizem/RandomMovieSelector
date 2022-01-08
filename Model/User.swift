//
//  User.swift
//  RandomMovieSelector
//
//  Created by gizem.kaya on 2.01.2022.
//

import Foundation

struct User: Decodable
{
    var username: String
    var password: String
    var userId: Int
}
