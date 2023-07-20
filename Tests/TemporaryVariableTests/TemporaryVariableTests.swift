import XCTest
@testable import TemporaryVariablePlugin
import SwiftSyntaxMacrosTestSupport
// import SwiftCompilerPlugin
// import SwiftSyntax
// import SwiftSyntaxBuilder
// import SwiftSyntaxMacros

final class InfoTests: XCTestCase {
    final func testReturn() {
        assertMacroExpansion(
        """
        #info {
            return something()
        }
        """,
        expandedSource:"""
        let __macro_local_7result0fMu_ = something()
            return __macro_local_7result0fMu_
        """,
        macros: [
            "info": InfoMacro.self,
        ])
    }

    final func testNested() {
        assertMacroExpansion(
        """
        #info {
            let test = a(b(c(d())))
        }
        """,
        expandedSource:"""
        let __macro_local_7result0fMu_ = d()
        let __macro_local_7result1fMu_ = c(__macro_local_7result0fMu_)
        let __macro_local_7result2fMu_ = b(__macro_local_7result1fMu_)
            let test = a(__macro_local_7result2fMu_)
        """,
        macros: [
            "info": InfoMacro.self,
        ])
    }

    final func testNested2() {
        assertMacroExpansion(
        """
        #info {
            let test1 = a(b(c(d())))
            let test2 = a(b(c(d())))
        }
        """,
        expandedSource:"""
        let __macro_local_7result0fMu_ = d()
        let __macro_local_7result1fMu_ = c(__macro_local_7result0fMu_)
        let __macro_local_7result2fMu_ = b(__macro_local_7result1fMu_)
            let test1 = a(__macro_local_7result2fMu_)
        let __macro_local_7result3fMu_ = d()
        let __macro_local_7result4fMu_ = c(__macro_local_7result3fMu_)
        let __macro_local_7result5fMu_ = b(__macro_local_7result4fMu_)
            let test2 = a(__macro_local_7result5fMu_)
        """,
        macros: [
            "info": InfoMacro.self,
        ])
    }

    final func testPlain() {
        assertMacroExpansion(
        """
        #info {
            let test = a(b(), c(), d())
        }
        """,
        expandedSource:"""
        let __macro_local_7result0fMu_ = b()
        let __macro_local_7result1fMu_ = c()
        let __macro_local_7result2fMu_ = d()
            let test = a(__macro_local_7result0fMu_, __macro_local_7result1fMu_, __macro_local_7result2fMu_)
        """,
        macros: [
            "info": InfoMacro.self,
        ])
    }

    final func testPlain2() {
        assertMacroExpansion(
        """
        #info {
            let test1 = a(b(), c(), d())
            let test2 = a(b(), c(), d())
        }
        """,
        expandedSource:"""
        let __macro_local_7result0fMu_ = b()
        let __macro_local_7result1fMu_ = c()
        let __macro_local_7result2fMu_ = d()
            let test1 = a(__macro_local_7result0fMu_, __macro_local_7result1fMu_, __macro_local_7result2fMu_)
        let __macro_local_7result3fMu_ = b()
        let __macro_local_7result4fMu_ = c()
        let __macro_local_7result5fMu_ = d()
            let test2 = a(__macro_local_7result3fMu_, __macro_local_7result4fMu_, __macro_local_7result5fMu_)
        """,
        macros: [
            "info": InfoMacro.self,
        ])
    }
}
