import Combine
import NetworkingKit
import AVFoundation

public class VideosViewModel: ObservableObject {
    @Published var listVideo = [GetAllVideosModel]()
    @Published var uploadVideo: UploadVideoResponse?
    @Published var deleteVideos: DeletedVideoResponse?
    @Published var player: AVPlayer?
    @Published var isLoading: Bool = true
    @Published var videoURL: URL?
    private var playerItem: AVPlayerItem?
    
    private let deletedService = DeleteDataService()
    private let uploadService = UploadVideoDataService()
    private let dataService = AllVideoDataService()
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        self.videoURL = nil
    }
    
    public func deleteVideo(publicID: String) {
        deletedService.deletedVideo(publicID: publicID)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.isLoading = false
                    print("Failed to upload video: \(error.localizedDescription)")
                case .finished:
                    self?.fetchAllVideo()
                    print("deleted video \(publicID) successfully.")
                }
            } receiveValue: { [weak self] response in
                self?.deleteVideos = response
            }
            .store(in: &cancellables)
    }
    
    public func uploadVideo(videoURL: URL, publicID: String) {
        uploadService.postVideo(videoURL: videoURL, uploadPreset: "ml_default", publicID: publicID)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.isLoading = false
                    print("Failed to upload video: \(error.localizedDescription)")
                case .finished:
                    self?.isLoading = false
                    print("Upload finished successfully.")
                }
            } receiveValue: { [weak self] response in
                self?.uploadVideo = response
                self?.fetchAllVideo()
            }
            .store(in: &cancellables)
    }
    
    public func fetchAllVideo() {
        dataService
            .getAllVideo()
            .receive(on: RunLoop.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                case .finished:
                    print("Success")
                }
            } receiveValue: { [weak self] (video) in
                let videoVM = video.resources.map { item in
                    GetAllVideosModel(publicID: item.publicID,
                               displayName: item.displayName,
                               url: item.url)
                    
                }
                self?.listVideo = videoVM
            }
            .store(in: &cancellables)
    }
    
    func loadVideo(url: String) {
        guard let videoURL = URL(string: url) else {
            print("Invalid video URL")
            return
        }

        let asset = AVAsset(url: videoURL)
        playerItem = AVPlayerItem(asset: asset)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerItemStatusDidChange),
            name: .AVPlayerItemNewAccessLogEntry,
            object: playerItem
        )

        DispatchQueue.main.async {
            self.player = AVPlayer(playerItem: self.playerItem)
        }
    }

    @objc private func playerItemStatusDidChange(notification: Notification) {
        guard let item = notification.object as? AVPlayerItem else { return }

        switch item.status {
        case .readyToPlay:
            DispatchQueue.main.async {
                self.isLoading = false
            }
        case .failed:
            print("Failed to load video: \(item.error?.localizedDescription ?? "Unknown error")")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        case .unknown:
            break
        @unknown default:
            break
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
