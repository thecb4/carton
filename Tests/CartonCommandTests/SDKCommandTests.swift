@testable import CartonCLI
import TSCBasic
import XCTest

extension InitCommandTests: Testable {}

final class InitCommandTests: XCTestCase {
  func testInstall() {
    AssertExecuteCommand(command: "carton sdk install", debug: true)
  }
}
