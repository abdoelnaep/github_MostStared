//
//  RepositoryCell.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import UIKit

class RepositoryCell: UITableViewCell {
    var daysfromsubmit: String = ""
    @IBOutlet var repositoryNameLabel: UILabel!
    
    @IBOutlet var repositoryDescriptionLabel: UILabel!
    
    @IBOutlet var repoStarzCountLabel: UILabel!
    
    @IBOutlet var repoIssuesCountLabel: UILabel!
    
    @IBOutlet var repoSubbmitLabel: UILabel!
    @IBOutlet var avatarImgView: UIImageView!

    // MARK: - Configure Cell
    
    func configureCell(with repository: repoElement) {
        getSubmittedDays()

        repositoryNameLabel.text = repository.name!
        repositoryDescriptionLabel.text = repository.description
        repoStarzCountLabel.text = "Stars:\(repository.stargazers_count ?? 0)"
        repoIssuesCountLabel.text = " Issues:\(repository.open_issues_count ?? 0)"
        repoSubbmitLabel.text = "submitted \(daysfromsubmit) ago by \(repository.owner.login ?? "")"
        avatarImgView.fetchImageFromUrl(urlstring: repository.owner.avatar_url ?? "")  //using native Image from URL
//        avatarImgView.loadfromURL(repository.owner.avatar_url)   //using SDWebimage Image from URL
        
        func getSubmittedDays() {
            let submittedDate = repository.created_at

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: submittedDate!)!

            let now = Date()
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            formatter.allowedUnits = [.day]
            daysfromsubmit = formatter.string(from: date, to: now)!
            
//            print(daysfromsubmit)
//
//            print("cool")
        }
    }
}
