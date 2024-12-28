import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../../models/movie_model.dart';

mixin MovieBlocHelper {
  Future<List<Movie>> fetchTrendingMovies() async {
    List<Movie> movies = [];
    final url = Uri.parse(
        'https://api.themoviedb.org/3/trending/all/day?language=en-US');
    final headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhNWVjYjFkOWFkMmViMDg4ZmM0YzFiMmUyMjVhYmQ4YSIsIm5iZiI6MTczNTM2MDg2Ni41NzYsInN1YiI6IjY3NmY4MTYyZmI4YTIyOWM2NzkyODdhMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.F7lm9dfAevxLtNDtGMB8CR-l0vvQlg0n3x8XbPPyJqo',
      'accept': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        //for(var ele:)
        final temp = data['results'];
        for (final ele in temp) {
          String movieName = "Na";
          if (ele['name'] != null) {
            movieName = ele['name'];
          } else if (ele['title'] != null) {
            movieName = ele['title'];
          } else if (ele['original_title'] != null) {
            movieName = ele['original_title'];
          }
          Movie newMovie = Movie(
              movieTitle: movieName,
              genereId: ele['genre_ids'] ?? [],
              favHandler: () {},
              bannerImgUrl: ele['poster_path'] ?? "NA",
              isFav: false);
          movies.add(newMovie);
          // print(newMovie.bannerImgUrl);
          // print(newMovie.genereId);
          // print(newMovie.isFav);
          // print(newMovie.movieTitle);
        }
        return movies;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}


/*
{
  "page": 1,
  "results": [
    {
      "backdrop_path": "/cI3nL7CgGmPr0CizCwFHBpDkKyB.jpg",
      "id": 1156593,
      "title": "Culpa tuya",
      "original_title": "Culpa tuya",
      "overview": "The love between Noah and Nick seems unwavering despite their parents' attempts to separate them. But his job and her entry into college open up their lives to new relationships that will shake the foundations of both their relationship and the Leister family itself.",
      "poster_path": "/1sQA7lfcF9yUyoLYC0e6Zo3jmxE.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "es",
      "genre_ids": [
        10749,
        18
      ],
      "popularity": 2827.485,
      "release_date": "2024-12-26",
      "video": false,
      "vote_average": 7.9,
      "vote_count": 94
    },
    {
      "backdrop_path": "/euYIwmwkmz95mnXvufEmbL6ovhZ.jpg",
      "id": 558449,
      "title": "Gladiator II",
      "original_title": "Gladiator II",
      "overview": "Years after witnessing the death of the revered hero Maximus at the hands of his uncle, Lucius is forced to enter the Colosseum after his home is conquered by the tyrannical Emperors who now lead Rome with an iron fist. With rage in his heart and the future of the Empire at stake, Lucius must look to his past to find strength and honor to return the glory of Rome to its people.",
      "poster_path": "/2cxhvwyEwRlysAmRH4iodkvo0z5.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        28,
        12,
        18
      ],
      "popularity": 4194.404,
      "release_date": "2024-11-05",
      "video": false,
      "vote_average": 6.752,
      "vote_count": 1467
    },
    {
      "backdrop_path": "/A6vAMO3myroRfBwSZetY4GVqaW4.jpg",
      "id": 839033,
      "title": "The Lord of the Rings: The War of the Rohirrim",
      "original_title": "The Lord of the Rings: The War of the Rohirrim",
      "overview": "183 years before the events chronicled in the original trilogy, a sudden attack by Wulf, a clever and ruthless Dunlending lord seeking vengeance for the death of his father, forces Helm Hammerhand and his people to make a daring last stand in the ancient stronghold of the Hornburg. Finding herself in an increasingly desperate situation, Héra, the daughter of Helm, must summon the will to lead the resistance against a deadly enemy intent on their total destruction.",
      "poster_path": "/hE9SAMyMSUGAPsHUGdyl6irv11v.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        16,
        14,
        28,
        12
      ],
      "popularity": 275.082,
      "release_date": "2024-12-05",
      "video": false,
      "vote_average": 6.5,
      "vote_count": 93
    },
    {
      "backdrop_path": "/iI0qvHy2uN1x2mhz1iCuK3HkMs7.jpg",
      "id": 975511,
      "title": "The Return",
      "original_title": "The Return",
      "overview": "After twenty years away, Odysseus washes up on the shores of Ithaca, haggard and unrecognizable. The king has finally returned home, but much has changed in his kingdom since he left to fight in the Trojan war.",
      "poster_path": "/xSj6EbdwHs3MFT2tRj9L3I7TE5j.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        36,
        18,
        12
      ],
      "popularity": 18.215,
      "release_date": "2024-09-07",
      "video": false,
      "vote_average": 6.7,
      "vote_count": 6
    },
    {
      "backdrop_path": "/H39NvEXz23GE9iYQ4qqV4w1zWn.jpg",
      "id": 728949,
      "title": "Nightbitch",
      "original_title": "Nightbitch",
      "overview": "A woman, thrown into the stay-at-home routine of raising a toddler in the suburbs, slowly embraces the feral power deeply rooted in motherhood, as she becomes increasingly aware of the bizarre and undeniable signs that she may be turning into a dog.",
      "poster_path": "/h49Pie8gM2jK0UHGFRjfPB3YTd.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        35,
        14
      ],
      "popularity": 25.682,
      "release_date": "2024-12-06",
      "video": false,
      "vote_average": 7.156,
      "vote_count": 16
    },
    {
      "backdrop_path": "/zOpe0eHsq0A2NvNyBbtT6sj53qV.jpg",
      "id": 939243,
      "title": "Sonic the Hedgehog 3",
      "original_title": "Sonic the Hedgehog 3",
      "overview": "Sonic, Knuckles, and Tails reunite against a powerful new adversary, Shadow, a mysterious villain with powers unlike anything they have faced before. With their abilities outmatched in every way, Team Sonic must seek out an unlikely alliance in hopes of stopping Shadow and protecting the planet.",
      "poster_path": "/nyEr1VqvKx1YiesMC3oTB2fZvpY.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        28,
        878,
        35,
        10751
      ],
      "popularity": 4205.224,
      "release_date": "2024-12-19",
      "video": false,
      "vote_average": 7.9,
      "vote_count": 143
    },
    {
      "backdrop_path": "/uWOJbarUXfVf6B4o0368dh138eR.jpg",
      "id": 426063,
      "title": "Nosferatu",
      "original_title": "Nosferatu",
      "overview": "A gothic tale of obsession between a haunted young woman and the terrifying vampire infatuated with her, causing untold horror in its wake.",
      "poster_path": "/5qGIxdEO841C0tdY8vOdLoRVrr0.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        18,
        14,
        27
      ],
      "popularity": 652.19,
      "release_date": "2024-12-25",
      "video": false,
      "vote_average": 6.7,
      "vote_count": 65
    },
    {
      "backdrop_path": "/lntyt4OVDbcxA1l7LtwITbrD3FI.jpg",
      "id": 1010581,
      "title": "My Fault",
      "original_title": "Culpa mía",
      "overview": "Noah must leave her city, boyfriend, and friends to move into William Leister's mansion, the flashy and wealthy husband of her mother Rafaela. As a proud and independent 17 year old, Noah resists living in a mansion surrounded by luxury. However, it is there where she meets Nick, her new stepbrother, and the clash of their strong personalities becomes evident from the very beginning.",
      "poster_path": "/w46Vw536HwNnEzOa7J24YH9DPRS.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "es",
      "genre_ids": [
        10749,
        18
      ],
      "popularity": 1637.392,
      "release_date": "2023-06-08",
      "video": false,
      "vote_average": 7.914,
      "vote_count": 3180
    },
    {
      "backdrop_path": "/uVlUu174iiKhsUGqnOSy46eIIMU.jpg",
      "id": 402431,
      "title": "Wicked",
      "original_title": "Wicked",
      "overview": "In the land of Oz, ostracized and misunderstood green-skinned Elphaba is forced to share a room with the popular aristocrat Glinda at Shiz University, and the two's unlikely friendship is tested as they begin to fulfill their respective destinies as Glinda the Good and the Wicked Witch of the West.",
      "poster_path": "/xDGbZ0JJ3mYaGKy4Nzd9Kph6M9L.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        18,
        10749,
        14
      ],
      "popularity": 672.43,
      "release_date": "2024-11-20",
      "video": false,
      "vote_average": 7.4,
      "vote_count": 670
    },
    {
      "backdrop_path": "/oHPoF0Gzu8xwK4CtdXDaWdcuZxZ.jpg",
      "id": 762509,
      "title": "Mufasa: The Lion King",
      "original_title": "Mufasa: The Lion King",
      "overview": "Told in flashbacks, Mufasa is an orphaned cub, lost and alone until he meets a sympathetic lion named Taka—the heir to a royal bloodline. The chance meeting sets in motion a journey of misfits searching for their destiny and working together to evade a threatening and deadly foe.",
      "poster_path": "/lurEK87kukWNaHd0zYnsi3yzJrs.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        12,
        10751,
        18,
        16
      ],
      "popularity": 3246.482,
      "release_date": "2024-12-18",
      "video": false,
      "vote_average": 7.089,
      "vote_count": 248
    },
    {
      "backdrop_path": "/5HlciYrJVOEtljDg2hn9KJHIIVz.jpg",
      "id": 1082195,
      "title": "The Order",
      "original_title": "The Order",
      "overview": "A string of violent robberies in the Pacific Northwest leads a veteran FBI agent into a domestic terrorist plot to overthrow the federal government.",
      "poster_path": "/1bJ2652AUnuK1WhlR0GLbJKVqMF.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        80,
        18,
        53
      ],
      "popularity": 247.657,
      "release_date": "2024-12-05",
      "video": false,
      "vote_average": 7,
      "vote_count": 41
    },
    {
      "backdrop_path": "/rhc8Mtuo3Kh8CndnlmTNMF8o9pU.jpg",
      "id": 1005331,
      "title": "Carry-On",
      "original_title": "Carry-On",
      "overview": "An airport security officer races to outsmart a mysterious traveler forcing him to let a dangerous item slip onto a Christmas Eve flight.",
      "poster_path": "/sjMN7DRi4sGiledsmllEw5HJjPy.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        28,
        53
      ],
      "popularity": 2194.15,
      "release_date": "2024-12-05",
      "video": false,
      "vote_average": 7.004,
      "vote_count": 1071
    },
    {
      "backdrop_path": "/abSLxmkkXb3W2TXk8E9KbR7KQRj.jpg",
      "id": 970450,
      "title": "Werewolves",
      "original_title": "Werewolves",
      "overview": "A year after a supermoon’s light activated a dormant gene, transforming humans into bloodthirsty werewolves and causing nearly a billion deaths, the nightmare resurfaces as the supermoon rises again. Two scientists attempt to stop the mutation but fail, leaving those exposed to the moonlight to once again become feral werewolves. Chaos engulfs the streets as the scientists struggle to reach one of their family homes, now under siege by the savage creatures.",
      "poster_path": "/elKf8Y5yi6Rl6teKsrQg0GAwaQD.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        28,
        27,
        53
      ],
      "popularity": 143.64,
      "release_date": "2024-12-04",
      "video": false,
      "vote_average": 6.5,
      "vote_count": 45
    },
    {
      "backdrop_path": "/4cp40IyTpFfsT2IKpl0YlUkMBIR.jpg",
      "id": 1064213,
      "title": "Anora",
      "original_title": "Anora",
      "overview": "A young sex worker from Brooklyn gets her chance at a Cinderella story when she meets and impulsively marries the son of an oligarch. Once the news reaches Russia, her fairytale is threatened as his parents set out to get the marriage annulled.",
      "poster_path": "/7MrgIUeq0DD2iF7GR6wqJfYZNeC.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        10749,
        35,
        18
      ],
      "popularity": 816.029,
      "release_date": "2024-10-14",
      "video": false,
      "vote_average": 7.1,
      "vote_count": 521
    },
    {
      "backdrop_path": "/t98L9uphqBSNn2Mkvdm3xSFCQyi.jpg",
      "id": 933260,
      "title": "The Substance",
      "original_title": "The Substance",
      "overview": "A fading celebrity decides to use a black market drug, a cell-replicating substance that temporarily creates a younger, better version of herself.",
      "poster_path": "/lqoMzCcZYEFK729d6qzt349fB4o.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        27,
        878,
        18
      ],
      "popularity": 841.085,
      "release_date": "2024-09-07",
      "video": false,
      "vote_average": 7.2,
      "vote_count": 2787
    },
    {
      "backdrop_path": "/tElnmtQ6yz1PjN1kePNl8yMSb59.jpg",
      "id": 1241982,
      "title": "Moana 2",
      "original_title": "Moana 2",
      "overview": "After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she's ever faced.",
      "poster_path": "/4YZpsylmjHbqeWzjKpUEF8gcLNW.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        16,
        12,
        10751,
        35
      ],
      "popularity": 3072.722,
      "release_date": "2024-11-21",
      "video": false,
      "vote_average": 7,
      "vote_count": 620
    },
    {
      "backdrop_path": "/cjEcqdRdPQJhYre3HUAc5538Gk8.jpg",
      "id": 845781,
      "title": "Red One",
      "original_title": "Red One",
      "overview": "After Santa Claus (codename: Red One) is kidnapped, the North Pole's Head of Security must team up with the world's most infamous tracker in a globe-trotting, action-packed mission to save Christmas.",
      "poster_path": "/cdqLnri3NEGcmfnqwk2TSIYtddg.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        28,
        14,
        35
      ],
      "popularity": 5083.147,
      "release_date": "2024-10-31",
      "video": false,
      "vote_average": 7.03,
      "vote_count": 1478
    },
    {
      "backdrop_path": "/Ar7QuJ7sJEiC0oP3I8fKBKIQD9u.jpg",
      "id": 98,
      "title": "Gladiator",
      "original_title": "Gladiator",
      "overview": "After the death of Emperor Marcus Aurelius, his devious son takes power and demotes Maximus, one of Rome's most capable generals who Marcus preferred. Eventually, Maximus is forced to become a gladiator and battle to the death against other men for the amusement of paying audiences.",
      "poster_path": "/ty8TGRuvJLPUmAR1H1nRIsgwvim.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        28,
        18,
        12
      ],
      "popularity": 444.195,
      "release_date": "2000-05-04",
      "video": false,
      "vote_average": 8.2,
      "vote_count": 18983
    },
    {
      "backdrop_path": "/3V4kLQg0kSqPLctI5ziYWabAZYF.jpg",
      "id": 912649,
      "title": "Venom: The Last Dance",
      "original_title": "Venom: The Last Dance",
      "overview": "Eddie and Venom are on the run. Hunted by both of their worlds and with the net closing in, the duo are forced into a devastating decision that will bring the curtains down on Venom and Eddie's last dance.",
      "poster_path": "/aosm8NMQ3UyoBVpSxyimorCQykC.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        28,
        878,
        12,
        53
      ],
      "popularity": 4113.845,
      "release_date": "2024-10-22",
      "video": false,
      "vote_average": 6.8,
      "vote_count": 1907
    },
    {
      "backdrop_path": "/qulnQ3Q4TcQuOqKbIlfqkJ4vh9g.jpg",
      "id": 1300962,
      "title": "The Beast Within",
      "original_title": "The Beast Within",
      "overview": "Ten-year-old Willow follows her parents on one of their secret late-night treks to the heart of an ancient forest. After witnessing her father undergo a terrible transformation, she too becomes ensnared by the dark ancestral secret that they've so desperately tried to conceal.",
      "poster_path": "/5RvNjlDufqUBH3iHBPb1cS53wXl.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        27,
        18,
        53
      ],
      "popularity": 147.794,
      "release_date": "2024-07-22",
      "video": false,
      "vote_average": 6,
      "vote_count": 92
    }
  ],
  "total_pages": 500,
  "total_results": 10000
}
*/ 