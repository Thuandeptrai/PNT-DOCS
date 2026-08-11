const state = {
  days: [],
  quiz: null,
  selectedDay: 1,
};

const els = {
  daySelect: document.querySelector("#daySelect"),
  dayDate: document.querySelector("#dayDate"),
  dayTitle: document.querySelector("#dayTitle"),
  learnList: document.querySelector("#learnList"),
  docList: document.querySelector("#docList"),
  drillText: document.querySelector("#drillText"),
  outputList: document.querySelector("#outputList"),
  dailyQuestions: document.querySelector("#dailyQuestions"),
  progressBadge: document.querySelector("#progressBadge"),
  quizPanel: document.querySelector("#quizPanel"),
  quizMeta: document.querySelector("#quizMeta"),
  quizQuestions: document.querySelector("#quizQuestions"),
  submitQuiz: document.querySelector("#submitQuiz"),
  resetQuiz: document.querySelector("#resetQuiz"),
  scoreBox: document.querySelector("#scoreBox"),
};

function li(text) {
  const item = document.createElement("li");
  item.textContent = text;
  return item;
}

function renderList(target, items) {
  target.replaceChildren(...items.map(li));
}

function quizStorageKey(day = state.selectedDay) {
  return `pnt-spk-day-${String(day).padStart(2, "0")}-quiz`;
}

function loadSavedQuiz(day = state.selectedDay) {
  try {
    return JSON.parse(localStorage.getItem(quizStorageKey(day)) || "{}");
  } catch {
    return {};
  }
}

function saveQuiz(payload) {
  localStorage.setItem(quizStorageKey(), JSON.stringify(payload));
}

function quizPath(day) {
  if (day === 1) return "./data/day-01-diagnostic.json";
  return `./data/day-${String(day).padStart(2, "0")}-quiz.json`;
}

async function loadQuiz(day) {
  els.quizQuestions.replaceChildren();
  els.scoreBox.textContent = "";
  els.quizMeta.textContent = "Đang tải quiz...";

  const response = await fetch(quizPath(day));
  if (!response.ok) {
    state.quiz = null;
    els.quizMeta.textContent = "Ngày này chưa có quiz tương tác.";
    els.quizPanel.hidden = true;
    renderProgress();
    return;
  }

  state.quiz = await response.json();
  els.quizPanel.hidden = false;
  renderQuiz();
  renderProgress();
}

async function renderDay(dayNumber) {
  const day = state.days.find((item) => item.day === dayNumber) || state.days[0];
  state.selectedDay = day.day;

  els.dayDate.textContent = `Ngày ${day.day} - ${day.date}`;
  els.dayTitle.textContent = day.title;
  renderList(els.learnList, day.learn);
  renderList(els.docList, day.docs);
  els.drillText.textContent = day.drill;
  renderList(els.outputList, day.output);
  renderList(els.dailyQuestions, day.questions);

  await loadQuiz(day.day);
}

function renderProgress() {
  const saved = loadSavedQuiz();
  if (!state.quiz) {
    els.progressBadge.textContent = "Không có quiz";
    return;
  }
  if (saved.score !== undefined) {
    els.progressBadge.textContent = `Quiz: ${saved.score}/${state.quiz.questions.length}`;
  } else if (state.selectedDay === 1) {
    els.progressBadge.textContent = "Chưa làm diagnostic";
  } else {
    els.progressBadge.textContent = "Chưa làm quiz ngày này";
  }
}

function renderQuiz() {
  if (!state.quiz) return;

  els.quizMeta.textContent = `${state.quiz.title}. ${state.quiz.source_note || ""}`;
  const saved = loadSavedQuiz();
  const answers = saved.answers || {};

  const blocks = state.quiz.questions.map((question, index) => {
    const block = document.createElement("article");
    block.className = "quiz-item";
    block.dataset.id = question.id;

    const title = document.createElement("h3");
    title.textContent = `${index + 1}. [${question.topic}] ${question.question}`;
    block.appendChild(title);

    question.choices.forEach((choice, choiceIndex) => {
      const label = document.createElement("label");
      label.className = "choice";

      const input = document.createElement("input");
      input.type = "radio";
      input.name = question.id;
      input.value = String(choiceIndex);
      input.checked = answers[question.id] === choiceIndex;

      const span = document.createElement("span");
      span.textContent = choice;

      label.append(input, span);
      block.appendChild(label);
    });

    const explanation = document.createElement("div");
    explanation.className = "explanation";
    explanation.textContent = question.explanation;
    block.appendChild(explanation);

    return block;
  });

  els.quizQuestions.replaceChildren(...blocks);
  if (saved.score !== undefined) {
    applyQuizResult(saved.answers || {});
    els.scoreBox.textContent = `Điểm đã lưu: ${saved.score}/${state.quiz.questions.length}`;
  }
}

function collectAnswers() {
  const answers = {};
  state.quiz.questions.forEach((question) => {
    const checked = document.querySelector(`input[name="${question.id}"]:checked`);
    if (checked) answers[question.id] = Number(checked.value);
  });
  return answers;
}

function applyQuizResult(answers) {
  let score = 0;
  state.quiz.questions.forEach((question) => {
    const block = document.querySelector(`[data-id="${question.id}"]`);
    const selected = answers[question.id];
    const isCorrect = selected === question.answer;
    if (isCorrect) score += 1;
    block.classList.toggle("correct", isCorrect);
    block.classList.toggle("wrong", selected !== undefined && !isCorrect);
  });
  return score;
}

function submitQuiz() {
  if (!state.quiz) return;
  const answers = collectAnswers();
  const score = applyQuizResult(answers);
  saveQuiz({ answers, score, savedAt: new Date().toISOString() });
  els.scoreBox.textContent = `Điểm: ${score}/${state.quiz.questions.length}`;
  renderProgress();
}

function resetQuiz() {
  localStorage.removeItem(quizStorageKey());
  document.querySelectorAll("#quizQuestions input").forEach((input) => {
    input.checked = false;
  });
  document.querySelectorAll(".quiz-item").forEach((block) => {
    block.classList.remove("correct", "wrong");
  });
  els.scoreBox.textContent = "";
  renderProgress();
}

async function init() {
  const daysResponse = await fetch("../study-days/all-days.json");
  state.days = await daysResponse.json();

  state.days.forEach((day) => {
    const option = document.createElement("option");
    option.value = String(day.day);
    option.textContent = `Ngày ${day.day}: ${day.title}`;
    els.daySelect.appendChild(option);
  });

  els.daySelect.addEventListener("change", async (event) => {
    await renderDay(Number(event.target.value));
  });
  els.submitQuiz.addEventListener("click", submitQuiz);
  els.resetQuiz.addEventListener("click", resetQuiz);

  await renderDay(1);
}

init().catch((error) => {
  document.body.innerHTML = `<main class="panel"><h1>Không tải được dữ liệu</h1><p>${error.message}</p></main>`;
});
