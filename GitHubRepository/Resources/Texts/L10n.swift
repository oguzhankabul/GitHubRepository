//
//  L10n.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import Foundation

private final class BundleToken {
    
    static let bundle: Bundle = {
        Bundle(for: BundleToken.self)
    }()
}

public class L10n {
    
    public static func get(_ key: String, parameter: [CVarArg] = []) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: "Localizable")
        return String(format: format, locale: Locale.current, arguments: parameter)
    }
    
    static var language: String {
        return "en"
    }
}

public extension L10n {
    
    static let repositories_title = get("repositories_title")
    static let no_name_title = get("no_name_title")
    static let no_login_title = get("no_login_title")
    static let no_description_title = get("no_description_title")
    static let no_date_title = get("no_date_title")
    static let no_star_title = get("no_star_title")
    static let no_language_title = get("no_language_title")
    static let no_forks_title = get("no_forks_title")
    static let open_in_github_title = get("open_in_github_title")
    static let delete_button_title = get("delete_button_title")
    static let are_you_sure_title = get("are_you_sure_title")
    static let ok_button_title = get("ok_button_title")
    static let cancel_button_title = get("cancel_button_title")
}
