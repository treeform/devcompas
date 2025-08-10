import std/[dom, json, strformat, strutils, random]

type
  Question = object
    id: int
    question: string
    options: seq[QuestionOption]
  
  QuestionOption = object
    text: string
    abstract: int
    human: int
  
  Answer = object
    questionId: int
    selectedOption: int
    text: string
  
  Scores = object
    abstract: int
    human: int

var
  questions: seq[Question] = @[]
  currentQuestionIndex: int = 0
  scores = Scores(abstract: 0, human: 0)
  answers: seq[Answer] = @[]

proc showResults() # Forward declaration

proc showQuestion() =
  if currentQuestionIndex >= questions.len:
    showResults()
    return
  
  let question = questions[currentQuestionIndex]
  let questionText = document.getElementById("question-text")
  questionText.textContent = question.question.cstring
  
  let optionsContainer = document.getElementById("options-container")
  optionsContainer.innerHTML = ""
  
  for i, option in question.options:
    let optionElement = document.createElement("div")
    optionElement.className = "option"
    optionElement.innerHTML = fmt"""
      <input type="radio" id="option-{i}" name="answer" value="{i}">
      <label for="option-{i}" class="option-label">{option.text}</label>
    """.cstring
    optionsContainer.appendChild(optionElement)
  
  # Update progress
  let progress = ((currentQuestionIndex + 1).float / questions.len.float) * 100.0
  let progressFill = document.getElementById("progress-fill")
  progressFill.style.width = fmt"{progress}%".cstring
  
  let progressText = document.getElementById("progress-text")
  progressText.textContent = fmt"Question {currentQuestionIndex + 1} of {questions.len}".cstring
  
  # Reset next button
  let nextButton = document.getElementById("next-button")
  nextButton.setAttribute("disabled", "true")
  
  # Add event listeners to options
  let radioButtons = optionsContainer.querySelectorAll("input[name='answer']")
  for i in 0..<radioButtons.len:
    let radio = radioButtons[i]
    radio.addEventListener("change", proc(event: Event) =
      nextButton.removeAttribute("disabled")
    )

proc nextQuestion() =
  let selectedOption = document.querySelector("input[name='answer']:checked")
  if selectedOption.isNil:
    return
  
  let question = questions[currentQuestionIndex]
  let optionIndex = parseInt($selectedOption.getAttribute("value"))
  let option = question.options[optionIndex]
  
  # Record answer and update scores
  answers.add(Answer(
    questionId: question.id,
    selectedOption: optionIndex,
    text: option.text
  ))
  
  scores.abstract += option.abstract
  scores.human += option.human
  
  currentQuestionIndex += 1
  showQuestion()

proc createCompass() =
  let container = document.getElementById("compass-container")
  let size = 400
  let center = size div 2
  let maxScore = 40 # Theoretical max based on question scoring
  
  # Normalize scores to compass coordinates
  let x = center.float + (scores.abstract.float / maxScore.float) * (size.float * 0.35)
  let y = center.float - (scores.human.float / maxScore.float) * (size.float * 0.35)
  
  let svg = fmt"""
    <svg width="{size}" height="{size}" viewBox="0 0 {size} {size}">
      <!-- Background circle -->
      <circle cx="{center}" cy="{center}" r="{size.float * 0.4}" fill="none" stroke="#e9ecef" stroke-width="2"/>
      
      <!-- Grid lines -->
      <line x1="0" y1="{center}" x2="{size}" y2="{center}" stroke="#e9ecef" stroke-width="1"/>
      <line x1="{center}" y1="0" x2="{center}" y2="{size}" stroke="#e9ecef" stroke-width="1"/>
      
      <!-- Axis labels -->
      <text x="20" y="{center - 10}" text-anchor="start" class="axis-label">Concrete</text>
      <text x="{size - 20}" y="{center - 10}" text-anchor="end" class="axis-label">Abstract</text>
      <text x="{center}" y="20" text-anchor="middle" class="axis-label">Human-Friendly</text>
      <text x="{center}" y="{size - 10}" text-anchor="middle" class="axis-label">Computer-Friendly</text>
      
      <!-- User position -->
      <circle cx="{x}" cy="{y}" r="8" fill="#1a1a1a" stroke="#fffff8" stroke-width="2"/>
      <text x="{x}" y="{y + 25}" text-anchor="middle" class="position-label">You</text>
    </svg>
  """
  
  container.innerHTML = svg.cstring

