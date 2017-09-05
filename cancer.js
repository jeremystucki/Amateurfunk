questions = Array.from(document.getElementsByClassName('multichoice'));
alert(JSON.stringify(questions.map(getQuestionForElement).filter((e) => { return e !== undefined })));

function getQuestionForElement(element) {
    const answers = Array.from(element.getElementsByClassName('answer')[0].childNodes).map(getAnswerFromElement).filter((e) => { return e !== '' });
    const question = element.getElementsByClassName('qtext')[0].textContent;

    const correctAnswer = element.getElementsByClassName('rightanswer')[0].textContent.replace('Die richtige Antwort lautet:', '').trim();

    const id = element.getElementsByClassName('generalfeedback')[0].textContent.replace('Katalog', '').trim();

    if (document.getElementsByTagName('img') === undefined) {
        return undefined;
    }

    return {'question': question, 'id': id, 'answers': answers.map((answer) => {
        return {'answer': answer, 'correct': answer === correctAnswer}
    })}
}

function getAnswerFromElement(element) {
    return element.textContent.substr(3).trim()
}
