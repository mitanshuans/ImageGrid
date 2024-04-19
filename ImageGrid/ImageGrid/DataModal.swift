//
//  DataModal.swift
//  ImageGrid
//
//  Created by ajm2021 on 19/04/24.
//

import Foundation
struct DataModal: Codable {
    let id, title, language: String?
    let thumbnail: Thumbnail?
    let mediaType: Int?
    let coverageURL: String?
    let publishedAt, publishedBy: String?
    let backupDetails: BackupDetails?
}

// MARK: - BackupDetails
struct BackupDetails: Codable {
    let pdfLink, screenshotURL: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let id: String?
    let version: Int?
    let domain: String?
    let basePath, key: String?
    let qualities: [Int]?
    let aspectRatio: Int?
}
