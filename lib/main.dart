import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriviaMaster quiz & ads',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF673AB7),
          primary: const Color(0xFF673AB7),
          secondary: const Color(0xFF03A9F4),
          background: const Color(0xFFF5F5FC),
        ),
        cardTheme: const CardTheme(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
      home: const CategoriesScreen(),
    );
  }
}

// ==========================================
// AD HELPER CLASS (AdMob Configuration)
// ==========================================
class AdHelper {
  // Official Google AdMob Test Ad Units
  static String get bannerAdUnitId {
    // android test banner: ca-app-pub-3940256099942544/6300978111
    // ios test banner: ca-app-pub-3940256099942544/2934735716
    return 'ca-app-pub-3940256099942544/6300978111';
  }

  static String get interstitialAdUnitId {
    // android test interstitial: ca-app-pub-3940256099942544/1033173712
    // ios test interstitial: ca-app-pub-3940256099942544/4411468910
    return 'ca-app-pub-3940256099942544/1033173712';
  }
}

// ==========================================
// DATA MODELS
// ==========================================
class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String fact;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.fact,
  });
}

class QuizCategory {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final List<Question> questions;

  const QuizCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.questions,
  });
}

// Shared Questions List
final List<QuizCategory> categoriesData = [
  const QuizCategory(
    id: 'tech',
    title: 'Tech & Coding',
    icon: Icons.code,
    color: Color(0xFF673AB7),
    questions: [
      Question(
        questionText: 'Which programming language is predominantly used to write native Flutter apps?',
        options: ['Kotlin', 'Dart', 'Swift', 'JavaScript'],
        correctAnswerIndex: 1,
        fact: 'Flutter is built around Dart, a language developed by Google optimized for client-side app execution.',
      ),
      Question(
        questionText: 'What does "API" stand for in software engineering?',
        options: [
          'Application Programming Interface',
          'Automated Product Integration',
          'Applied Program Instructions',
          'Advanced Protocols Internet'
        ],
        correctAnswerIndex: 0,
        fact: 'APIs act as bridges allowing different software systems, apps, or databases to communicate with each other.',
      ),
      Question(
        questionText: 'In Git, how do you verify the active state, modifications, and untracked files in your repository?',
        options: ['git commit', 'git diff', 'git status', 'git checkout'],
        correctAnswerIndex: 2,
        fact: '"git status" shows the exact working tree status, showing staged vs unstaged vs untracked file entries.',
      ),
      Question(
        questionText: 'Which HTML5 tag is designed specifically to capture self-drawing graphics, interactive visual charts, or game surfaces natively?',
        options: ['<canvas>', '<paint>', '<graphics>', '<svg>'],
        correctAnswerIndex: 0,
        fact: 'The HTML5 <canvas> tag exposes a flexible scriptable rendering grid supporting instant 2D or 3D graphics.',
      ),
      Question(
        questionText: 'Which of the following is NOT an official state management solution commonly adopted in Flutter apps?',
        options: ['Provider', 'Bloc', 'Riverpod', 'ReduxCSS'],
        correctAnswerIndex: 3,
        fact: 'While Provider, Bloc, and Riverpod are highly popular Dart state solutions, ReduxCSS is a fabricated term.',
      ),
    ],
  ),
  const QuizCategory(
    id: 'science',
    title: 'Science & Cosmos',
    icon: Icons.rocket_launch,
    color: Color(0xFF009688),
    questions: [
      Question(
        questionText: 'Approximately how long does it take for light radiating from the Sun to travel to Earth?',
        options: ['8 seconds', '8 minutes', '8 hours', '8 days'],
        correctAnswerIndex: 1,
        fact: 'Light journeys at 186,000 miles/second, taking an average of 8 minutes and 20 seconds to reach Earth.',
      ),
      Question(
        questionText: 'Which element represents the most abundant chemical substance in the known universe?',
        options: ['Helium', 'Oxygen', 'Hydrogen', 'Carbon'],
        correctAnswerIndex: 2,
        fact: 'Hydrogen constitutes roughly 75% of all baryonic cosmological matter, acting as stellar stellar fuel.',
      ),
      Question(
        questionText: 'What biological organelle is widely referred to as the powerhouse of the cell?',
        options: ['Nucleus', 'Mitochondria', 'Ribosome', 'Golgi Apparatus'],
        correctAnswerIndex: 1,
        fact: 'Mitochondria generate adenosine triphosphate (ATP) which serves as the cellular chemical energy currency.',
      ),
      Question(
        questionText: 'Which planet possesses the most intense gravity in our Solar System, second to the Sun?',
        options: ['Saturn', 'Jupiter', 'Neptune', 'Venus'],
        correctAnswerIndex: 1,
        fact: 'Jupiter has more than double the combined mass of all other planets, maintaining high surface gravity.',
      ),
      Question(
        questionText: 'What is the absolute zero temperature threshold in Celsius?',
        options: ['-100° C', '-273.15° C', '0° C', '-459.67° C'],
        correctAnswerIndex: 1,
        fact: 'Absolute zero (0 Kelvin) represents -273.15°C, where molecular motion reaches minimum activity.',
      ),
    ],
  ),
  const QuizCategory(
    id: 'history',
    title: 'History & Geo',
    icon: Icons.public,
    color: Color(0xFFFF9800),
    questions: [
      Question(
        questionText: 'Which river flows as the longest natural waterway across the globe?',
        options: ['Amazon River', 'Nile River', 'Yangtze River', 'Mississippi River'],
        correctAnswerIndex: 1,
        fact: 'The Nile runs roughly 6,650 kilometers (4,132 miles), primarily serving Egypt and Sudan.',
      ),
      Question(
        questionText: 'What momentous event directly sparked the entry of the United States into World War II?',
        options: ['The Invasion of Poland', 'The Bombing of Pearl Harbor', 'The Battle of Britain', 'The Treaty of Versailles'],
        correctAnswerIndex: 1,
        fact: 'The surprise military attack on Pearl Harbor on December 7, 1941, led to the US immediate declaration of war.',
      ),
      Question(
        questionText: 'Which ancient Mediterranean civilization is credited with constructing the historic city of Machu Picchu?',
        options: ['The Aztecs', 'The Mayans', 'The Romans', 'The Incas'],
        correctAnswerIndex: 3,
        fact: 'Machu Picchu is an Incan fortress perched high in the Peruvian Andes, built around 1450 AD.',
      ),
      Question(
        questionText: 'What modern country encompasses the geographic region historically known as Mesopotamia?',
        options: ['Egypt', 'Iraq', 'Turkey', 'Iran'],
        correctAnswerIndex: 1,
        fact: 'Mesopotamia, the "cradle of civilization," was situated between the Tigris and Euphrates, mostly within modern Iraq.',
      ),
      Question(
        questionText: 'In which European city is the world-renowned Colosseum amphitheater situated?',
        options: ['Athens', 'Paris', 'Rome', 'Madrid'],
        correctAnswerIndex: 2,
        fact: 'The Colosseum was designed in the center of Rome, Italy, under Emperor Vespasian around 72 AD.',
      ),
    ],
  ),
];

