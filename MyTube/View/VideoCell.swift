import UIKit

class VideoCell: BaseCell {
  
  var video: Video? {
    didSet {
      
      titleLabel.text = video?.title
      
      if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
        
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        
        let subtitleText = "\(channelName) - \(numberFormater.string(from: numberOfViews)!) - 2 years ago"
        subtitleTextView.text = subtitleText
      }
      
//      if let thumbnainImage = video?.thumbnailImage {
//        thumbnailImageView.image = UIImage(named: thumbnainImage)
//      }
      
      setupThumbnailImage()
      
      setupProfileImage()
      
//      if let profileImageName = video?.channel?.profileImageName {
//        userProfileImageView.image = UIImage(named: profileImageName)
//      }
      
      // could crash
      // userProfileImageView.image = UIImage(named: (video?.channel?.profileImageName)!)
      
      // measure title text, for long texts -> 2 lines
      if let title = video?.title {
        let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        if let fontStyle = UIFont(name: "HelveticaNeue-Light", size: 14) {
          let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: fontStyle], context: nil)
          if estimatedRect.size.height > 20 {
            titleLabelHeightConstraint?.constant = 44
          } else {
            titleLabelHeightConstraint?.constant = 20
          }
        }
      }
    }
  }
  
  func setupProfileImage() {
    if let profileImageUrl = video?.channel?.profileImageName {
      userProfileImageView.loadImageUsing(urlString: profileImageUrl)
      
    }
  }
  
  func setupThumbnailImage() {
    if let thumbnailImageUrl = video?.thumbnailImage {
      thumbnailImageView.loadImageUsing(urlString: thumbnailImageUrl)
    }
  }

  let thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "joseph")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let userProfileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "jotaro")
    imageView.layer.cornerRadius = 22
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    return view
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "The Bangles - Walk Like an Egyptian"
    label.numberOfLines = 2
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let subtitleTextView: UITextView = {
    let textView = UITextView()
    textView.text = "TheBanglesVEVO * 31M views * 4 years ago"
    textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
    textView.textColor = .lightGray
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  
  var titleLabelHeightConstraint: NSLayoutConstraint?
  
  override func setupViews() {
    addSubview(thumbnailImageView)
    addSubview(separatorView)
    addSubview(userProfileImageView)
    addSubview(titleLabel)
    addSubview(subtitleTextView)
    
    addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
    addConstraintWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
    addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
    addConstraintWithFormat(format: "H:|[v0]|", views: separatorView)
    
    // constraints for titleLabel and subtitleTextView
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
    addConstraint(titleLabelHeightConstraint!)
    
    // constraints for subtitleTextView
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
  }
}
