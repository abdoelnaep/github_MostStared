//
//  RepositoriesModel.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import Foundation


//struct Repository: Codable {
//    let name: String?
//}


//struct Repositories:Codable{
//    let repoElement:items
//}
//
//
struct repos:Codable{
    let items:[repoElement]
}

struct repoElement:Codable{
    let full_name:String?
    let name:String?

}
