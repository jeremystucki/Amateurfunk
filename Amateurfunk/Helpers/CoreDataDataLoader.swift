import CoreData

class CoreDataDataLoader {

    let context: NSManagedObjectContext

    let sectionFactory: ManagedObjectFactory<Section>
    let chapterFactory: ManagedObjectFactory<Chapter>
    let questionFactory: ManagedObjectFactory<Question>
    let textAnswerFactory: ManagedObjectFactory<TextAnswer>

    init(context: NSManagedObjectContext) {
        self.context = context

        self.sectionFactory = ManagedObjectFactory<Section>(context: context)
        self.chapterFactory = ManagedObjectFactory<Chapter>(context: context)
        self.questionFactory = ManagedObjectFactory<Question>(context: context)
        self.textAnswerFactory = ManagedObjectFactory<TextAnswer>(context: context)
    }

}

extension CoreDataDataLoader: DataLoader {

    func removeAllSections() throws {
        let query = Section.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: query)

        try context.execute(deleteRequest)
    }

    func loadSectionFromFile(_ file: URL) throws {
        let data = try Data(contentsOf: file)

        let decoder = JSONDecoder()
        let section = try decoder.decode(Section.self, from: data)

        context.insert(section)
        try context.save()
    }

}
