# Plan

## Scope

Implement the required StudyItem and StudyPlan domain behaviour. The implementation will cover:
- StudyItem validation
- codable decoding with validation
- StudyPlan duplicate ID validation
- deterministic ordering
- category queries
- incomplete minutes calculation
- completion by ID
- at least six student-authored XCTest cases

The optional importMerging bonus i will consider after the core tasks pass

## Acceptance criteria

- vlank or whitespace-only titles throw StudyPlanError.blankTitle
- estimatedMinutes <= 0 throws StudyPlanError.nonPositiveEstimatedMinutes
- title validation takes precedence over minutes validation
- decoded StudyItem values use the same validation rules
- StudyPlan rejects duplicate IDs and reports the first duplicate
- StudyPlan items have deterministic title-then-ID ordering
- items(in:) returns items only from the requested category
- incompleteMinutes() sums only incomplete items
- markCompleted(id:) completes an existing item
- markCompleted(id:) throws for an unknown ID
- completing an already completed item is safe
- at least six additional XCTest methods pass
- comand swift test passes before submission

## Implementation steps

1. implement StudyItem validation in Sources/StudyPlanner/StudyPlanner.swift
2. run swift test and review the result
3. implement validated Codable decoding for StudyItem
4. implement StudyPlan initialisation, duplicate detection, and ordering
5. implement StudyPlan decoding
6. implement category queries and incomplete minute calculation
7. implement markCompleted(id:)
8. add student-authored XCTest cases in Tests/StudyPlannerTests
9. run the complete test suite
10. review the public API and submission files
11. implement the bonus after all core tests pass (maybe)

## Risks

- codable decoding could bypass StudyItem validation if implemented incorrectly
- fuplicate detection must report the first duplicate ID
- public API signatures and supplied public tests mustnt be changed

## `swift test` verification

Command:

`swift test`

Result:

```bash
Building for debugging...
[15/15] Linking StudyPlannerPackageTests
Build complete! (12.89s)
Test Suite 'All tests' started at 2026-09-27 18:05:51.353.
Test Suite 'StudyPlannerPackageTests.xctest' started at 2026-09-27 18:05:51.355.
Test Suite 'StudyPlannerPublicTests' started at 2026-09-27 18:05:51.355.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testBlankTitleIsRejected]' started.
StudyPlanner/StudyPlanner.swift:28: Fatal error: Implement StudyItem validation
error: Exited with unexpected signal code 5
◇ Test run started.
↳ Testing Library Version: 1501
↳ Target Platform: arm64e-apple-macos14.0
✔ Test run with 0 tests in 0 suites passed after 0.001 seconds.
```

Follow-up:

implement StudyItem validation and run the tests again


### Final verification - 2026-09-28

Command:

`swift test`

Result:

```bash
vikasemenko@Vikas-MacBook-Air apd-hw-1 % swift test
[1/1] Planning build
Building for debugging...
[1/1] Write swift-version--58304C5D6DBC2206.txt
Build complete! (0.18s)
Test Suite 'All tests' started at 2026-09-28 22:18:55.979.
Test Suite 'StudyPlannerPackageTests.xctest' started at 2026-09-28 22:18:55.981.
Test Suite 'StudyPlannerPublicTests' started at 2026-09-28 22:18:55.981.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testBlankTitleIsRejected]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testBlankTitleIsRejected]' passed (0.002 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testIncompleteMinutesAndCompletion]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testIncompleteMinutesAndCompletion]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testValidItemStoresValues]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testValidItemStoresValues]' passed (0.000 seconds).
Test Suite 'StudyPlannerPublicTests' passed at 2026-09-28 22:18:55.984.
     Executed 3 tests, with 0 failures (0 unexpected) in 0.003 (0.003) seconds
Test Suite 'StudyPlannerStudentTests' started at 2026-09-28 22:18:55.984.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testDuplicateIDsAreRejected]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testDuplicateIDsAreRejected]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testInvalidStudyItemJSONIsRejected]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testInvalidStudyItemJSONIsRejected]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testItemsAreSortedByTitleAndID]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testItemsAreSortedByTitleAndID]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testItemsCanBeFilteredByCategory]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testItemsCanBeFilteredByCategory]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testMarkCompletedCanBeCalledTwice]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testMarkCompletedCanBeCalledTwice]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testNonPositiveMinutesAreRejected]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testNonPositiveMinutesAreRejected]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testStudyPlanCanBeDecodedFromKeyedJSON]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testStudyPlanCanBeDecodedFromKeyedJSON]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testTopLevelJSONArrayCanBeDecoded]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testTopLevelJSONArrayCanBeDecoded]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testUnknownIDCompletionThrowsError]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testUnknownIDCompletionThrowsError]' passed (0.000 seconds).
Test Suite 'StudyPlannerStudentTests' passed at 2026-09-28 22:18:55.985.
     Executed 9 tests, with 0 failures (0 unexpected) in 0.001 (0.001) seconds
Test Suite 'StudyPlannerPackageTests.xctest' passed at 2026-09-28 22:18:55.985.
     Executed 12 tests, with 0 failures (0 unexpected) in 0.004 (0.004) seconds
Test Suite 'All tests' passed at 2026-09-28 22:18:55.985.
     Executed 12 tests, with 0 failures (0 unexpected) in 0.004 (0.006) seconds
◇ Test run started.
↳ Testing Library Version: 1501
↳ Target Platform: arm64e-apple-macos14.0
✔ Test run with 0 tests in 0 suites passed after 0.001 seconds.
```

