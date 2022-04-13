//
//  RepositoryCell.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var repositoryNameLabel: UILabel!
    
    //MARK: - Configure Cell
    func configureCell(with repository: repoElement) {
        repositoryNameLabel.text = repository.full_name
    
    }
    
}
