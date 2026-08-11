const fs = require("fs");
const path = require("path");

const root = __dirname;
const days = JSON.parse(fs.readFileSync(path.join(root, "study-days", "all-days.json"), "utf8"));
const outDir = path.join(root, "web", "data");

function pickOther(values, answer, count) {
  const unique = [...new Set(values.filter((value) => value && value !== answer))];
  return unique.slice(0, count);
}

function rotateChoices(answer, distractors, seed) {
  const choices = [answer, ...distractors].slice(0, 4);
  while (choices.length < 4) choices.push("Không phải lựa chọn đúng cho ngày này");
  const offset = seed % choices.length;
  const rotated = [...choices.slice(offset), ...choices.slice(0, offset)];
  return {
    choices: rotated,
    answer: rotated.indexOf(answer),
  };
}

function buildQuestion(day, id, topic, question, answer, distractors, explanation) {
  const mixed = rotateChoices(answer, distractors, day.day + id.length);
  return {
    id: `D${String(day.day).padStart(2, "0")}-${id}`,
    topic,
    question,
    choices: mixed.choices,
    answer: mixed.answer,
    explanation,
  };
}

function buildQuiz(day) {
  const allTitles = days.map((item) => item.title);
  const allDocs = days.flatMap((item) => item.docs);
  const allDrills = days.map((item) => item.drill);
  const allOutputs = days.flatMap((item) => item.output);
  const allQuestions = days.flatMap((item) => item.questions);

  const primaryDoc = day.docs[0] || "Tài liệu tương ứng với chủ đề trong ngày";
  const primaryOutput = day.output[0] || "Cập nhật nhật ký câu sai";
  const primaryLearn = day.learn[0] || day.title;
  const priorityQuestion = day.questions[0] || "Câu hỏi trọng tâm trong ngày là gì?";

  const questions = [
    buildQuestion(
      day,
      "Q01",
      "Chủ đề",
      `Chủ đề chính của ngày ${day.day} là gì?`,
      day.title,
      pickOther(allTitles, day.title, 3),
      "Chọn đúng chủ đề giúp người học không học lan man."
    ),
    buildQuestion(
      day,
      "Q02",
      "Mục tiêu",
      "Mục tiêu học đầu tiên của ngày này là gì?",
      primaryLearn,
      pickOther(days.flatMap((item) => item.learn), primaryLearn, 3),
      "Mục tiêu đầu tiên là trọng tâm mở đầu của buổi học."
    ),
    buildQuestion(
      day,
      "Q03",
      "Tài liệu",
      "Tài liệu nào nên được mở đầu tiên trong ngày này?",
      primaryDoc,
      pickOther(allDocs, primaryDoc, 3),
      "Tài liệu đầu tiên trong data.json là nguồn ưu tiên cho ngày học đó."
    ),
    buildQuestion(
      day,
      "Q04",
      "Bài tập",
      "Bài tập chính của ngày này là gì?",
      day.drill,
      pickOther(allDrills, day.drill, 3),
      "Bài tập chính là phần bắt buộc sau khi đọc tài liệu và trả lời câu hỏi."
    ),
    buildQuestion(
      day,
      "Q05",
      "Kết quả",
      "Kết quả đầu ra cần tạo sau buổi học là gì?",
      primaryOutput,
      pickOther(allOutputs, primaryOutput, 3),
      "Mỗi ngày cần tạo một sản phẩm học tập cụ thể để theo dõi tiến bộ."
    ),
    buildQuestion(
      day,
      "Q06",
      "Câu hỏi trọng tâm",
      "Câu hỏi nào nên được hỏi đầu tiên trong buổi học?",
      priorityQuestion,
      pickOther(allQuestions, priorityQuestion, 3),
      "Câu hỏi đầu tiên thường định hướng phần kiến thức cần kiểm tra trong ngày."
    ),
    buildQuestion(
      day,
      "Q07",
      "Nhật ký câu sai",
      "Sau khi làm quiz hoặc câu hỏi trong ngày, việc nào là bắt buộc?",
      "Ghi câu sai hoặc câu còn phân vân vào mistake log",
      [
        "Xóa toàn bộ câu sai để tránh áp lực",
        "Chỉ đọc thêm chương mới, không sửa lỗi",
        "Bỏ qua các câu đã đoán đúng",
      ],
      "Nhật ký câu sai là công cụ quan trọng nhất để tránh lặp lại lỗi."
    ),
    buildQuestion(
      day,
      "Q08",
      "Cách trả lời",
      "Khi trả lời một câu hỏi lâm sàng, cấu trúc nào nên được ưu tiên?",
      "Chẩn đoán, dấu hiệu chính, cận lâm sàng, chẩn đoán phân biệt, xử trí đầu tiên, bẫy cần tránh",
      [
        "Chỉ chọn đáp án rồi chuyển câu khác",
        "Chỉ học thuộc tên bệnh",
        "Chỉ đọc giải thích sau khi làm sai",
      ],
      "Cấu trúc trả lời giúp biến câu hỏi thành năng lực suy luận."
    ),
  ];

  return {
    day: day.day,
    title: `Quiz tương tác ngày ${day.day} - ${day.title}`,
    source_note: "Quiz định hướng học tập được sinh từ study-days/all-days.json. Dùng để kiểm tra người học có nắm đúng mục tiêu, tài liệu và việc cần làm trong ngày.",
    questions,
  };
}

for (const day of days) {
  if (day.day === 1) continue;
  const quiz = buildQuiz(day);
  const file = path.join(outDir, `day-${String(day.day).padStart(2, "0")}-quiz.json`);
  fs.writeFileSync(file, JSON.stringify(quiz, null, 2), "utf8");
}

console.log(`Generated ${days.length - 1} daily quiz files.`);