Follow-up:

commit changes, think about additional task

### Verification for binus task - 2026-10-01

Command:

`swift test`

Result:

```
vikasemenko@Vikas-MacBook-Air apd-hw-1 % swift test                                  
[1/1] Planning build
Building for debugging...
[10/10] Linking StudyPlannerPackageTests
Build complete! (1.78s)
Test Suite 'All tests' started at 2026-10-01 19:11:15.848.
Test Suite 'StudyPlannerPackageTests.xctest' started at 2026-10-01 19:11:15.850.
Test Suite 'StudyPlannerPublicTests' started at 2026-10-01 19:11:15.850.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testBlankTitleIsRejected]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testBlankTitleIsRejected]' passed (0.002 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testIncompleteMinutesAndCompletion]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testIncompleteMinutesAndCompletion]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testValidItemStoresValues]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testValidItemStoresValues]' passed (0.000 seconds).
Test Suite 'StudyPlannerPublicTests' passed at 2026-10-01 19:11:15.853.
     Executed 3 tests, with 0 failures (0 unexpected) in 0.002 (0.003) seconds
Test Suite 'StudyPlannerStudentTests' started at 2026-10-01 19:11:15.853.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testDuplicateIDsAreRejected]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testDuplicateIDsAreRejected]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testFailedImportDoesNotChangePlan]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testFailedImportDoesNotChangePlan]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testImportAppendsNewItemsSortedByID]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testImportAppendsNewItemsSortedByID]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testImportReplacesExistingItemAtSamePosition]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testImportReplacesExistingItemAtSamePosition]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testInvalidStudyItemJSONIsRejected]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testInvalidStudyItemJSONIsRejected]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testItemsAreSortedByTitleAndID]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testItemsAreSortedByTitleAndID]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testItemsCanBeFilteredByCategory]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testItemsCanBeFilteredByCategory]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testMarkCompletedCanBeCalledTwice]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testMarkCompletedCanBeCalledTwice]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testNonPositiveMinutesAreRejected]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testNonPositiveMinutesAreRejected]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testStudyPlanCanBeDecodedFromKeyedJSON]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testStudyPlanCanBeDecodedFromKeyedJSON]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testTopLevelJSONArrayCanBeDecoded]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testTopLevelJSONArrayCanBeDecoded]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testUnknownIDCompletionThrowsError]' started.
Test Case '-[StudyPlannerTests.StudyPlannerStudentTests testUnknownIDCompletionThrowsError]' passed (0.000 seconds).
Test Suite 'StudyPlannerStudentTests' passed at 2026-10-01 19:11:15.854.
     Executed 12 tests, with 0 failures (0 unexpected) in 0.001 (0.002) seconds
Test Suite 'StudyPlannerPackageTests.xctest' passed at 2026-10-01 19:11:15.854.
     Executed 15 tests, with 0 failures (0 unexpected) in 0.004 (0.005) seconds
Test Suite 'All tests' passed at 2026-10-01 19:11:15.854.
     Executed 15 tests, with 0 failures (0 unexpected) in 0.004 (0.006) seconds
◇ Test run started.
↳ Testing Library Version: 1501
↳ Target Platform: arm64e-apple-macos14.0
✔ Test run with 0 tests in 0 suites passed after 0.001 seconds.
```
