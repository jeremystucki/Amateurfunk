protocol QuestionProvider {
    func hasNext() throws -> Bool
    func getNext() throws -> Question
}
