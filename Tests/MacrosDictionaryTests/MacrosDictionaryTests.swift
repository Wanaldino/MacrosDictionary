import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(MacrosDictionaryCollection)
import MacrosDictionaryCollection

let testMacros: [String: Macro.Type] = [
    "FooExpression": FooExpressionMacro.self,
]
#endif

final class MacrosDictionaryTests: XCTestCase {
    func testMacro() throws {
        #if canImport(MacrosDictionaryCollection)
        assertMacroExpansion(
            """
            #FooExpression
            """,
            expandedSource: """
            print(\"Hello foo\")
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
