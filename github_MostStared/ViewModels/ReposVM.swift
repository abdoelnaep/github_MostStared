//
//  ReposVM.swift
//  github_MostStared
//
//  Created by Abdullah on 22/04/2022.
//

import Foundation
class ReposVM {
    var repos: [RepoCellVM] = []
    let repoService: APIProtocol
    
    init(repoService: APIProtocol = APIService()) {
        self.repoService = repoService
    }
    
    
    func getTargetDate()->String {
        var targetDay: Date = .init()
        var dateString:String

        
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = -30
        targetDay = Calendar.current.date(byAdding: dateComponent, to: currentDate)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.locale = Locale(identifier: "en")

        dateString = dateFormatter.string(from: targetDay)
//        print(dateString)
        return dateString
    }
    
    func getReps(pageNumber: String, completion: @escaping ([RepoCellVM]?, Error?) -> Void) {
        repoService.getRepositories(pageNum: pageNumber, past30Days: getTargetDate(), completion: {
            result in
            switch result {
                case .success(let repos):
                    self.repos += repos.items.map {
                        let repoCell = RepoCellVM($0)
                        return repoCell
                    }
                    completion(self.repos, nil)
                case .failure(let error):
                    completion(nil, error)
            }
        
        })
    }
    func numbOfRows() -> Int{
            return repos.count
        }
        
        
        func repoIndex(at indexPath: IndexPath) -> RepoCellVM{
            return repos[indexPath.row]
        }
}
    
class RepoCellVM {
    
    private let repo: RepoElement
        
        init(_ repo: RepoElement) {
            self.repo = repo
        }
    
    var name:String{
            return self.repo.name ?? ""
        }
    
    var description:String{
            return self.repo.description ?? ""
        }
    var stargazers_count:Int{
            return self.repo.stargazers_count ?? 0
        }
    var open_issues_count:Int{
            return self.repo.open_issues_count ?? 0
        }
    
    var updated_at:String{
            return self.repo.updated_at ?? ""
        }
    var created_at:String{
            return self.repo.created_at ?? ""
        }
    
    
    var ownerAvatar:String{
        return self.repo.owner.avatar_url ?? ""
        }
    var ownerName:String{
        return self.repo.owner.login ?? ""
        }
    
    
    
    var timePassedFromCreation:String{
        
        let submittedDate = repo.created_at ?? ""

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: submittedDate)!

            let now = Date()
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            formatter.allowedUnits = [.day]
            return  formatter.string(from: date, to: now)!
        
        
    }
    

    
}
