//
//  CommitDetailsViewController.swift
//  LastCommitsToReadIn
//
//  Created by Edgar Jr on 12/13/20.
//

import UIKit

class CommitDetailsViewController: UIViewController
{
    @IBOutlet weak var detailsAuthorLabel: UILabel!
    @IBOutlet weak var detailsHashLabel: UILabel!
    @IBOutlet weak var detailsMessageLabel: UILabel!
    var commit = Commit.init()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        detailsAuthorLabel.text = "Author: " + commit.commitAuthor
        detailsHashLabel.text = "Hash: " + commit.commitHash
        detailsMessageLabel.text = "Message: " + commit.commitMessage
    }
}
