//
//  AppUtils.swift
//  Tecomen
//
//  Created by TrungNV on 5/28/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import Foundation

final class AppUtils {
    enum VersionError: Error {
           case invalidResponse, invalidBundleInfo
       }

       static func getAppVersion() -> String {
           let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
           return appVersion ?? "1.0.0"
       }

       static func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
           guard let info = Bundle.main.infoDictionary,
               let currentVersion = info["CFBundleShortVersionString"] as? String,
               let identifier = info["CFBundleIdentifier"] as? String,
               let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                   throw VersionError.invalidBundleInfo
           }
           print(currentVersion)
           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
               do {
                   if let error = error { throw error }
                   guard let data = data else { throw VersionError.invalidResponse }
                   let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                   guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String else {
                       throw VersionError.invalidResponse
                   }
                   completion(version != currentVersion, nil)
               } catch {
                   completion(nil, error)
               }
           }
           task.resume()
           return task
       }

    static func hideLoading(inVC vc: BaseVC,_ isHidden: Bool = true) {
        let info = ["isHidden": isHidden, "vc": vc] as [String : Any]
        NotificationCenter.default
            .post(name: NSNotification.Name(NotificationKeys.loading),
                  object: nil,
                  userInfo: info)
    }

    static func showMsg(inVC vc: BaseVC, _ msg: String) {
        let info = ["msg": msg, "vc": vc] as [String : Any]
        NotificationCenter.default
            .post(name: NSNotification.Name(NotificationKeys.showMsg),
                  object: nil,
                  userInfo: info)
    }

    static func checkValids(_ valids: [(Bool, String)]) -> (Bool, String) {
        for item in valids {
            if !item.0 {
                return (false, item.1)
            }
        }
        return (true, "")
    }
}
