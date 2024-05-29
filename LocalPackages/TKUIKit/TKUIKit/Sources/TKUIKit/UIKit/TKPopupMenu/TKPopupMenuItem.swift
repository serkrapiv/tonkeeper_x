import UIKit

public struct TKPopupMenuItem {
  public let title: String
  public let value: String?
  public let description: String?
  public let icon: UIImage?
  public let selectionHandler: (() -> Void)?
  
  public init(title: String, value: String?, description: String?, icon: UIImage?, selectionHandler: (() -> Void)?) {
    self.title = title
    self.value = value
    self.description = description
    self.icon = icon
    self.selectionHandler = selectionHandler
  }
}