proc getPhilosophyDescription(abstract: int, human: int): string =
  let isAbstract = abstract > 0
  let isHuman = human > 0
  
  if isAbstract and isHuman:
    return "You prefer elegant, high-level solutions that are intuitive and accessible to other developers. You likely favor functional programming, clear abstractions, and code that reads like prose."
  elif isAbstract and not isHuman:
    return "You appreciate mathematical elegance and optimal solutions. You probably enjoy languages with powerful type systems, formal methods, and code that leverages compiler optimizations."
  elif not isAbstract and isHuman:
    return "You value clarity and directness in code. You prefer explicit, step-by-step solutions that are easy to understand and debug, even if they require more lines of code."
  elif not isAbstract and not isHuman:
    return "You focus on efficiency and performance. You like to work close to the metal, optimize for speed and memory usage, and prefer direct control over system resources."
  else:
    return "You have a balanced approach to programming, adapting your style based on the specific requirements of each situation."

proc showResults() =
  let quizSection = document.getElementById("quiz-section")
  let resultsSection = document.getElementById("results-section")
  quizSection.classList.add("hidden")
  resultsSection.classList.remove("hidden")
  
  # Create compass SVG
  createCompass()
  
  # Show philosophy description
  let description = getPhilosophyDescription(scores.abstract, scores.human)
  let philosophyDesc = document.getElementById("philosophy-description")
  philosophyDesc.textContent = description.cstring
  
  # Show scores
  let abstractScore = document.getElementById("abstract-score")
  if scores.abstract > 0:
    abstractScore.textContent = fmt"+{scores.abstract} Abstract".cstring
  elif scores.abstract < 0:
    abstractScore.textContent = fmt"{scores.abstract} Concrete".cstring
  else:
    abstractScore.textContent = "0 Neutral".cstring
  
  let humanScore = document.getElementById("human-score")
  if scores.human > 0:
    humanScore.textContent = fmt"+{scores.human} Human-Friendly".cstring
  elif scores.human < 0:
    humanScore.textContent = fmt"{scores.human} Computer-Friendly".cstring
  else:
    humanScore.textContent = "0 Neutral".cstring

proc restartQuiz() =
  # Reset quiz state
  currentQuestionIndex = 0
  scores = Scores(abstract: 0, human: 0)
  answers = @[]
  
  # Randomize questions and answers for a fresh experience
  for question in questions.mitems:
    question.options.shuffle()
  questions.shuffle()
  
  # Show quiz section and hide results
  let resultsSection = document.getElementById("results-section")
  let quizSection = document.getElementById("quiz-section")
  resultsSection.classList.add("hidden")
  quizSection.classList.remove("hidden")
  
  # Start showing questions
  showQuestion()

proc loadQuestions() =
  try:
    # Read questions.json at compile time to avoid CORS issues
    const questionsJsonText = staticRead("questions.json")
    let jsonData = parseJson(questionsJsonText)
    
    questions = @[]
    for questionJson in jsonData["questions"]:
      var question = Question()
      question.id = questionJson["id"].getInt()
      question.question = questionJson["question"].getStr()
      question.options = @[]
      
      for optionJson in questionJson["options"]:
        let option = QuestionOption(
          text: optionJson["text"].getStr(),
          abstract: optionJson["abstract"].getInt(),
          human: optionJson["human"].getInt()
        )
        question.options.add(option)
      
      questions.add(question)
    
    # Start the quiz with randomized questions and answers
    restartQuiz()
  except:
    echo "Error loading questions"

proc setupEventHandlers() =
  let nextButton = document.getElementById("next-button")
  nextButton.addEventListener("click", proc(event: Event) = nextQuestion())
  
  let restartButton = document.getElementById("restart-button")
  restartButton.addEventListener("click", proc(event: Event) = restartQuiz())

proc main(event: Event) =
  # Initialize random number generator with current time
  randomize()
  setupEventHandlers()
  loadQuestions()

document.addEventListener("DOMContentLoaded", main) 