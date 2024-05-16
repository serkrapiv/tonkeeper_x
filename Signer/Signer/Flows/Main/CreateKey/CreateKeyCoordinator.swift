import UIKit
import TKCoordinator
import SignerCore
import SignerLocalize

final class CreateKeyCoordinator: RouterCoordinator<NavigationControllerRouter> {
  
  var didFinish: (() -> Void)?
  var didCreateKey: (() -> Void)?
  
  private let assembly: SignerCore.Assembly
  
  init(router: NavigationControllerRouter,
       assembly: SignerCore.Assembly) {
    self.assembly = assembly
    super.init(router: router)
  }
  
  override func start() {
    openNameYourKey()
  }
}

private extension CreateKeyCoordinator {
  func openNameYourKey() {
    let module = EditWalletNameModuleAssembly.module(
      configurator: CreateEditWalletNameViewModelConfigurator(),
      defaultName: nil
    )
    module.view.setupLeftCloseButton { [weak self] in
      self?.didFinish?()
    }
    module.view.presentationMode = .sheet
    module.output.didEnterWalletName = { [weak self] walletName in
      self?.openEnterPassword(name: walletName)
    }
    router.push(viewController: module.view)
  }
  
  func openEnterPassword(name: String) {
    let configurator = EnterPasswordPasswordInputViewModelConfigurator(
      mnemonicsRepository: assembly.repositoriesAssembly.mnemonicsRepository(),
      title: SignerLocalize.Password.Confirmation.title
    )
    let module = PasswordInputModuleAssembly.module(configurator: configurator)
    module.view.setupBackButton()
    module.output.didEnterPassword = { [weak self] password in
      self?.createKey(name: name, password: password)
    }
    
    router.push(viewController: module.view,
                onPopClosures: {})
  }
  
  func createKey(name: String, password: String) {
    let keysAddController = assembly.keysAddController()
    do {
      try keysAddController.createWalletKey(name: name, password: password)
      didCreateKey?()
    } catch {
      print("Log: Key creation failed, error \(error)")
    }
  }
}
