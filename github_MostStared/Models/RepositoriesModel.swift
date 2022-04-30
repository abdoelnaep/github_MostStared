//
//  RepositoriesModel.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import Foundation

struct Repos:Codable{
    let items:[RepoElement]
}

struct RepoElement:Codable{
    let name:String?
    let description:String?
    let stargazers_count:Int?
    let open_issues_count:Int?
    let updated_at:String?
    let created_at:String?
    let owner:OwnerData

}

struct OwnerData:Codable{
    let login:String?
    let avatar_url:String?
}

