import 'package:clean_arc2/feature/weather/presentation/stateMangemant/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({super.key});

  final TextEditingController _searchController = TextEditingController(); // Controller for the search field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(), // Animated background with gradient
          Positioned(
            top: 50,
            
            left: 0,
            right: 0,
            child: theSearchBarWithButton(context), // Search bar with button
          ),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is LodingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else if (state is LodedState) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: Center(
                    child: WeatherInfo(context,state), // Centralized weather info with animations
                  ),
                );
              } else if (state is ErorrState) {
                return Center(
                  child: Text(state.massge.toString(),
                      style: const TextStyle(color: Colors.red, fontSize: 20)),
                );
              } else {
                return const Center(
                    child: Text("Something went wrong",
                        style: TextStyle(color: Colors.red, fontSize: 20)));
              }
            },
          ),
        ],
      ),
    );
  }

  // Search bar with button and animations
 Widget theSearchBarWithButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInExpo,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(60), // Rounded corners for the container
              color: Colors.white,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for a country",
                hintStyle: const TextStyle(color: Color.fromARGB(255, 65, 119, 155), fontSize: 16),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33), // Rounded corners for the TextField
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33), // Rounded corners when not focused
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33), // Rounded corners when focused
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              onSubmitted: (query) {
                // Handle search query submission here
                BlocProvider.of<WeatherBloc>(context).add(GetCountryWeatherEvent(country: query, region: ' '));
              },
            ),
          ),
        ),
        const SizedBox(width: 10), // Space between the search bar and the button
        GestureDetector(
          onTap: () {
            // Trigger GetRandomWeatherEvent when pressed
            BlocProvider.of<WeatherBloc>(context).add(GetRoandomeWeatherEvent());
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 58, 42, 202).withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Image.asset(
              "image/svg.png", // Path to the image
              height: 40, // Set height for the image
              width: 40, // Set width for the image
            ),
          ),
        ),
      ],
    ),
  );
}


  // Display weather information with animations
  // Display weather information with animations
Widget WeatherInfo(BuildContext context,LodedState state) {
  // Define an animation controller for slide transition
  final animationController = AnimationController(
    vsync: Scaffold.of(context), // Add this line for proper vsync
    duration: const Duration(milliseconds: 1000),
  );
  final animation = Tween<Offset>(
    begin: const Offset(0, 1), // Slide in from below
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ),
  );

  // Trigger animation when the widget is built
  animationController.forward();

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Fade-in animation for the country and region text
      AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 500),
        child: SlideTransition(
          position: animation,
          child: Text(
            "${state.weather.country}, ${state.weather.region}",
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      const SizedBox(height: 10),

      // Fade-in animation for temperature
      AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 800),
        child: SlideTransition(
          position: animation,
          child: Text(
            "${state.weather.temp_c}°C",
            style: const TextStyle(
                color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      const SizedBox(height: 10),

      // Fade-in animation for wind speed
      AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 1100),
        child: SlideTransition(
          position: animation,
          child: Text(
            "Wind: ${state.weather.wind_kph} kph",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      
      // UV index and humidity text
      AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 1300),
        child: SlideTransition(
          position: animation,
          child: Text(
            "UV Index: ${state.weather.uv}",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 1500),
        child: SlideTransition(
          position: animation,
          child: Text(
            "Humidity: ${state.weather.humidity}%",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    ],
  );
}


  // Gradient background with subtle animation
  Widget AnimatedBackground() {
    return AnimatedContainer(
      duration: const Duration(seconds: 5),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 5, 79, 197), // Dark blue at the top
            Color.fromARGB(255, 141, 190, 209), // Lighter blue at the bottom
          ],
        ),
      ),
    );
  }
}
