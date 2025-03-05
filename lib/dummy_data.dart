List<Map<String, Object>> dummyData = [
  {
    "title": "English Lesson 1",
    "key_code": "123456",
    "subject": "English",
    "date_modified": "01-20-2024",
    "players": List.generate(20, (i) => {"username": "player${i + 1}", "score": (i * 5) % 100}),
    "quiz": [
      {"question": "What is a synonym for 'happy'?", "choice_a": "Sad", "choice_b": "Joyful", "choice_c": "Angry", "correct_answer": "b"},
      {"question": "What is the opposite of 'fast'?", "choice_a": "Slow", "choice_b": "Quick", "choice_c": "Speedy", "correct_answer": "a"},
      {"question": "What is the plural form of 'child'?", "choice_a": "Childs", "choice_b": "Children", "choice_c": "Childes", "correct_answer": "b"},
      {"question": "What is the past tense of 'go'?", "choice_a": "Gone", "choice_b": "Went", "choice_c": "Go", "correct_answer": "b"},
      {"question": "Which sentence is correct?", "choice_a": "She run fast.", "choice_b": "She runs fast.", "choice_c": "She running fast.", "correct_answer": "b"},
      {"question": "Which is a verb?", "choice_a": "Dance", "choice_b": "Table", "choice_c": "Blue", "correct_answer": "a"},
      {"question": "What is a synonym for 'big'?", "choice_a": "Large", "choice_b": "Tiny", "choice_c": "Small", "correct_answer": "a"},
      {"question": "Which word is an adjective?", "choice_a": "Happy", "choice_b": "Happiness", "choice_c": "Happily", "correct_answer": "a"},
      {"question": "What is a noun?", "choice_a": "Table", "choice_b": "Running", "choice_c": "Quickly", "correct_answer": "a"},
      {"question": "What is the correct punctuation for a list?", "choice_a": "I like apples oranges and bananas.", "choice_b": "I like apples, oranges, and bananas.", "choice_c": "I like, apples, oranges and bananas.", "correct_answer": "b"}
    ]
  },
  {
    "title": "Math Lesson 1",
    "key_code": "654321",
    "subject": "Mathematics",
    "date_modified": "01-19-2024",
    "players": List.generate(20, (i) => {"username": "player${i + 1}", "score": (i * 3) % 100}),
    "quiz": [
      {"question": "What is 5 + 3?", "choice_a": "7", "choice_b": "8", "choice_c": "9", "correct_answer": "b"},
      {"question": "What is 12 ÷ 4?", "choice_a": "3", "choice_b": "4", "choice_c": "6", "correct_answer": "a"},
      {"question": "What is 7 × 6?", "choice_a": "42", "choice_b": "36", "choice_c": "48", "correct_answer": "a"},
      {"question": "What is the square root of 64?", "choice_a": "6", "choice_b": "8", "choice_c": "10", "correct_answer": "b"},
      {"question": "What is 15 - 7?", "choice_a": "8", "choice_b": "6", "choice_c": "9", "correct_answer": "a"},
      {"question": "What is 100 ÷ 10?", "choice_a": "10", "choice_b": "20", "choice_c": "50", "correct_answer": "a"},
      {"question": "What is 9 × 9?", "choice_a": "81", "choice_b": "72", "choice_c": "90", "correct_answer": "a"},
      {"question": "What is 3 + 6 × 2?", "choice_a": "18", "choice_b": "15", "choice_c": "12", "correct_answer": "b"},
      {"question": "What is 25% of 200?", "choice_a": "25", "choice_b": "50", "choice_c": "75", "correct_answer": "b"},
      {"question": "What is 14 × 5?", "choice_a": "60", "choice_b": "70", "choice_c": "80", "correct_answer": "b"}
    ]
  },
  {
    "title": "Science Lesson 1",
    "key_code": "789123",
    "subject": "Science",
    "date_modified": "01-18-2024",
    "players": List.generate(20, (i) => {"username": "player${i + 1}", "score": (i * 4) % 100}),
    "quiz": [
      {"question": "What planet is closest to the Sun?", "choice_a": "Venus", "choice_b": "Earth", "choice_c": "Mercury", "correct_answer": "c"},
      {"question": "What is H2O?", "choice_a": "Oxygen", "choice_b": "Water", "choice_c": "Hydrogen", "correct_answer": "b"},
      {"question": "What gas do plants produce during photosynthesis?", "choice_a": "Oxygen", "choice_b": "Carbon dioxide", "choice_c": "Nitrogen", "correct_answer": "a"},
      {"question": "What organ pumps blood in the body?", "choice_a": "Lungs", "choice_b": "Heart", "choice_c": "Liver", "correct_answer": "b"},
      {"question": "What is the boiling point of water?", "choice_a": "100°C", "choice_b": "0°C", "choice_c": "50°C", "correct_answer": "a"},
      {"question": "What is the largest planet in the Solar System?", "choice_a": "Saturn", "choice_b": "Jupiter", "choice_c": "Neptune", "correct_answer": "b"},
      {"question": "What is the chemical symbol for gold?", "choice_a": "Gd", "choice_b": "Ag", "choice_c": "Au", "correct_answer": "c"},
      {"question": "What do bees produce?", "choice_a": "Milk", "choice_b": "Honey", "choice_c": "Wax", "correct_answer": "b"},
      {"question": "What is the main gas in the Earth's atmosphere?", "choice_a": "Oxygen", "choice_b": "Nitrogen", "choice_c": "Carbon dioxide", "correct_answer": "b"},
      {"question": "What is the process of water turning into vapor called?", "choice_a": "Condensation", "choice_b": "Evaporation", "choice_c": "Freezing", "correct_answer": "b"}
    ]
  },
  {
    "title": "History Lesson 1",
    "key_code": "456789",
    "subject": "History",
    "date_modified": "01-17-2024",
    "players": List.generate(20, (i) => {"username": "player${i + 1}", "score": (i * 6) % 100}),
    "quiz": [
      {"question": "Who discovered America?", "choice_a": "Christopher Columbus", "choice_b": "Marco Polo", "choice_c": "Ferdinand Magellan", "correct_answer": "a"},
      {"question": "What year did World War II end?", "choice_a": "1945", "choice_b": "1939", "choice_c": "1941", "correct_answer": "a"},
      {"question": "Who was the first President of the USA?", "choice_a": "Abraham Lincoln", "choice_b": "George Washington", "choice_c": "Thomas Jefferson", "correct_answer": "b"},
      {"question": "What was the name of the ship that sank in 1912?", "choice_a": "Titanic", "choice_b": "Olympic", "choice_c": "Britannic", "correct_answer": "a"},
      {"question": "What is the Great Wall of China?", "choice_a": "A wall", "choice_b": "A temple", "choice_c": "A palace", "correct_answer": "a"},
      {"question": "Who was known as the Iron Lady?", "choice_a": "Margaret Thatcher", "choice_b": "Indira Gandhi", "choice_c": "Queen Elizabeth II", "correct_answer": "a"},
      {"question": "What year was the Declaration of Independence signed?", "choice_a": "1776", "choice_b": "1783", "choice_c": "1800", "correct_answer": "a"},
      {"question": "What empire did Julius Caesar belong to?", "choice_a": "Greek", "choice_b": "Roman", "choice_c": "Egyptian", "correct_answer": "b"},
      {"question": "Who was known as the Sun King?", "choice_a": "Louis XIV", "choice_b": "Napoleon", "choice_c": "Charlemagne", "correct_answer": "a"},
      {"question": "What country did the Vikings come from?", "choice_a": "Norway", "choice_b": "France", "choice_c": "Italy", "correct_answer": "a"}
    ]
  },
  {
    "title": "Geography Lesson 1",
    "key_code": "987654",
    "subject": "Geography",
    "date_modified": "01-16-2024",
    "players": List.generate(20, (i) => {"username": "player${i + 1}", "score": (i * 2) % 100}),
    "quiz": [
      {"question": "What is the capital of France?", "choice_a": "Paris", "choice_b": "Berlin", "choice_c": "Madrid", "correct_answer": "a"},
      {"question": "What is the longest river in the world?", "choice_a": "Amazon", "choice_b": "Nile", "choice_c": "Yangtze", "correct_answer": "b"},
      {"question": "What continent is Australia in?", "choice_a": "Asia", "choice_b": "Australia", "choice_c": "Africa", "correct_answer": "b"},
      {"question": "What is the tallest mountain in the world?", "choice_a": "K2", "choice_b": "Mount Everest", "choice_c": "Kangchenjunga", "correct_answer": "b"},
      {"question": "What ocean is the largest?", "choice_a": "Atlantic", "choice_b": "Pacific", "choice_c": "Indian", "correct_answer": "b"},
      {"question": "What country has the most people?", "choice_a": "India", "choice_b": "China", "choice_c": "USA", "correct_answer": "b"},
      {"question": "What desert is the largest in the world?", "choice_a": "Sahara", "choice_b": "Gobi", "choice_c": "Kalahari", "correct_answer": "a"},
      {"question": "What is the smallest country in the world?", "choice_a": "Vatican City", "choice_b": "Monaco", "choice_c": "San Marino", "correct_answer": "a"},
      {"question": "What country is famous for maple syrup?", "choice_a": "USA", "choice_b": "Canada", "choice_c": "France", "correct_answer": "b"},
      {"question": "What is the capital of Japan?", "choice_a": "Tokyo", "choice_b": "Kyoto", "choice_c": "Osaka", "correct_answer": "a"}
    ]
  }
];
