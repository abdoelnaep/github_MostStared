//
//  RepositoryCell.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import UIKit

class RepositoryCell: UITableViewCell {
    @IBOutlet var repositoryNameLabel: UILabel!

    @IBOutlet var repositoryDescriptionLabel: UILabel!

    @IBOutlet var repoStarzCountLabel: UILabel!

    @IBOutlet var repoIssuesCountLabel: UILabel!

    @IBOutlet var repoSubbmitLabel: UILabel!
    @IBOutlet var avatarImgView: UIImageView!

    // MARK: - Configure Cell

    func configureCell(with repositoryVM: RepoCellVM) {
        repositoryNameLabel.text = repositoryVM.name
        repositoryDescriptionLabel.text = repositoryVM.description
        repoStarzCountLabel.text = "Stars:\(repositoryVM.stargazers_count)"
        repoIssuesCountLabel.text = " Issues:\(repositoryVM.open_issues_count)"
        repoSubbmitLabel.text = "submitted \(repositoryVM.timePassedFromCreation) ago by \(repositoryVM.ownerName)"
        avatarImgView.fetchImageFromUrl(urlstring: repositoryVM.ownerAvatar) // using native Image from URL
    }
}
