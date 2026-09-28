import XCTest
@testable import StudyPlanner
import Foundation

final class StudyPlannerStudentTests: XCTestCase {
    func testNonPositiveMinutesAreRejected() {
        XCTAssertThrowsError(
            try StudyItem(id: "1", title: "Read Swift", estimatedMinutes: 0, category: .reading)
        )
    }
    
    func testDuplicateIDsAreRejected() throws {
        let first = try StudyItem(
            id: "1",
            title: "Read Swift",
            estimatedMinutes: 20,
            category: .reading
        )

        let second = try StudyItem(
            id: "1",
            title: "Practice Swift",
            estimatedMinutes: 30,
            category: .practice
        )

        XCTAssertThrowsError(
            try StudyPlan(items: [first, second])
        )
    }
    
    func testItemsAreSortedByTitleAndID() throws {
        let first = try StudyItem(
            id: "3",
            title: "Swift",
            estimatedMinutes: 20,
            category: .reading
        )

        let second = try StudyItem(
            id: "1",
            title: "Machine Learning",
            estimatedMinutes: 30,
            category: .practice
        )

        let third = try StudyItem(
            id: "2",
            title: "Swift",
            estimatedMinutes: 40,
            category: .project
        )

        let plan = try StudyPlan(items: [first, second, third])

        XCTAssertEqual(plan.items[0].id, "1")
        XCTAssertEqual(plan.items[1].id, "2")
        XCTAssertEqual(plan.items[2].id, "3")
    }
    
    func testItemsCanBeFilteredByCategory() throws {
        let first = try StudyItem(
            id: "1",
            title: "Read Swift",
            estimatedMinutes: 20,
            category: .reading
        )

        let second = try StudyItem(
            id: "2",
            title: "Practice Swift",
            estimatedMinutes: 30,
            category: .practice
        )

        let third = try StudyItem(
            id: "3",
            title: "Read Machine Learning",
            estimatedMinutes: 40,
            category: .reading
        )

        let plan = try StudyPlan(items: [first, second, third])
        let readingItems = plan.items(in: .reading)

        XCTAssertEqual(readingItems.count, 2)
        XCTAssertEqual(readingItems[0].category, .reading)
        XCTAssertEqual(readingItems[1].category, .reading)
    }
    
    func testUnknownIDCompletionThrowsError() throws {
        let item = try StudyItem(
            id: "1",
            title: "Read Swift",
            estimatedMinutes: 20,
            category: .reading
        )

        var plan = try StudyPlan(items: [item])

        XCTAssertThrowsError(
            try plan.markCompleted(id: "999")
        )
    }
    
    func testTopLevelJSONArrayCanBeDecoded() throws {
        let json = """
        [
            {
                "id": "1",
                "title": "Read Swift",
                "estimatedMinutes": 20,
                "category": "reading",
                "isCompleted": false
            },
            {
                "id": "2",
                "title": "Practice Swift",
                "estimatedMinutes": 30,
                "category": "practice",
                "isCompleted": false
            }
        ]
        """

        let data = json.data(using: .utf8)!
        let plan = try StudyPlan.decode(from: data)

        XCTAssertEqual(plan.items.count, 2)
        XCTAssertEqual(plan.items[0].id, "2")
        XCTAssertEqual(plan.items[1].id, "1")
    }
    
    func testInvalidStudyItemJSONIsRejected() {
        let json = """
        {
            "id": "1",
            "title": "   ",
            "estimatedMinutes": 20,
            "category": "reading",
            "isCompleted": false
        }
        """

        let data = json.data(using: .utf8)!

        XCTAssertThrowsError(
            try JSONDecoder().decode(StudyItem.self, from: data)
        )
    }
    
    func testStudyPlanCanBeDecodedFromKeyedJSON() throws {
        let json = """
        {
            "items": [
                {
                    "id": "1",
                    "title": "Read Swift",
                    "estimatedMinutes": 20,
                    "category": "reading",
                    "isCompleted": false
                },
                {
                    "id": "2",
                    "title": "Practice Swift",
                    "estimatedMinutes": 30,
                    "category": "practice",
                    "isCompleted": false
                }
            ]
        }
        """

        let data = json.data(using: .utf8)!
        let plan = try JSONDecoder().decode(StudyPlan.self, from: data)

        XCTAssertEqual(plan.items.count, 2)
    }
    
    func testMarkCompletedCanBeCalledTwice() throws {
        let item = try StudyItem(
            id: "1",
            title: "Read Swift",
            estimatedMinutes: 20,
            category: .reading
        )

        var plan = try StudyPlan(items: [item])

        try plan.markCompleted(id: "1")
        try plan.markCompleted(id: "1")

        XCTAssertTrue(plan.items[0].isCompleted)
    }
}
