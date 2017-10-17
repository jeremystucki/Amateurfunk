// TODO: Use new data model

const questions = Array.from(document.getElementsByClassName('multichoice'));

level = prompt('Level');
section = prompt('Section');

alert(JSON.stringify({section, 'questions': questions.map(getQuestionForElement).filter((element) => element != null)}));

function getQuestionForElement(element) {
    const correctAnswer = element.getElementsByClassName('rightanswer')[0].textContent.replace('Die richtige Antwort lautet:', '').trim();
    const answers = Array.from(element.getElementsByClassName('answer')[0].childNodes)
                         .map(getAnswerFromElement)
                         .filter((element) => element !== '')
                         .map((answer) => {
                           return { answer, correct: answer === correctAnswer };
                         });

    const question = element.getElementsByClassName('qtext')[0].textContent;
    const $id = element.getElementsByClassName('generalfeedback')[0];

    if ($id == null) return;

    const id = $id.textContent.replace('Katalog', '').trim();

    if (document.getElementsByTagName('img') == null) return;

    return { question, id, answers, level };
}

function getAnswerFromElement(element) {
    return element.textContent.substr(3).trim();
}
