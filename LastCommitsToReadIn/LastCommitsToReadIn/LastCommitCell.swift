//
//  LastCommitCell.swift
//  LastCommitsToReadIn
//
//  Created by Edgar Jr on 12/13/20.
//

import UIKit

class LastCommitCell: UITableViewCell
{
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var hashLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func setUpUsing(_ commit: Commit)
    {
        authorLabel.text = "Author: " + commit.commitAuthor
        hashLabel.text = "Hash: " + commit.commitHash
        messageLabel.text = "Message: " + commit.commitMessage
    }
}
