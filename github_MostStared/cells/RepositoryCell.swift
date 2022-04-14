//
//  RepositoryCell.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import UIKit

class RepositoryCell: UITableViewCell {
    var dayesPassed = 0
    @IBOutlet var repositoryNameLabel: UILabel!
    
    @IBOutlet var repositoryDescriptionLabel: UILabel!
    
    @IBOutlet var repoStarzCountLabel: UILabel!
    
    @IBOutlet var repoIssuesCountLabel: UILabel!
    
    @IBOutlet var repoSubbmitLabel: UILabel!
    @IBOutlet var avatarImgView: UIImageView!

    // MARK: - Configure Cell
    
    func configureCell(with repository: repoElement) {
        repositoryNameLabel.text = repository.name!
        repositoryDescriptionLabel.text = repository.description
        repoStarzCountLabel.text = "Stars:\(repository.stargazers_count ?? 0)"
        repoIssuesCountLabel.text = "Issues:\(repository.open_issues_count ?? 0)"
        repoSubbmitLabel.text = "\(repository.updated_at ?? "") by \(repository.owner.login ?? "")"
//        avatarImgView.fetchImageFromUrl(repository.owner.avatar_url ?? "")
        avatarImgView.loadfromURL(repository.owner.avatar_url)
    }
}
