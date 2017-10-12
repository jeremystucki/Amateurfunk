protocol QuestionService {

    func getMarkedQuestions(forChapters chapters: [Chapter]) throws -> [Question]
    func getNumberOfMarkedQuestions(forChapters chapters: [Chapter]) throws -> Int

    func getQuestionForQuiz(fromChapters chapters: [Chapter]) throws -> Question
    func registerChosenAnswer(_ answer: Answer) throws

    func markQuestion(_ question: Question) throws
    func unmarkQuestion(_ question: Question) throws

    func getFlashcardsMetadata(forChapters chapters: [Chapter]) throws -> FlashcardsMetadata

}
