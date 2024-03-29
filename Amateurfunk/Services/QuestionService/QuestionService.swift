protocol QuestionService {

    func getMarkedQuestions(forChapters chapters: [Chapter]) throws -> [Question]
    func getNumberOfMarkedQuestions(forChapters chapters: [Chapter]) throws -> Int

    func getQuestionForQuiz(fromChapters chapters: [Chapter]) throws -> Question
    func getQuestionForQuiz(fromChapters chapters: [Chapter], withStreak streak: Int) throws -> Question?

    func getQuestionsForExam(fromChapters chapters: [Chapter], numberOfQuestions: Int) throws -> [Question]

    func registerChosenAnswer(_ answer: Answer) throws

    func markQuestion(_ question: Question) throws
    func unmarkQuestion(_ question: Question) throws

    func getFlashcardsMetadata(forChapters chapters: [Chapter]) throws -> FlashcardsMetadata

}
