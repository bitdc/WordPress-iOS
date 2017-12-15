import Foundation
import CoreData
import WordPressKit

@objc(MediaUploadOperation)
public class MediaUploadOperation: UploadOperation {
    /// Remote media ID for this upload op. (Not used if `isMedia` is False)
    ///
    @NSManaged public var remoteMediaID: Int64

    /// Name of the file in this upload op (Not used if `isMedia` is False)
    ///
    @NSManaged public var fileName: String?

    /// Complete local URL, including filename for this upload op (Not used if `isMedia` is False)
    ///
    @NSManaged public var localURL: String?

    /// Complete remote URL, including filename for this upload op (Not used if `isMedia` is False)
    ///
    @NSManaged public var remoteURL: String?

    /// MIME Type for the media involved in this network op (Not used if `isMedia` is False)
    ///
    @NSManaged public var mimeType: String?
}

// MARK: - Computed Properties

extension MediaUploadOperation {
    /// Returns a RemoteMedia object based on this MediaUploadOperation
    ///
    var remoteMedia: RemoteMedia {
        let remoteMedia = RemoteMedia()
        remoteMedia.mediaID = NSNumber(value: remoteMediaID)
        remoteMedia.mimeType = mimeType
        remoteMedia.file = fileName
        if let remoteURL = remoteURL {
            remoteMedia.url = URL(string: remoteURL)
        }
        if let localURL = localURL {
            remoteMedia.localURL = URL(fileURLWithPath: localURL)
        }
        return remoteMedia
    }
}

// MARK: - Update Helpers

extension MediaUploadOperation {
    /// Updates the local fields with the new values stored in a given RemoteMedia
    ///
    func updateWithMedia(remote: RemoteMedia) {
        if let mediaId = remote.mediaID?.int64Value {
            remoteMediaID = mediaId
        }
        localURL = remote.localURL?.absoluteString
        remoteURL = remote.url?.absoluteString
        fileName = remote.file
        mimeType = remote.mimeType
    }
}
