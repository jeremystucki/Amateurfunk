protocol ChapterService {

    func getAllChapters(fromSection section: Section) throws -> [Chapter]

    func getSeletedChapters(fromSection section: Section) throws -> [Chapter]
    func setSelectedChapters(_ selectedChapters: [Chapter], forSection section: Section) throws

}
