//
//  Movie.swift
//  RandomMovieSelector
//
//  Created by Özgün Irmak on 27.12.2021.
//

import Foundation

struct Movie: Decodable
{
    let adult: Bool
    let backdrop_path: String //path to image
    let genre_ids: [Int: Int]
    let Id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String //path to image
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
    
}
