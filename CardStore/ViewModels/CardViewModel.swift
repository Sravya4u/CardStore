import Combine
//
//  CardGroupViewModel.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 16/08/24.
//
import Foundation

struct ErrorMessage: Identifiable {
  let id = UUID()
  let message: String
}
/**
 *  CardViewModel.swift
 *
 *  Manages the data and business logic related to cards displayed in the application.
 *  The CardViewModel class conforms to the ObservableObject protocol, making it suitable for use as a SwiftUI view model.
 *  It provides methods for fetching cards data from a service, as well as grouping cards and bookmark functionality
 *
 *  - Author: Sravya Chandrapati
 */
class CardViewModel: ObservableObject {

  // MARK: - View Publishers
  @Published var cards: [Card] = []
  @Published var bookmarks: [Card] = []
  @Published var errorMessage: ErrorMessage? = nil
  @Published var isLoading: Bool = false

  // MARK: - Priviate Vairables
  private var cancellables = Set<AnyCancellable>()
  private let networkService: NetworkService

  // MARK: - Initializer
  // UseMockData flag enables user to switch between RealAPI and mock data. This can be passed from contentView
  init(networkService: NetworkService = NetworkManager.shared, useMockData: Bool = false) {
    self.networkService = networkService
    if useMockData {
      loadMockCards()
    } else {
      fetchCards()
    }
  }

   /// Methods to fetch cards from remoteAPI using network service
   func fetchCards() {
    isLoading = true
    networkService.fetchCards()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          switch completion {
          case .failure(let error):
            self?.isLoading = false
            self?.handleError(error)
          case .finished:
            self?.isLoading = false
            break
          }
        },
        receiveValue: { [weak self] (cards: [Card]) in
          self?.isLoading = false
          self?.cards = cards
        }
      )
      .store(in: &cancellables)
  }

   /// Method to load mock cards for testing business logic without hitting API
   func loadMockCards() {

    NetworkManager.shared.loadMockCards()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          switch completion {
          case .failure(let error):
            self?.handleError(error)
          case .finished:
            break
          }
        },
        receiveValue: { [weak self] (cards: [Card]) in
          self?.cards = cards
        }
      )
      .store(in: &cancellables)
  }
  /// Handles any errors thrown with customised message
  private func handleError(_ error: Error) {
    let errorMessage: String
    switch error {
    case NetworkError.invalidURL:
      errorMessage = "The URL is invalid. Please try again."
    case NetworkError.fileNotFound:
      errorMessage = "The requested file could not be found."
    case DecodingError.decodingFailed:
      errorMessage = "Failed to decode the data. Please try again."
    default:
      errorMessage = "Failed to load cards: \(error.localizedDescription)"
    }
    self.errorMessage = ErrorMessage(message: errorMessage)
  }

}
// MARK: - Public Methods
extension CardViewModel {

  func toggleBookmark(card: Card) {
    if let index = cards.firstIndex(where: { $0.id == card.id }) {
      cards[index].isBookmarked.toggle()

      if cards[index].isBookmarked {
        bookmarks.append(cards[index])
      } else {
        if let bookmarkIndex = bookmarks.firstIndex(where: { $0.id == card.id }) {
          bookmarks.remove(at: bookmarkIndex)
        }
      }
    }
  }

  func groupedCards() -> [String: [Card]] {
    Dictionary(grouping: cards, by: { $0.creditCardType })
  }
}
