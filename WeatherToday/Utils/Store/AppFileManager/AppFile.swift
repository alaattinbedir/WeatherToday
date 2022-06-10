//
//  AppFile.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public enum AppFileStatusChecking {
    public static func isWritable(file at: URL) -> Bool {
        return FileManager.default.isWritableFile(atPath: at.path)
    }

    public static func isReadable(file at: URL) -> Bool {
        return FileManager.default.isReadableFile(atPath: at.path)
    }

    public static func exists(file at: URL) -> Bool {
        return FileManager.default.fileExists(atPath: at.path)
    }
}

public enum AppFileSystemMetaData {
    static func list(directory at: URL) -> [String]? {
        do {
            return try FileManager.default.contentsOfDirectory(atPath: at.path)
        } catch {
            return nil
        }
    }

    static func attributes(ofFile atFullPath: URL) -> [FileAttributeKey: Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: atFullPath.path)
        } catch {
            return nil
        }
    }
}

public enum AppFileManipulation {
    @discardableResult
    public static func writeFile(text: String,
                                 to path: AppDirectories,
                                 withName name: String,
                                 options: Data.WritingOptions = [.atomicWrite, .completeFileProtection]) throws -> Bool {
        guard let filePath = path.buildFullPath(forFileName: name) else { return false }
        guard let rawData = text.data(using: .utf8) else { return false }
        do {
            try? FileManager.default.setAttributes([FileAttributeKey.protectionKey: FileProtectionType.complete], ofItemAtPath: filePath.path)
            try rawData.write(to: filePath, options: options)
            return true
        } catch {
            throw error
        }
    }

    public static func writeFile(data: Data,
                                 to path: AppDirectories,
                                 withName name: String,
                                 options: Data.WritingOptions = [.atomicWrite, .completeFileProtection]) throws -> Bool {
        guard let filePath = path.buildFullPath(forFileName: name) else { return false }
        do {
            try? FileManager.default.setAttributes([FileAttributeKey.protectionKey: FileProtectionType.complete], ofItemAtPath: filePath.path)
            try data.write(to: filePath, options: options)
            return true
        } catch {
            throw error
        }
    }

    public static func readFile(at path: AppDirectories, withName name: String) -> String? {
        guard let filePath = path.buildFullPath(forFileName: name)?.path else { return nil }
        guard let fileContents = FileManager.default.contents(atPath: filePath) else { return nil }
        let fileContentsAsString = String(bytes: fileContents, encoding: .utf8)
        return fileContentsAsString
    }

    @discardableResult
    public static func deleteFile(at path: AppDirectories, withName name: String) -> Bool {
        guard let filePath = path.buildFullPath(forFileName: name) else { return false }
        return deleteFile(at: filePath)
    }

    @discardableResult
    public static func deleteFile(at path: URL) -> Bool {
        do {
            try FileManager.default.removeItem(at: path)
            return true
        } catch {
            return false
        }
    }

    @discardableResult
    public static func deleteFiles(at dir: AppDirectories) -> Bool {
        guard let dirPath = dir.getURL()?.path, let files = try? FileManager.default.contentsOfDirectory(atPath: dirPath), files.count > 0 else { return false }
        for filePath in files {
            guard let fileUrl = URL(string: filePath) else { continue }
            deleteFile(at: fileUrl)
        }
        return true
    }

    public static func renameFile(at directory: AppDirectories, with oldName: String, to newName: String) -> Bool {
        guard let oldPath = directory.buildFullPath(forFileName: oldName) else { return false }
        guard let newPath = directory.buildFullPath(forFileName: newName) else { return false }
        do {
            try FileManager.default.moveItem(at: oldPath, to: newPath)
            return true
        } catch {
            return false
        }
    }

    public static func moveFile(withName name: String, inDirectory: AppDirectories,
                                toDirectory directory: AppDirectories) -> Bool {
        guard let originURL = inDirectory.buildFullPath(forFileName: name) else { return false }
        guard let destinationURL = directory.buildFullPath(forFileName: name) else { return false }
        do {
            try FileManager.default.moveItem(at: originURL, to: destinationURL)
            return true
        } catch {
            return false
        }
    }

    public static func copyFile(withName name: String, inDirectory: AppDirectories,
                                toDirectory directory: AppDirectories) -> Bool {
        guard let originURL = inDirectory.buildFullPath(forFileName: name) else { return false }
        guard let destinationURL = directory.buildFullPath(forFileName: name + "_copy")
        else { return false }
        do {
            try FileManager.default.copyItem(at: originURL, to: destinationURL)
            return true
        } catch {
            return false
        }
    }

    public static func changeFileExtension(withName name: String, inDirectory: AppDirectories,
                                           toNewExtension newExtension: String) -> Bool {
        var newFileName = NSString(string: name)
        newFileName = newFileName.deletingPathExtension as NSString
        newFileName = (newFileName.appendingPathExtension(newExtension) as NSString?)!
        let finalFileName: String = String(newFileName)

        guard let originURL = inDirectory.buildFullPath(forFileName: name) else { return false }
        guard let destinationURL = inDirectory.buildFullPath(forFileName: finalFileName)
        else { return false }
        do {
            try FileManager.default.moveItem(at: originURL, to: destinationURL)
            return true
        } catch {
            return false
        }
    }
}
