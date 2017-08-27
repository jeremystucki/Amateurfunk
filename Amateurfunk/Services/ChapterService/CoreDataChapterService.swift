import CoreData

class CoreDataChapterService: ChapterService {

    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func getAllChapters(fromSection section: Section) throws -> [Chapter] {
        let query = Chapter.createFetchRequest()
        query.predicate = NSPredicate(format: "%K == %@", "section", section)

        return try context.fetch(query)
    }

    func getSeletedChapters(fromSection section: Section) throws -> [Chapter] {
        let query = Chapter.createFetchRequest()
        query.predicate = NSPredicate(format: "selected == YES AND %K == %@", "section", section)

        return try context.fetch(query)
    }

    func setSelectedChapters(_ selectedChapters: [Chapter], forSection section: Section) throws {
        for chapter in try getAllChapters(fromSection: section) {
            chapter.selected = false
        }

        for chapter in selectedChapters {
            chapter.selected = true
        }

        try context.save()
    }

}
