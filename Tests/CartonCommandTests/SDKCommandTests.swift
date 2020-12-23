@testable import CartonCLI
import TSCBasic
import XCTest

extension SDKCommandTests: Testable {}

final class SDKCommandTests: XCTestCase {
  func testInstall() {
    AssertExecuteCommand(command: "carton sdk install", debug: true)
  }
}
