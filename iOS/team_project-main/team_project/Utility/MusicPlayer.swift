//
//  MusicPlayer.swift
//  team_project
//
//  Created by Taewon Yoon on 3/2/24.
//

import AVFoundation
import MediaPlayer
import Alamofire
import SwiftUI

@MainActor
class MusicPlayer: ObservableObject {
    @State var iosToWatch: iOSToWatch
    @Published var musicContainer: [MusicInfoModel] = []
    var nowPlayingInfo: [String : Any] = [:]
    var player: AVPlayer?
    var isPlaying = false
    var currentTime: CMTime = .zero
    var timeObserverToken: Any?
    
    
    init(iosToWatch: iOSToWatch) {
        print("🙏초기세팅")
        self.iosToWatch = iosToWatch
        player?.automaticallyWaitsToMinimizeStalling = false
        player?.allowsExternalPlayback = false
        setupRemoteCommands()
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "music", withExtension: ".mp3") else { return }
        self.player = AVPlayer(url: url)
        player?.play()
        // 재생 중인 노래 정보를 설정
        var nowPlayingInfo: [String : Any] = [
            MPMediaItemPropertyTitle: "Your Song Title",
            MPMediaItemPropertyArtist: "Your Artist Name",
            MPMediaItemPropertyPlaybackDuration: player?.currentItem?.duration ?? 0,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: player?.currentItem?.duration ?? 0
        ]
        if let albumCoverPage = UIImage(named: "apple") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumCoverPage.size, requestHandler: { size in
                return albumCoverPage
            })
        }
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func getMusicInfo(completion: @escaping ([MusicInfoModel]) -> Void) {
        do {
            let token = try KeyChain.get()
            let header: HTTPHeaders = [.authorization(bearerToken: token.token)]
            AF.request(Constants().getAllMusic!,
                       method: .get,
                       parameters: nil,
                       headers: header).responseDecodable(of: [MusicInfoModel].self) { result in
                if result.error == nil {
                    if let music = result.value {
                        return completion(music)
                    }
                }
            }
        } catch {
            print("키체인 가져오는데 에러:\(error.localizedDescription)")
            return
        }
    }
    
    func getWithoutBPM(url: URL) {
        do {
            let token = try KeyChain.get()
            let url = url
            let header: HTTPHeaders = [.authorization(bearerToken: token.token)]
            print(url)
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MusicInfoModel.self) { response in
                Task {
                    await self.setupMusicInfo(url: URL(string: response.value?.filePath ?? "")!, info: response.value!)
                }
            }
        } catch {
            
        }
    }
    
    func getTest(url: URL, bpm: Int) {
        print("URL:\(url)")
        print("bpm:\(bpm)")
        do {
            let parameters = ["heartRate": bpm.description]
            let token = try KeyChain.get()
            let url = url
            let header: HTTPHeaders = [.authorization(bearerToken: token.token)]
            print(url)
            AF.request(url,
                       method: .get,
                       parameters: parameters as Parameters,
                       encoding: URLEncoding.default,
                       headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MusicInfoModel.self) { response in
                Task {
                    if let filePath = response.value?.filePath, let value = response.value {
                        await self.setupMusicInfo(url: URL(string: filePath)!, info: value)
                    }
                }
            }
        } catch {
            print("token error:\(error)")
        }
    }
    
    func getAllTest(url: URL) {
        do {
            let token = try KeyChain.get()
            let header: HTTPHeaders = [.authorization(bearerToken: token.token)]
            print(url)
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [MusicInfoModel].self) { response in
                DispatchQueue.main.async {
                    if let data = response.value {
                        self.musicContainer = data
                    }
                }
                print(token.token)
            }
        } catch {
            
        }
    }

    
    
    func handlePlaybackChange() {
        guard let musicplayer = player else {
            return
        }
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] =  CMTimeGetSeconds(musicplayer.currentTime())
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    
    
    func setupMusicInfo(url: URL, info: MusicInfoModel) async { // 잠금화면에 띄우기
        print("음악 재생 전 \(Date().timeIntervalSince1970)")
        self.player = AVPlayer(url: url)
        print("음악 재생 직전 \(Date().timeIntervalSince1970)")
        player?.playImmediately(atRate: 1)
        print("음악 재생 후 \(Date().timeIntervalSince1970)")
        // 재생 중인 노래 정보를 설정
        do {
            let duration = try await player?.currentItem?.asset.load(.duration) // 현재 음악의 총 시간
            nowPlayingInfo = [
                MPMediaItemPropertyTitle: info.title,
                MPMediaItemPropertyArtist: info.artist,
                MPMediaItemPropertyPlaybackDuration: Int(duration!.seconds),
                MPNowPlayingInfoPropertyElapsedPlaybackTime: CMTimeGetSeconds(player!.currentTime()),
                MPNowPlayingInfoPropertyPlaybackRate: player?.rate as Any
            ]
            
            var request = URLRequest(url: URL(string: info.albumUrl)!)
            request.httpMethod = "GET"
            
            let configuration = URLSessionConfiguration.default
            
            let session = URLSession(configuration: configuration)
            do {
                let (data, _) = try await session.data(for: request)
                if let albumCoverPage = UIImage(data: data) {
                    nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumCoverPage.size, requestHandler: { size in
                        return albumCoverPage
                    })
                }
                
            } catch {
                print(error)
            }
            
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
            
        } catch {
            print(error)
        }
    }
    
    func setupRemoteCommands() {
        let remoteCommandCenter = MPRemoteCommandCenter.shared()
        remoteCommandCenter.previousTrackCommand.isEnabled = true
        remoteCommandCenter.nextTrackCommand.isEnabled = true
        remoteCommandCenter.changePlaybackPositionCommand.isEnabled = true
        remoteCommandCenter.playCommand.isEnabled = true
        remoteCommandCenter.pauseCommand.isEnabled = true
        
        NotificationCenter.default.addObserver(forName: AVPlayerItem.didPlayToEndTimeNotification, object: nil, queue: nil) { _ in
            Task {
                await self.getTest(url: Constants().nextmusic!, bpm: self.iosToWatch.bpm ?? 0)
            }
        }
        
        remoteCommandCenter.playCommand.addTarget { _ in
            self.player?.play()
            self.handlePlaybackChange()
            return .success
        }
        
        remoteCommandCenter.pauseCommand.addTarget { _ in
            print("멈춤")
            self.player?.pause()
            self.handlePlaybackChange()
            
            return .success
        }
        
        remoteCommandCenter.previousTrackCommand.addTarget { _ in
            Task {
                await self.previousPlayback()
            }
            return .success
        }
        
        remoteCommandCenter.nextTrackCommand.addTarget { _ in
            Task {
                await self.nextPlayback()
            }
            return .success
        }
        
        remoteCommandCenter.changePlaybackPositionCommand.addTarget { [weak self](remoteEvent) -> MPRemoteCommandHandlerStatus in
            guard let self = self else {return .commandFailed}
            if let player = self.player {
                let playerRate = player.rate
                if let event = remoteEvent as? MPChangePlaybackPositionCommandEvent {
                    player.seek(to: CMTime(seconds: event.positionTime, preferredTimescale: CMTimeScale(1000)), completionHandler: { [weak self](success) in
                        guard let self = self else {return}
                        if success {
                            self.player?.rate = playerRate
                        }
                    })
                    return .success
                }
            }
            return .commandFailed
        }
    }
    
    
    
    private func seek(to time: CMTime) {
        player!.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero) { isFinished in
            if isFinished {
                self.handlePlaybackChange()
            }
        }
    }
    
    func pausePlayback() {
        print("멈춤")
        player?.pause()
        handlePlaybackChange()
    }
    
    func resumePlayback() {
        print("재개")
        player?.play()
        handlePlaybackChange()
    }
    
    func previousPlayback() async {
        print("서버에 전송하는 이전 버튼 심박수:\(String(describing: iosToWatch.bpm))")
        getTest(url: Constants().previousmusic!, bpm: iosToWatch.bpm ?? 0)
        handlePlaybackChange()
    }
    
    func nextPlayback() async {
        print("서버에 전송하는 다음 버튼 심박수:\(String(describing: iosToWatch.bpm))")
        getTest(url: Constants().nextmusic!, bpm: iosToWatch.bpm ?? 0)
        handlePlaybackChange()
    }
    
}