// ==========================================
// CATEGORIES SCREEN
// ==========================================
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _totalHighScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TriviaMaster Challenge',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header stats
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
              child: Column(
                children: [
                  const Text(
                    'Choose Quiz Category',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Demonstrate your general knowledge. Complete quizes to score!',
                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Category List
            Expanded(
              child: ListView.builder(
                itemCount: categoriesData.length,
                itemBuilder: (context, index) {
                  final category = categoriesData[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(category: category),
                          ),
                        ).then((_) {
                          // Trigger UI update when returing in case state changed
                          setState(() {});
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              category.color.withOpacity(0.85),
                              category.color,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.white24,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                category.icon,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${category.questions.length} Challenging Questions',
                                    style: const TextStyle(
                                      color: Colors.white74,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// QUIZ PLAY SCREEN WITH ADS
// ==========================================
class QuizScreen extends StatefulWidget {
  final QuizCategory category;

  const QuizScreen({super.key, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _isAnswered = false;

  // Real AdMob Banner Ad Object
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  // Real AdMob Interstitial Ad Object
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  // Load Real AdMob Banner with Test Unit
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    );

    _bannerAd!.load();
  }

  // Load Real AdMob Interstitial with Test Unit
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdLoaded = true;
          
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _navigateToResults();
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
              _navigateToResults();
            },
          );
        },
        onAdFailedToLoad: (err) {
          debugPrint('InterstitialAd failed to load: $err');
          _isInterstitialAdLoaded = false;
        },
      ),
    );
  }

  void _handleOptionSelection(int optionIndex) {
    if (_isAnswered) return;

    setState(() {
      _selectedAnswerIndex = optionIndex;
      _isAnswered = true;
      if (optionIndex == widget.category.questions[_currentQuestionIndex].correctAnswerIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.category.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
        _isAnswered = false;
      });
    } else {
      // Quiz completed! Trigger AdMob Interstitial Ad helper
      _showInterstitialAdAndFinish();
    }
  }

  void _showInterstitialAdAndFinish() {
    if (_isInterstitialAdLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
    } else {
      // If ad was not loaded yet, directly navigate to results screen
      _navigateToResults();
    }
  }

  void _navigateToResults() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          score: _score,
          totalQuestions: widget.category.questions.length,
          categoryTitle: widget.category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.category.questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / widget.category.questions.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${widget.category.title} Quiz'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator Tracker
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_currentQuestionIndex + 1}/${widget.category.questions.length}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Score: $_score',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    borderRadius: BorderRadius.circular(8),
                    minHeight: 8,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(widget.category.color),
                  ),
                ],
              ),
            ),

            // Question Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: widget.category.color.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: widget.category.color.withOpacity(0.12),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        currentQuestion.questionText,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Multiple Choice Options
                    ...List.generate(
                      currentQuestion.options.length,
                      (index) {
                        final option = currentQuestion.options[index];
                        Color cardColor = Colors.white;
                        Color textColor = Colors.black87;
                        Color borderColor = Colors.grey[350]!;

                        if (_isAnswered) {
                          if (index == currentQuestion.correctAnswerIndex) {
                            cardColor = Colors.green[50]!;
                            textColor = Colors.green[800]!;
                            borderColor = Colors.green[400]!;
                          } else if (index == _selectedAnswerIndex) {
                            cardColor = Colors.red[50]!;
                            textColor = Colors.red[800]!;
                            borderColor = Colors.red[300]!;
                          }
                        } else if (_selectedAnswerIndex == index) {
                          cardColor = widget.category.color.withOpacity(0.1);
                          borderColor = widget.category.color;
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor, width: 1.5),
                          ),
                          child: InkWell(
                            onTap: () => _handleOptionSelection(index),
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: _isAnswered
                                            ? (index == currentQuestion.correctAnswerIndex
                                                ? Colors.green
                                                : (index == _selectedAnswerIndex
                                                    ? Colors.red
                                                    : Colors.grey))
                                            : widget.category.color,
                                        width: 2,
                                      ),
                                    ),
                                    child: _isAnswered && index == currentQuestion.correctAnswerIndex
                                        ? const Icon(Icons.check, size: 18, color: Colors.green)
                                        : _isAnswered && index == _selectedAnswerIndex
                                            ? const Icon(Icons.close, size: 18, color: Colors.red)
                                            : Text(
                                                String.fromCharCode(65 + index),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: _isAnswered ? Colors.grey : widget.category.color,
                                                ),
                                              ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    // Educational Fact box when answered
                    if (_isAnswered) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.lightbulb, color: Colors.blue[800], size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                currentQuestion.fact,
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Navigation Button Block
            if (_isAnswered)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.category.color,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _nextQuestion,
                  child: Text(
                    _currentQuestionIndex == widget.category.questions.length - 1
                        ? 'Finish Quiz & Show Ad'
                        : 'Next Question',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            // REAL GOOGLE ADMOB BANNER AD INTEGRATED HERE AT BOTTOM
            if (_isBannerAdLoaded && _bannerAd != null)
              Container(
                alignment: Alignment.center,
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                color: Colors.grey[100],
                child: AdWidget(ad: _bannerAd!),
              )
            else
              Container(
                height: 50,
                color: Colors.grey[100],
                alignment: Alignment.center,
                child: const Text(
                  'AdMob TEST Banner Ad Slot',
                  style: TextStyle(color: Colors.grey, fontSize: 11, fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// RESULTS SCREEN
// ==========================================
class ResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String categoryTitle;

  const ResultsScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    final scorePercentage = (score / totalQuestions) * 100;
    String feedback = 'Excellent job!';
    IconData feedbackIcon = Icons.emoji_events;
    Color feedbackColor = const Color(0xFFFFB300);

    if (scorePercentage < 40) {
      feedback = 'Keep practicing!';
      feedbackIcon = Icons.sentiment_dissatisfied;
      feedbackColor = Colors.red;
    } else if (scorePercentage < 80) {
      feedback = 'Well done!';
      feedbackIcon = Icons.thumb_up_alt;
      feedbackColor = Colors.blue;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                feedbackIcon,
                size: 90,
                color: feedbackColor,
              ),
              const SizedBox(height: 24),
              const Text(
                'Quiz Completed!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Category: $categoryTitle',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),

              // Animated Score Arc Card
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      '$score / $totalQuestions',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your Score (${scorePercentage.toInt()}%)',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      feedback,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Return Home Button
              ElevatedButton.icon(
                icon: const Icon(Icons.home),
                label: const Text('Back to Categories'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              const SizedBox(height: 12),
              
              const Text(
                'AdMob Interstitial Ad triggered immediately prior to this results screen.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
