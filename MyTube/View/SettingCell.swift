import UIKit

class SettingCell: BaseCell {
  override var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ? .darkGray : .white
      nameLabel.textColor = isHighlighted ? .white : .black
      iconImageView.tintColor = isHighlighted ? .white : .darkGray
      
      // true when pressed, false when released
      // print(isHighlighted)
    }
  }
  
  var setting: Setting? {
    didSet {
      nameLabel.text = setting?.name
      
      if let imageName = setting?.imageName {
        iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .darkGray
      }
    }
  }
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Settings"
    label.font = UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "settings")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(nameLabel)
    addSubview(iconImageView)
    addConstraintWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
    addConstraintWithFormat(format: "V:|[v0]|", views: nameLabel)
    addConstraintWithFormat(format: "V:[v0(30)]", views: iconImageView)
    addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
}
