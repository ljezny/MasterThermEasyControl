//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try font.validate()
    try intern.validate()
  }
  
  /// This `R.font` struct is generated, and contains static references to 2 fonts.
  struct font: Rswift.Validatable {
    /// Font `SFProDisplay-Medium`.
    static let sfProDisplayMedium = Rswift.FontResource(fontName: "SFProDisplay-Medium")
    /// Font `SFProDisplay-Thin`.
    static let sfProDisplayThin = Rswift.FontResource(fontName: "SFProDisplay-Thin")
    
    /// `UIFont(name: "SFProDisplay-Medium", size: ...)`
    static func sfProDisplayMedium(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sfProDisplayMedium, size: size)
    }
    
    /// `UIFont(name: "SFProDisplay-Thin", size: ...)`
    static func sfProDisplayThin(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sfProDisplayThin, size: size)
    }
    
    static func validate() throws {
      if R.font.sfProDisplayMedium(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SFProDisplay-Medium' could not be loaded, is 'SF-Pro-Display-Medium.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.sfProDisplayThin(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SFProDisplay-Thin' could not be loaded, is 'SF-Pro-Display-Thin.otf' added to the UIAppFonts array in this targets Info.plist?") }
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 3 images.
  struct image {
    /// Image `ic_home`.
    static let ic_home = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_home")
    /// Image `ic_lock`.
    static let ic_lock = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_lock")
    /// Image `ic_water`.
    static let ic_water = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_water")
    
    /// `UIImage(named: "ic_home", bundle: ..., traitCollection: ...)`
    static func ic_home(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_home, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "ic_lock", bundle: ..., traitCollection: ...)`
    static func ic_lock(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_lock, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "ic_water", bundle: ..., traitCollection: ...)`
    static func ic_water(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_water, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 5 nibs.
  struct nib {
    /// Nib `InitialViewController`.
    static let initialViewController = _R.nib._InitialViewController()
    /// Nib `IntroViewController`.
    static let introViewController = _R.nib._IntroViewController()
    /// Nib `LoginViewController`.
    static let loginViewController = _R.nib._LoginViewController()
    /// Nib `ProfileViewController`.
    static let profileViewController = _R.nib._ProfileViewController()
    /// Nib `TemperatureViewController`.
    static let temperatureViewController = _R.nib._TemperatureViewController()
    
    /// `UINib(name: "InitialViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.initialViewController) instead")
    static func initialViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.initialViewController)
    }
    
    /// `UINib(name: "IntroViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.introViewController) instead")
    static func introViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.introViewController)
    }
    
    /// `UINib(name: "LoginViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.loginViewController) instead")
    static func loginViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.loginViewController)
    }
    
    /// `UINib(name: "ProfileViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.profileViewController) instead")
    static func profileViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.profileViewController)
    }
    
    /// `UINib(name: "TemperatureViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.temperatureViewController) instead")
    static func temperatureViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.temperatureViewController)
    }
    
    static func initialViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.initialViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    static func introViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.introViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    static func loginViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.loginViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    static func profileViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.profileViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    static func temperatureViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.temperatureViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 18 localization keys.
    struct localizable {
      /// Value: Aktuální
      static let temperatureReal = Rswift.StringResource(key: "temperature.real", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Chyba připojení
      static let connectionErrorTitle = Rswift.StringResource(key: "connection.error.title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Domov
      static let heatmodelName = Rswift.StringResource(key: "heatmodel.name", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: E-mail
      static let loginEmailPlaceholder = Rswift.StringResource(key: "login.email.placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Heslo
      static let loginPasswordPlaceholder = Rswift.StringResource(key: "login.password.placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Jmenuji se Lukáš Jezný a jsem tvůrcem MasterTherm Easy Control a děkuji za její stažení. Již několik let se věnuji vývoji mobilních aplikací na volné noze a jsem také majitelem tepelného čerpadla firmy MasterTherm na svém domě. Oficiální aplikace k ovladání tohoto čerpadla mi svým designem i použitím nevyhovovala a proto jsem zkusil publikovat vlastní řešení pro ovládání tohoto čerpadla.  Aplikace svým rozsahem nepokrývá funkcionalitu originální aplikace, ale naopak jsem chtěl zjednodušit ovládání tepelného čerpadla. Cílem je tedy jednoduše a pohodlněji ovládát vytápění a naopak nastavování teplotních křivek a složitějších parametrů dále neplánuji. Ve volném čase pracuji na vývoji a nových funkcí a budu je přidávat až podle potřeby.  Budu rád za každou připomínku k použití aplikace a za nahlášení případných problémů. Kontaktní formulář je dostupný po přihlášení.  Používání této aplikace je na vlastní riziko a za případné vady či poškození na tepelném čerpadle neručím. Aplikaci jsem ladil a testoval na svém vlastním tepelném čerpadle žádné vady jsem nezpůsobil. Pokud i přes to máte obavy, prosím, používejte originální aplikaci. Použití aplikace je zcela na Vás.
      static let introMessage = Rswift.StringResource(key: "intro.message", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: MasterTherm Easy Control
      static let generalAppname = Rswift.StringResource(key: "general.appname", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: OK
      static let generalOk = Rswift.StringResource(key: "general.ok", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Pokračovat
      static let introContinueButton = Rswift.StringResource(key: "intro.continue.button", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Požadováno
      static let temperatureSet = Rswift.StringResource(key: "temperature.set", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Pro přihlášení použijte údaje, které jste obdrželi od firmy MasterTherm a které používáte pro přihlášení na webovém rozhraní nebo v originální aplikaci. Přihlašovací údaje aplikace uloží bezpečně do tzv. klíčenky a Vaše heslo bude posíláno bezpečně přes šifrované spojení. Vaše údaje aplikace dále nijak nezpracovává.
      static let loginMessage = Rswift.StringResource(key: "login.message", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Přihlásit
      static let loginButton = Rswift.StringResource(key: "login.button", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Přihlášení se nepodařilo
      static let unauthorizedTitle = Rswift.StringResource(key: "unauthorized.title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Teplá užitková voda
      static let hotwatermodelName = Rswift.StringResource(key: "hotwatermodel.name", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Vaše přihlašovací údaje jsou nesprávné. Prosím, zkontrolujte je a zkuste se přihlásit znovu.
      static let unauthorizedMessage = Rswift.StringResource(key: "unauthorized.message", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Vypadá to, že nemáte dostupné internetové připojení. Prosím, zkontrolujte připojení a zkuste akci znovu.
      static let connectionErrorMessage = Rswift.StringResource(key: "connection.error.message", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Zkusit znovu
      static let generalRetry = Rswift.StringResource(key: "general.retry", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Zrušit
      static let generalCancel = Rswift.StringResource(key: "general.cancel", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: Aktuální
      static func temperatureReal(_: Void = ()) -> String {
        return NSLocalizedString("temperature.real", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Chyba připojení
      static func connectionErrorTitle(_: Void = ()) -> String {
        return NSLocalizedString("connection.error.title", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Domov
      static func heatmodelName(_: Void = ()) -> String {
        return NSLocalizedString("heatmodel.name", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: E-mail
      static func loginEmailPlaceholder(_: Void = ()) -> String {
        return NSLocalizedString("login.email.placeholder", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Heslo
      static func loginPasswordPlaceholder(_: Void = ()) -> String {
        return NSLocalizedString("login.password.placeholder", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Jmenuji se Lukáš Jezný a jsem tvůrcem MasterTherm Easy Control a děkuji za její stažení. Již několik let se věnuji vývoji mobilních aplikací na volné noze a jsem také majitelem tepelného čerpadla firmy MasterTherm na svém domě. Oficiální aplikace k ovladání tohoto čerpadla mi svým designem i použitím nevyhovovala a proto jsem zkusil publikovat vlastní řešení pro ovládání tohoto čerpadla.  Aplikace svým rozsahem nepokrývá funkcionalitu originální aplikace, ale naopak jsem chtěl zjednodušit ovládání tepelného čerpadla. Cílem je tedy jednoduše a pohodlněji ovládát vytápění a naopak nastavování teplotních křivek a složitějších parametrů dále neplánuji. Ve volném čase pracuji na vývoji a nových funkcí a budu je přidávat až podle potřeby.  Budu rád za každou připomínku k použití aplikace a za nahlášení případných problémů. Kontaktní formulář je dostupný po přihlášení.  Používání této aplikace je na vlastní riziko a za případné vady či poškození na tepelném čerpadle neručím. Aplikaci jsem ladil a testoval na svém vlastním tepelném čerpadle žádné vady jsem nezpůsobil. Pokud i přes to máte obavy, prosím, používejte originální aplikaci. Použití aplikace je zcela na Vás.
      static func introMessage(_: Void = ()) -> String {
        return NSLocalizedString("intro.message", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: MasterTherm Easy Control
      static func generalAppname(_: Void = ()) -> String {
        return NSLocalizedString("general.appname", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: OK
      static func generalOk(_: Void = ()) -> String {
        return NSLocalizedString("general.ok", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Pokračovat
      static func introContinueButton(_: Void = ()) -> String {
        return NSLocalizedString("intro.continue.button", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Požadováno
      static func temperatureSet(_: Void = ()) -> String {
        return NSLocalizedString("temperature.set", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Pro přihlášení použijte údaje, které jste obdrželi od firmy MasterTherm a které používáte pro přihlášení na webovém rozhraní nebo v originální aplikaci. Přihlašovací údaje aplikace uloží bezpečně do tzv. klíčenky a Vaše heslo bude posíláno bezpečně přes šifrované spojení. Vaše údaje aplikace dále nijak nezpracovává.
      static func loginMessage(_: Void = ()) -> String {
        return NSLocalizedString("login.message", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Přihlásit
      static func loginButton(_: Void = ()) -> String {
        return NSLocalizedString("login.button", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Přihlášení se nepodařilo
      static func unauthorizedTitle(_: Void = ()) -> String {
        return NSLocalizedString("unauthorized.title", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Teplá užitková voda
      static func hotwatermodelName(_: Void = ()) -> String {
        return NSLocalizedString("hotwatermodel.name", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Vaše přihlašovací údaje jsou nesprávné. Prosím, zkontrolujte je a zkuste se přihlásit znovu.
      static func unauthorizedMessage(_: Void = ()) -> String {
        return NSLocalizedString("unauthorized.message", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Vypadá to, že nemáte dostupné internetové připojení. Prosím, zkontrolujte připojení a zkuste akci znovu.
      static func connectionErrorMessage(_: Void = ()) -> String {
        return NSLocalizedString("connection.error.message", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Zkusit znovu
      static func generalRetry(_: Void = ()) -> String {
        return NSLocalizedString("general.retry", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Zrušit
      static func generalCancel(_: Void = ()) -> String {
        return NSLocalizedString("general.cancel", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
    try nib.validate()
  }
  
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _IntroViewController.validate()
      try _LoginViewController.validate()
      try _TemperatureViewController.validate()
    }
    
    struct _InitialViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "InitialViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _IntroViewController: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "IntroViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "ic_home", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_home' is used in nib 'IntroViewController', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct _LoginViewController: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "LoginViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "ic_lock", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_lock' is used in nib 'LoginViewController', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct _ProfileViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "ProfileViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _TemperatureViewController: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "TemperatureViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "ic_home", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_home' is used in nib 'TemperatureViewController', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
