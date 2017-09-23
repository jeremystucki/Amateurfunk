import Foundation
import CoreData

class CoreDataDataloaderService: DataloaderService {

    let context: NSManagedObjectContext

    var chapterFactory: ManagedObjectFactory<Chapter>
    var questionFactory: ManagedObjectFactory<Question>
    var textAnswerFactory: ManagedObjectFactory<TextAnswer>

    init(context: NSManagedObjectContext) {
        self.context = context

        chapterFactory = ManagedObjectFactory<Chapter>(context: context)
        questionFactory = ManagedObjectFactory<Question>(context: context)
        textAnswerFactory = ManagedObjectFactory<TextAnswer>(context: context)
    }
    
    // TODO: Duplicated
    private func getSection(name: String) -> Section {
        let query = Section.createFetchRequest()
        query.predicate = NSPredicate(format: "name == %@", name)
        
        return try! context.fetch(query).first!
    }

    func resetSections() throws {
        let technikSection = getSection(name: "Technik")
        technikSection.chapters = getChaptersFromFile(Bundle.main.resourceURL!.appendingPathComponent("bakom_technik_hb3"))
    }

    private func getSectionFromFile(_ file: URL, sectionTitle: String) -> Section {
        let section = sectionFactory.create()
        section.name = sectionTitle
        section.chapters = getChaptersFromFile(file)

        return section
    }

    private func getChaptersFromFile(_ file: URL) -> Set<Chapter> {
        let data = NSData(contentsOf: file)!

        guard let json = try? JSONSerialization.jsonObject(with: data as Data) as? [[String: Any]] else {
            return Set<Chapter>()
        }

        var chapters = [String: Chapter]()

        for element in json! {
            guard let query = element["question"] as? String else {
                continue
            }

            guard let correctAnswer = element["correct_answer"] as? Int else {
                continue
            }

            guard let answers = element["answers"] as? [String] else {
                continue
            }

            guard let chapterName = element["chapter"] as? String else {
                continue
            }

            if chapters[chapterName] == nil {
                let chapter = chapterFactory.create()
                chapter.title = chapterName

                chapters[chapterName] = chapter
            }

            let question = questionFactory.create()
            question.query = query
            question.answers = Set<Answer>()

            for (index, answer) in answers.enumerated() {
                let answerObject = textAnswerFactory.create()

                answerObject.answer = answer
                answerObject.correct = (correctAnswer == index)

                question.answers.insert(answerObject)
            }

            chapters[chapterName]!.questions.insert(question)
        }

        return Set(chapters.map({ $0.value }))
    }

}
