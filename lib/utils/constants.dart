// Text Constants
import 'package:audiobook/models/onboardModel.dart';

const kAppName = "Lizbook";

// Asset Constants
const kAppLogoWhite = "assets/svgs/logo-white.svg";
const kAppLogoColoured = "assets/svgs/logo.svg";

// Onboard Data

List<FOnBoardModel> kOnboardData = [
  FOnBoardModel(
    imagePath: "assets/svgs/listen-audiobooks.svg",
    title: "Massive Library",
    imageWidth: 0.9,
    subtitle:
        "More than 15000 fiction and non-fiction audiobooks for you to listen for free.",
  ),
  FOnBoardModel(
    imagePath: "assets/svgs/access-anywhere.svg",
    title: "Available Everywhere",
    imageWidth: 0.7,
    subtitle:
        "Download your favourite audiobooks and have acces to them anytime, anywhere you want.",
  ),
  FOnBoardModel(
    imagePath: "assets/svgs/new-experience.svg",
    title: "A New Experience",
    imageWidth: 0.7,
    subtitle:
        "High quality audio and expert narrators will make an immersive listening experience for you.",
  )
];
